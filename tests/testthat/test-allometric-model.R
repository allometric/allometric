test_that("Invalid country returns error", {
  expect_error(
    AllometricModel(
      response_unit = list(vsa = units::as_units('ft^3')),
      covariate_units = list(dsob = units::as_units('in')),
      predict_fn = function(dsob) {dsob},
      descriptors = list(country = "bad-country-code")
    )
  )
}) 

allo_mod <- AllometricModel(
  response_unit = list(vsa = units::as_units('ft^3')),
  covariate_units = list(dsob = units::as_units('in')),
  predict_fn = function(dsob) {dsob}
)

test_that("Get measure label is correct", {
  expect_equal(get_measure_label(allo_mod), "volume")
})

test_that("Get component label is correct", {
  expect_equal(get_component_label(allo_mod), "stem")
})

# TODO produces a warning, but a fairly inconsequential test...
#test_that("Cite returns a string", {
#  expect_equal(Cite(allo_mod), "(, )")
#})