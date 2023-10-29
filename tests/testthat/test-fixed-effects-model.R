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

test_that("Fixed effects model predicts correctly.", {
  pred <- predict(fixed_effects_model, 1)

  val <- 1
  units(val) <- 'ft^3'

  expect_equal(pred, val)
})

test_that("Fixed effects model_call returns correctly formatted string", {
  expect_equal(model_call(fixed_effects_model), "vsia = f(dsob)")
})


unitless_model <- FixedEffectsModel(
  response = list(
    vsia = units::as_units("ft^3")
  ),
  covariates = list(
    dsob = units::unitless
  ),
  parameters = list(
    a = 1
  ),
  predict_fn = function(dsob) {
    intermediate <- dsob + 1
    a * dsob^2
  }
)

test_that("Model specified with units::unitless returns correct covariate formatting", {
  match_str <- "dsob []: diameter of the stem, outside bark at breast height"
  expect_equal(match_str, .get_variable_descriptions_fmt(unitless_model)[[2]])
})

test_that("Identical fixed effects models are equal", {
  expect_equal(fixed_effects_model, fixed_effects_model)
})


test_that("Different fixed effects models are equal", {
  expect_equal(fixed_effects_model == unitless_model, FALSE)
})