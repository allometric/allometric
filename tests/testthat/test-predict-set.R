fixed_effects_model <- FixedEffectsModel(
  response = list(
    vsia = units::as_units("ft^3")
  ),
  covariates = list(
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

fixed_effects_model_2 <- FixedEffectsModel(
  response = list(vsia = units::as_units("ft^3")),
  covariates = list(dsob = units::as_units("in")),
  parameters = list(a = 2),
  predict_fn = function(dsob) {
    a * dsob^2
  }
)

fixed_effects_model_2covt <- FixedEffectsModel(
  response = list(vsia = units::as_units("ft^3")),
  covariates = list(
    dsob = units::as_units("in"),
    hst = units::as_units("ft")
  ),
  parameters = list(a = 1, b = 1),
  predict_fn = function(dsob, hst) {
    a * dsob + b * hst
  }
)

test_that("predict on a list applies each model to its row", {
  models <- list(fixed_effects_model, fixed_effects_model_2)
  out <- predict(models, c(1, 2))

  expect_s3_class(out, "units")
  expect_equal(as.numeric(out), c(1, 8))
})

test_that("predict on a list accepts named covariates", {
  models <- list(fixed_effects_model, fixed_effects_model_2)
  out <- predict(models, dsob = c(1, 2))

  expect_equal(as.numeric(out), c(1, 8))
})

test_that("named covariates are matched regardless of argument order", {
  models <- list(fixed_effects_model_2covt, fixed_effects_model)
  out <- predict(models, hst = c(3, 1), dsob = c(2, 1))

  expect_equal(as.numeric(out), c(5, 1))
})

test_that("models with fewer covariates ignore extra named covariates", {
  models <- list(fixed_effects_model_2covt, fixed_effects_model)
  out <- predict(models, dsob = c(2, 1), hst = c(3, 1))

  expect_equal(as.numeric(out), c(5, 1))
})

test_that("missing covariates produce NA with a warning", {
  models <- list(fixed_effects_model_2covt, fixed_effects_model)
  expect_warning(
    out <- predict(models, dsob = c(2, 1)),
    "requires covariates not supplied: hst"
  )
  expect_equal(as.numeric(out), c(NA, 1))
})

test_that("NA models produce NA", {
  out <- predict(list(fixed_effects_model, NA), dsob = c(1, 1))
  expect_equal(as.numeric(out), c(1, NA))
})

test_that("unnamed covariates not used by any model produce a warning", {
  expect_warning(
    out <- predict(list(fixed_effects_model), dsob = 1, xyz = 2),
    "not used by any model: xyz"
  )
  expect_equal(as.numeric(out), 1)
})

test_that("mixed named and unnamed covariates produce an error", {
  expect_error(
    predict(list(fixed_effects_model), dsob = 1, 2),
    "all named or all unnamed"
  )
})

test_that("sets with different covariate requirements warn when unnamed", {
  models <- list(fixed_effects_model, fixed_effects_model_2covt)
  expect_warning(
    try(predict(models, 1, 1), silent = TRUE),
    "different covariate requirements"
  )
})

test_that("covariate arguments are recycled to the number of models", {
  models <- list(fixed_effects_model, fixed_effects_model_2)
  out <- predict(models, dsob = 10)

  expect_equal(as.numeric(out), c(100, 200))
})

test_that("a single model is predicted vectorized", {
  out <- predict(list(fixed_effects_model), dsob = c(1, 2, 3))
  expect_equal(as.numeric(out), c(1, 4, 9))
})

test_that("output_units converts the combined predictions", {
  models <- list(fixed_effects_model, fixed_effects_model_2)
  out <- predict(models, dsob = c(1, 2), output_units = "m^3")

  expect_equal(as.numeric(out), c(0.028316846592, 0.226534772736), tolerance = 1e-9)
})

test_that("predict on a model_tbl forwards to the model column", {
  test_model_tbl <- new_model_tbl(
    tibble::tibble(
      model = list(fixed_effects_model, fixed_effects_model_2),
      dsob = c(1, 2)
    )
  )

  out <- predict(test_model_tbl, dsob = test_model_tbl$dsob)
  expect_equal(as.numeric(out), c(1, 8))
})

test_that("predict on a model_tbl without a model column errors", {
  test_model_tbl <- new_model_tbl(tibble::tibble(dsob = c(1, 2)))
  expect_error(predict(test_model_tbl, dsob = 1), "no 'model' column")
})
