test_that("Invalid country returns error", {
  expect_error(
    AllometricModel(
      response_unit = list(vsia = units::as_units("ft^3")),
      covariate_units = list(dsob = units::as_units("in")),
      predict_fn = function(dsob) {
        dsob
      },
      descriptors = list(country = "bad-country-code")
    )
  )
})

allo_mod <- AllometricModel(
  response_unit = list(vsia = units::as_units("ft^3")),
  covariate_units = list(dsob = units::as_units("in")),
  predict_fn = function(dsob) {
    dsob
  }
)

test_that("Get measure name is correct", {
  expect_equal(get_measure_name(allo_mod), "volume")
})

test_that("Get component label is correct", {
  expect_equal(get_component_name(allo_mod), "stem")
})

# TODO produces a warning, but a fairly inconsequential test...
# test_that("Cite returns a string", {
#  expect_equal(Cite(allo_mod), "(, )")
# })

my_custom_dsob_description <- "diameter of the stem outside bark at breast height, but slightly different!"

allo_custom_override <- AllometricModel(
  response_unit = list(vsia = units::as_units("ft^3")),
  covariate_units = list(dsob = units::as_units("in")),
  predict_fn = function(dsob) {
    dsob
  },
  covariate_definitions = list(
    dsob = my_custom_dsob_description
  )
)

test_that("Custom covariate definition is propagated to summary", {
  desc <- .get_variable_descriptions_fmt(allo_custom_override)

  expect_equal(desc[[2]], paste("dsob [in]:", my_custom_dsob_description))
})

allo_increment <- AllometricModel(
  response_unit = list(i_vsia = units::as_units("ft")),
  covariate_units = list(dsob = units::as_units("in")),
  predict_fn = function(dsob) {
    dsob
  }
)

test_that("Increment model returns correct model type", {
  expect_equal(allo_increment@model_type, "stem volume increment")
})