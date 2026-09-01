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

test_that("Models with different response definitions are not equal", {
  mk <- function(res_def) {
    FixedEffectsModel(
      response = list(vsia = units::as_units("ft^3")),
      covariates = list(dsob = units::as_units("in")),
      parameters = list(a = 1),
      predict_fn = function(dsob) a * dsob,
      response_definition = res_def
    )
  }
  expect_equal(mk("definition A") == mk("definition B"), FALSE)
  expect_equal(mk("definition A") == mk("definition A"), TRUE)
})

test_that("Models with swapped parameter values are not equal", {
  mk <- function(a_val, b_val) {
    FixedEffectsModel(
      response = list(vsia = units::as_units("ft^3")),
      covariates = list(dsob = units::as_units("in")),
      parameters = list(a = a_val, b = b_val),
      predict_fn = function(dsob) a * dsob + b
    )
  }
  expect_equal(mk(1, 2) == mk(2, 1), FALSE)
  expect_equal(mk(1, 2) == mk(1, 2), TRUE)
})

test_that("Models with different covariate names are not equal", {
  mk <- function(cov_name) {
    covariates <- list(dsob = units::as_units("in"))
    names(covariates) <- cov_name
    FixedEffectsModel(
      response = list(vsia = units::as_units("ft^3")),
      covariates = covariates,
      parameters = list(a = 1),
      predict_fn = function(dsob) a * dsob
    )
  }
  expect_equal(mk("dsob") == mk("hst"), FALSE)
  expect_equal(mk("dsob") == mk("dsob"), TRUE)
})