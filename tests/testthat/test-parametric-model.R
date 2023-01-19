param_mod <- ParametricModel(
  response_unit = list(vsa = units::as_units("ft^3")),
  covariate_units = list(dsob = units::as_units("in")),
  predict_fn = function(dsob) {
    dsob * a
  },
  parameters = list(a = 1),
  descriptors = list(country = "US")
)


test_that("specification returns correct tbl", {
  test_tbl <- tibble::tibble(country="US", a=1)
  expect_equal(test_tbl, specification(param_mod))
})

test_that("parameters returns correct tbl", {
  test_params <- tibble::tibble(a=1)
  expect_equal(test_params, parameters(param_mod))
})

test_that("model_call returns correct string", {
  test_call <- "vsa = f(dsob)"

  expect_equal(test_call, model_call(param_mod))
})

test_that("get_model_str returns correct string", {
  test_str <- "vsa = dsob * a"
  expect_equal(test_str, get_model_str(param_mod))
})

test_that("show method runs for parametric model", {
  expect_error(invisible(capture.output(show(param_mod))), NA)
})

test_that("get_variable_descriptions returns correct strings", {
  descs <- get_variable_descriptions(param_mod)

  expect_equal(
    descs[[1]],
    "vsa [ft3]: volume of the entire stem, including top and stump"
  )

  expect_equal(
    descs[[2]],
    "dsob [in]: diameter of the stem, outside bark at breast height"
  )
})