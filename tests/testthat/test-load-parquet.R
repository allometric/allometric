# Tests for the v4 parquet loader (load_models and the model_tbl it produces).
# The vendored dist/ files under inst/models-main are the corpus under test.

models <- load_models()

test_that("load_models returns a model_tbl with the expected shape", {
  expect_s3_class(models, "model_tbl")
  expect_equal(nrow(models), 2409)

  expect_named(
    models,
    c(
      "id", "spec_index", "model_name", "model_type", "pub_id", "pub_year",
      "family_name", "covt_name", "taxa", "region", "component", "model"
    )
  )

  expect_true(all(vapply(models$model, is, logical(1), "FixedEffectsModel")))
  expect_true(all(nchar(models$id) == 8))
})

test_that("a known model predicts the expected value", {
  barnes <- dplyr::filter(models, pub_id == "barnes_1962")
  expect_equal(nrow(barnes), 1)

  pred <- predict(barnes$model[[1]], atb = 20, hst = 50)
  expect_equal(as.numeric(pred), 41.78136, tolerance = 1e-5)
  expect_equal(units::deparse_unit(pred), "ft")

  expect_equal(model_call(barnes$model[[1]]), "hstix50 = f(atb, hst)")
  expect_equal(barnes$id[[1]], "1de6301a")
})

test_that("select_model works by the v4 content-hash id", {
  barnes_id <- dplyr::filter(models, pub_id == "barnes_1962")$id[[1]]

  mod_ix <- select_model(models, 1)
  mod_id <- select_model(models, barnes_id)

  expect_s4_class(mod_ix, "FixedEffectsModel")
  expect_s4_class(mod_id, "FixedEffectsModel")
  expect_equal(mod_id, mod_ix)
})

test_that("boolean pub descriptors (country: false) are dropped, not validated", {
  # sharma_2015 declares country: false in its publication descriptors; the
  # corpus means "not specified", so the model must load with no country
  # descriptor rather than fail the ISO country-code validity check.
  sharma <- dplyr::filter(models, pub_id == "sharma_2015", model_name == "hst")
  expect_gt(nrow(sharma), 0)
  expect_true(all(vapply(
    sharma$model,
    function(m) !"country" %in% names(m@descriptors),
    logical(1)
  )))
})

test_that("taxa and region are searchable list columns", {
  pinus_models <- dplyr::filter(models, purrr::map_lgl(taxa, ~ "Pinus" %in% .))
  expect_gt(nrow(pinus_models), 0)
  expect_true(all(purrr::map_lgl(pinus_models$taxa, ~ "Pinus" %in% .)))
  expect_true(all(vapply(pinus_models$taxa, function(t) is(t, "Taxa"), logical(1))))

  us_co_models <- dplyr::filter(models, purrr::map_lgl(region, ~ "US-CO" %in% .))
  expect_gt(nrow(us_co_models), 0)
  expect_true(all(purrr::map_lgl(us_co_models$region, ~ "US-CO" %in% .)))
})

test_that("numeric descriptors declared as coefficients are substituted", {
  # kozak_1988 dsih stores the relative-height position `p` as a descriptor;
  # the prediction function requires it, so it must be substituted numerically.
  kozak <- dplyr::filter(models, pub_id == "kozak_1988", model_name == "dsih")

  pred <- predict(kozak$model[[1]], hst = 20, hsd = 5, dsob = 15)
  expect_true(is.finite(as.numeric(pred)))
  expect_equal(units::deparse_unit(pred), "cm")
})

test_that("character descriptor qualifiers are not substituted", {
  # bruce_1974 vsia has the descriptor hst = "<= 18 ft hst", which must not
  # replace the hst covariate in the prediction function.
  bruce <- dplyr::filter(models, pub_id == "bruce_1974", model_name == "vsia")

  pred <- predict(bruce$model[[1]], hst = 20, dsob = 10)
  expect_true(is.finite(as.numeric(pred)))
  expect_equal(units::deparse_unit(pred), "ft3")
})

test_that("load_models filters by model_type", {
  ht <- load_models(model_type = "stem height")
  expect_s3_class(ht, "model_tbl")
  expect_gt(nrow(ht), 0)
  expect_lt(nrow(ht), nrow(models))
  expect_true(all(ht$model_type == "stem height"))
})

test_that("load_models falls back to publication-level regions", {
  # rustagi_1991 declares region at the publication level (US-OR, US-WA,
  # CA-BC); its specs carry no region of their own, so the effective region
  # must fall back to the publication's or region filters silently miss them.
  or <- load_models(region = "US-OR")
  expect_gt(nrow(or), 0)
  expect_true(all(vapply(or$region, function(r) "US-OR" %in% r, logical(1))))

  rustagi <- dplyr::filter(or, pub_id == "rustagi_1991")
  expect_gt(nrow(rustagi), 0)
  expect_true(all(vapply(
    rustagi$region,
    function(r) all(c("US-OR", "US-WA", "CA-BC") %in% r),
    logical(1)
  )))

  vol <- load_models(model_type = "stem volume", region = "US-OR")
  expect_gt(nrow(vol), 0)
  expect_true(all(vol$model_type == "stem volume"))
})

test_that("load_models filters by country", {
  ca <- load_models(country = "CA")
  expect_gt(nrow(ca), 0)
  expect_true(all(vapply(
    ca$region, function(r) any(sub("-.*", "", r) %in% "CA"), logical(1)
  )))
})

test_that("load_models combines filters and matches the full table", {
  subset <- load_models(country = "US", region = "US-CO", model_type = "stem volume")
  expect_s3_class(subset, "model_tbl")
  expect_gt(nrow(subset), 0)

  # The subset must equal the corresponding filter of the full table.
  expected <- dplyr::filter(
    models,
    purrr::map_lgl(region, ~ any(sub("-.*", "", .) %in% "US" & "US-CO" %in% .)),
    model_type == "stem volume"
  )
  expect_equal(nrow(subset), nrow(expected))
  expect_setequal(subset$id, expected$id)
})

test_that("load_models warns and returns empty when no models match", {
  expect_warning(
    res <- load_models(region = "US-CO", model_type = "crown ratio"),
    "No models match"
  )
  expect_s3_class(res, "model_tbl")
  expect_equal(nrow(res), 0)
})

test_that("load_models rejects unknown filter values", {
  expect_error(load_models(region = "XX-YY"), "region value\\(s\\) not found")
  expect_error(load_models(country = "ZZ"), "country value\\(s\\) not found")
  expect_error(load_models(model_type = "bogus"), "model_type value\\(s\\) not found")
})

test_that("load_models treats empty filter arguments as no filter", {
  expect_equal(nrow(load_models(model_type = character(0))), nrow(models))
  expect_equal(nrow(load_models(country = NULL, region = NULL)), nrow(models))
})
