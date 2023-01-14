fixed_effects_model <- FixedEffectsModel(
  response_unit = list(
    vsa = units::as_units('ft^3')
  ),
  covariate_units = list(
    dsob = units::as_units('in')
  ),
  parameters = list(
    a = 1
  ),
  predict_fn = function(dsob) {
    intermediate <- dsob + 1
    a * dsob^2
  }
)

test_that("Fixed effects model predicts correctly.", {
  pred <- predict(fixed_effects_model, 1)
  expect_equal(pred, 1)
})

test_that("Using a nested list as descriptor throws error.", {
  expect_error(
    FixedEffectsModel(
      response_unit = list(vsa = units::as_units('ft^3')),
      covariate_units = list(dsob = units::as_units('in')),
      parameters = list(a = 1),
      predict_fn = function(dsob) {a * dsob},
      descriptors = list(test = list(a = 1, b = 2))
    ),
    "Descriptors must be coercible to a one-row tbl_df."
  )
})

test_that("Columns with lists as their elements throws an error", {
  expect_error(
    FixedEffectsModel(
      response_unit = list(vsa = units::as_units('ft^3')),
      covariate_units = list(dsob = units::as_units('in')),
      parameters = list(a = 1),
      predict_fn = function(dsob) {a * dsob},
      descriptors = tibble::tibble(a = list(list(1,2,3)))
    ),
    "Non-atomic descriptor:"
  )
})

test_that("Fixed effects model_call returns correctly formatted string", {
  expect_equal(model_call(fixed_effects_model), "vsa = f(dsob)")
})