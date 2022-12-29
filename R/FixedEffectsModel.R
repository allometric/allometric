.FixedEffectsModel <- setClass(
  "FixedEffectsModel",
  contains = "ParametricModel",
  validity = check_parametric_model
)

#' Instantiate a fixed effects model.
#'
#' This class is essentially a wrapper around `ParametricModel` but clarifies
#' the intent between `FixedEffectsModel` and `MixedEffectsModel`.
FixedEffectsModel <- function(response_unit, covariate_units, predict_fn,
                              parameters, descriptors = list()) {

  fixed_effects_model <- .FixedEffectsModel(ParametricModel(
    response_unit, covariate_units, predict_fn, parameters, descriptors
  ))

  fixed_effects_model
}