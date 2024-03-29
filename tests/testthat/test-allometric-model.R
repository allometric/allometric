test_that("Invalid country returns error", {
  expect_error(
    AllometricModel(
      response = list(vsia = units::as_units("ft^3")),
      covariates = list(dsob = units::as_units("in")),
      predict_fn = function(dsob) {
        dsob
      },
      descriptors = list(country = "bad-country-code")
    )
  )
})

allo_mod <- AllometricModel(
  response = list(vsia = units::as_units("ft^3")),
  covariates = list(dsob = units::as_units("in")),
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

my_custom_dsob_definition <- "diameter of the stem outside bark at breast height, but slightly different!"

allo_custom_covt_override <- AllometricModel(
  response = list(vsia = units::as_units("ft^3")),
  covariates = list(dsob = units::as_units("in")),
  predict_fn = function(dsob) {
    dsob
  },
  covariate_definitions = list(
    dsob = my_custom_dsob_definition
  )
)

test_that("Custom covariate definition is propagated to summary", {
  desc <- .get_variable_descriptions_fmt(allo_custom_covt_override)

  expect_equal(desc[[2]], paste("dsob [in]:", my_custom_dsob_definition))
})


my_custom_vsia_definition <- "volume of the stem inside bark, but slightly different!"

allo_custom_response_override <- AllometricModel(
  response = list(vsia = units::as_units("ft^3")),
  covariates = list(dsob = units::as_units("in")),
  predict_fn = function(dsob) {
    dsob
  },
  response_definition = my_custom_vsia_definition
)

test_that("Custom response definition is propagated to summary", {
  desc <- .get_variable_descriptions_fmt(allo_custom_response_override)
  expect_equal(desc[[1]], paste("vsia [ft3]:", my_custom_vsia_definition))
})

allo_increment <- AllometricModel(
  response = list(i_vsia = units::as_units("ft")),
  covariates = list(dsob = units::as_units("in")),
  predict_fn = function(dsob) {
    dsob
  }
)

test_that("Increment model returns correct model type", {
  expect_equal(allo_increment@model_type, "stem volume increment")
})

test_that("Model with nested list of descriptors runs", {
  expect_no_error(AllometricModel(
    response = list(vsia = units::as_units("ft^3")),
    covariates = list(dsob = units::as_units("in")),
    predict_fn = function(dsob) a * dsob,
    descriptors = list(
      region = c("US-OR", "US-WA"),
      taxa = list(
        list(
          family = "Pinaceae",
          genus = "Pinus",
          species = "ponderosa"
        ),
        list(
          family = "Pinaceae",
          genus = "Pinus",
          species = "monticola"
        )
      )
    )
  ))
})
