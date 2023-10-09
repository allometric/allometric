mixed_effects_set <- MixedEffectsSet(
  response = list(
    vsia = units::as_units("ft^3")
  ),
  covariates = list(
    dsob = units::as_units("in")
  ),
  parameter_names = "a",
  predict_ranef = function(dsob, hst) {
    list(a_i = 1)
  },
  predict_fn = function(dsob) {
    (a + a_i) * dsob^2
  },
  model_specifications = tibble::tibble(a = c(1, 2))
)

test_that("MixedEffectsSet adds models", {
  expect_equal(length(mixed_effects_set@models), 2)
})

test_that("MixedEffectsSet with mis-specified parameter names is invalid.", {
  expect_error(
    MixedEffectsSet(
      response = list(
        vsia = units::as_units("ft^3")
      ),
      covariates = list(
        dsob = units::as_units("in")
      ),
      parameter_names = "c",
      predict_ranef = function(dsob, hst) {
        list(a_i = 1)
      },
      predict_fn = function(dsob) {
        (a + a_i) * dsob^2
      },
      model_specifications = tibble::tibble(a = c(1, 2))
    ),
    "Named parameters are not found in the predict_fn and predict_ranef bodies."
  )
})
