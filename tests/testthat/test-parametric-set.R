parametric_set <- ParametricSet(
  response_unit = list(
    "vsia" = units::as_units("ft^3")
  ),
  covariate_units = list(
    "dsob" = units::as_units("in")
  ),
  parameter_names = "a",
  predict_fn = function(dsob) {
    a * dsob
  },
  model_specifications = tibble::tibble(
    mod_name = c("mod_1", "mod_2"),
    a = c(1, 2)
  )
)

test_that("get_model_str works for ParametricSet", {
  expect_equal("vsia = a * dsob", get_model_str(parametric_set))
})

test_that("model_call works for ParametricSet", {
  expect_equal("vsia = f(dsob)", model_call(parametric_set))
})

test_that("parameters returns a tibble of parameters for ParametricSet", {
  expectation <- tibble::tibble(a = c(1, 2))

  expect_equal(expectation, parameters(parametric_set))
})

test_that("specification returns a tibble of specifications for ParametricSet", {
  expectation <- tibble::tibble(mod_name = c("mod_1", "mod_2"), a = c(1, 2))

  expect_equal(expectation, specification(parametric_set))
})