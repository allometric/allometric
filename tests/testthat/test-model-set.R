test_that("ModelSet runs with nested descriptors", {
  expect_no_error(ModelSet(
    response = list(vsia = units::as_units("ft^3")),
    covariates = list(dsob = units::as_units("in")),
    predict_fn = function(dsob) dsob,
    descriptors = list(
      region = c("US-OR", "US-WA"),
      country = "CA"
    )
  ))
})
