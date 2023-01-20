fixed_effects_model <- FixedEffectsModel(
  response_unit = list(
    vsa = units::as_units("ft^3")
  ),
  covariate_units = list(
    dsob = units::as_units("in")
  ),
  parameters = list(
    a = 1
  ),
  predict_fn = function(dsob) {
    intermediate <- dsob + 1
    a * dsob^2
  }
)


test_that("a tibble can make a model_tbl", {
  expect_s3_class(new_model_tbl(
    tibble::tibble(a=1)
  ), "model_tbl")
})

model_tbl_good <- new_model_tbl(
  tibble::tibble(
    model = list(fixed_effects_model),
    country = "test",
    id = 'this_id'
  )
)

model_tbl_bad <- new_model_tbl(
  tibble::tibble(
    bad = list(fixed_effects_model)
  )
)


test_that("model_tbl can reconstruct if model column", {
  expect_true(model_tbl_can_reconstruct(model_tbl_good))
})

test_that("model_tbl cannot reconstruct if no model column", {
  expect_false(model_tbl_can_reconstruct(model_tbl_bad))
})

test_that("df_reconstruct creates a new data.frame with new attributes", {
  test_df <- data.frame(a=1)
  test_to <- data.frame(b=1)

  expect_error(df_reconstruct(test_df, test_to), NA)
})

test_that("new_bare_tibble runs", {
  expect_error(new_bare_tibble(model_tbl_good), NA)
})


test_that("model_tbl_reconstruct returns model_tbl for good model_tbl", {
  expect_s3_class(model_tbl_reconstruct(model_tbl_good, model_tbl_good), "model_tbl")
})

test_that("model_tbl_reconstruct returns tibble for bad model_tbl", {
  expect_s3_class(model_tbl_reconstruct(model_tbl_bad, model_tbl_bad), "tbl_df")
})

test_that("indexing returns model_tbl", {
  expect_s3_class(model_tbl_good[1,], "model_tbl")
})


test_that("modifying names model_tbl", {
  names(model_tbl_good) <- c("model", "test", "id")
  expect_s3_class(model_tbl_good, "model_tbl")
})

test_that("select_model returns model", {
  mod_ix <- select_model(model_tbl_good, 1)
  mod_id <- select_model(model_tbl_good, "this_id")
  expect_s4_class(mod_ix, "FixedEffectsModel")
  expect_s4_class(mod_id, "FixedEffectsModel")
})

test_that("unnest_cross unnests all columns", {
  test_tbl <- tibble::tibble(
    a = list(c(1), c(1,2)),
    b = list(c(1), c(1,2))
  )

  unnested <- unnest_cross(test_tbl, c('a', 'b'))

  expect_equal(nrow(unnested), 5)
})

test_that("unnest models returns a model_tbl", {
  unnested <- unnest_models(model_tbl_good, 'country')
  expect_s3_class(unnested, "model_tbl")
})

test_that("predict_allo produces predictions", {
  test_model_tbl <- new_model_tbl(
    tibble::tibble(models = c(fixed_effects_model), dsob = 1))

  out <- predict_allo(test_model_tbl$models, test_model_tbl$dsob)
  expect_equal(out, 1)
})
