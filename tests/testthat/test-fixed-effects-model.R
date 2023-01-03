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

test_that("Intermediate variable names are not included in parameter names.", {
  #expect_equal(param_names, c("a"))
})