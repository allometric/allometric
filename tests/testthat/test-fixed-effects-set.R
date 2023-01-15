fixed_effects_set <- FixedEffectsSet(
  response_unit = list(
    vsa = units::as_units('ft^3')
  ),
  covariate_units = list(
    dsob = units::as_units('in')
  ),
  predict_fn = function(dsob) {
    a * dsob^2
  },
  parameter_names = 'a',
  model_specifications = tibble::tibble(a = c(1,2)),
  descriptors = list(
    test = 'test_value'
  )
)

test_that("FixedEffectsSet adds models", {
  expect_equal(length(fixed_effects_set@models), 2)
})

test_that("FixedEffectsSet with mis-specified parameter names is invalid.", {
  expect_error(FixedEffectsSet(
    response_unit = list(
      vsa = units::as_units('ft^3')
    ),
    covariate_units = list(
      dsob = units::as_units('in')
    ),
    predict_fn = function(dsob) {
      a * dsob^2
    },
    parameter_names = 'b',
    model_specifications = tibble::tibble(b = c(1,2)),
    descriptors = list(
      test = 'test_value'
    )
  ), "Named parameters are not found in the predict_fn body.")
})

test_that("FixedEffectsSet's models can predict", {
  expect_equal(predict(fixed_effects_set@models[[1]], 1), 1 * 1^2)
  expect_equal(predict(fixed_effects_set@models[[2]], 1), 2 * 1^2)
})

fixed_effects_covt_override <- FixedEffectsSet(
  response_unit = list(
    vsa = units::as_units('ft^3')
  ),
  covariate_units = list(
    dsob = units::as_units('in')
  ),
  predict_fn = function(dsob) {
    a * dsob^2
  },
  parameter_names = 'a',
  model_specifications = tibble::tibble(a = c(1,2)),
  descriptors = list(
    test = 'test_value'
  ),
  covariate_definitions = list(
    dsob = 'my def'
  )
)

test_that("FixedEffectsSet with custom covariates produces correct description", {
  desc <- .get_variable_descriptions(fixed_effects_covt_override)
  dsob_desc <- paste('dsob [in]:', 'my def')

  expect_equal(desc[[2]], dsob_desc)
})

