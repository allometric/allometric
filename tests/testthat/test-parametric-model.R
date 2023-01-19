param_mod <- ParametricModel(
  response_unit = list(vsa = units::as_units("ft^3")),
  covariate_units = list(dsob = units::as_units("in")),
  predict_fn = function(dsob) {
    dsob * a
  },
  parameters = list(a = 1)
)
