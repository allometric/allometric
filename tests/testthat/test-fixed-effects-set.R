fixed_effects_set <- FixedEffectsSet(
  response = list(
    vsia = units::as_units("ft^3")
  ),
  covariates = list(
    dsob = units::as_units("in")
  ),
  predict_fn = function(dsob) {
    a * dsob^2
  },
  parameter_names = "a",
  model_specifications = tibble::tibble(mod = c(1,2), a = c(1, 2)),
  descriptors = list(
    test = "test_value"
  )
)

test_that("FixedEffectsSet adds models", {
  expect_equal(length(fixed_effects_set@models), 2)
})

test_that("FixedEffectsSet with mis-specified parameter names is invalid.", {
  expect_error(FixedEffectsSet(
    response = list(
      vsia = units::as_units("ft^3")
    ),
    covariates = list(
      dsob = units::as_units("in")
    ),
    predict_fn = function(dsob) {
      a * dsob^2
    },
    parameter_names = "b",
    model_specifications = tibble::tibble(b = c(1, 2)),
    descriptors = list(
      test = "test_value"
    )
  ), "Named parameters are not found in the predict_fn body.")
})

test_that("FixedEffectsSet's models can predict", {
  val1 <- 1 * 1^2
  units(val1) <- "ft^3"

  val2 <- 2 * 1^2
  units(val2) <- "ft^3"

  expect_equal(predict(fixed_effects_set@models[[1]], 1), val1)
  expect_equal(predict(fixed_effects_set@models[[2]], 1), val2)
})

fixed_effects_covt_override <- FixedEffectsSet(
  response = list(
    vsia = units::as_units("ft^3")
  ),
  covariates = list(
    dsob = units::as_units("in")
  ),
  predict_fn = function(dsob) {
    a * dsob^2
  },
  parameter_names = "a",
  model_specifications = tibble::tibble(mod=c(1,2), a = c(1, 2)),
  descriptors = list(
    test = "test_value"
  ),
  covariate_definitions = list(
    dsob = "my def"
  )
)

test_that("FixedEffectsSet with custom covariates produces correct description", {
  desc <- .get_variable_descriptions_fmt(fixed_effects_covt_override)
  dsob_desc <- paste("dsob [in]:", "my def")

  expect_equal(desc[[2]], dsob_desc)
})
