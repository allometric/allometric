# Tests for extract_descriptors(), which widens the per-model descriptors of a
# model_tbl into columns.

model_with <- function(descriptors) {
  FixedEffectsModel(
    response = list(vsia = units::as_units("ft^3")),
    covariates = list(dsob = units::as_units("in")),
    parameters = list(a = 1),
    predict_fn = function(dsob) a * dsob^2,
    descriptors = descriptors
  )
}

extract_tbl <- new_model_tbl(
  tibble::tibble(
    id = c("a", "b", "c"),
    model = list(
      model_with(list(country = "US", proc_group = "taxa")),
      model_with(list(country = "CA", p = 0.25)),
      model_with(list(region = c("US-OR", "US-WA")))
    )
  )
)

test_that("scalar descriptors widen into atomic columns with NA for absent rows", {
  out <- extract_descriptors(extract_tbl, country, proc_group, p)

  expect_s3_class(out, "model_tbl")
  expect_equal(nrow(out), 3)
  expect_equal(out$country, c("US", "CA", NA))
  expect_equal(out$proc_group, c("taxa", NA, NA))
  expect_equal(out$p, c(NA, 0.25, NA))
  # requested columns are appended after the existing ones
  expect_named(out, c("id", "model", "country", "proc_group", "p"))
  # the model column is untouched, so the table stays usable
  expect_identical(out$model, extract_tbl$model)
})

test_that("descriptors multi-valued anywhere become list columns", {
  out <- extract_descriptors(extract_tbl, region)

  expect_type(out$region, "list")
  expect_equal(out$region[[1]], NULL) # row a lacks region
  expect_equal(out$region[[2]], NULL) # row b lacks region
  expect_equal(out$region[[3]], c("US-OR", "US-WA"))
})

test_that("list-valued cells are preserved when a multi-valued key is extracted", {
  multi_tbl <- new_model_tbl(
    tibble::tibble(
      model = list(
        model_with(list(country = "US")),
        model_with(list(country = c("US", "CA")))
      )
    )
  )

  out <- extract_descriptors(multi_tbl, country)

  expect_type(out$country, "list")
  expect_equal(out$country[[1]], "US")
  expect_equal(out$country[[2]], c("US", "CA"))
})

test_that("descriptor columns already in the table are not duplicated", {
  tbl_with_region <- new_model_tbl(
    tibble::tibble(
      id = "a",
      region = list(c("US-OR")),
      model = list(model_with(list(region = c("US-OR"), country = "US")))
    )
  )

  out <- extract_descriptors(tbl_with_region, region, country)

  # region already exists and is returned unchanged (single column, no
  # suffix), while the not-yet-exposed country column is added
  expect_named(out, c("id", "region", "model", "country"))
  expect_identical(out$region, tbl_with_region$region)
  expect_equal(out$country, "US")
})

test_that("selecting nothing errors with the available descriptors", {
  expect_error(
    extract_descriptors(extract_tbl),
    "select at least one descriptor.*Available descriptors: .*country"
  )
})

test_that("unknown descriptors error with the available descriptors", {
  expect_error(
    extract_descriptors(extract_tbl, bogus_key),
    "Available descriptors: .*country"
  )
})

test_that("tidyselect helpers work", {
  out <- extract_descriptors(extract_tbl, dplyr::any_of(c("country", "nope")))
  expect_equal(out$country, c("US", "CA", NA))

  out_all <- extract_descriptors(extract_tbl, dplyr::all_of("p"))
  expect_equal(out_all$p, c(NA, 0.25, NA))
})

test_that("tables without a model column error", {
  expect_error(
    extract_descriptors(new_model_tbl(tibble::tibble(a = 1)), a),
    "must contain a `model` column"
  )
})

test_that("rows that are not individual models error informatively", {
  bad_tbl <- new_model_tbl(
    tibble::tibble(model = list(model_with(list(country = "US")), 1))
  )

  expect_error(
    extract_descriptors(bad_tbl, country),
    "individual models; row 2"
  )
})

test_that("predicting a widened model_tbl still works", {
  out <- extract_descriptors(extract_tbl, country)

  pred <- predict(out, dsob = 10)
  expect_length(pred, 3)
  expect_equal(as.numeric(pred[[1]]), 100)
})
