.MixedEffectsModel <- setClass(
  "MixedEffectsModel",
  contains = "ParametricModel",
  slots = c(
    fixed_only = "logical"
  ),
  validity = check_parametric_model
)

#' Instantiate a fixed effects model.
#'
#' This class is essentially a wrapper around `ParametricModel` but clarifies
#' the intent between `FixedEffectsModel` and `MixedEffectsModel`.
#'
#' @export
MixedEffectsModel <- function(response_unit, covariate_units, predict_fn,
                              parameters, fixed_only = FALSE,
                              descriptors = list()) {
  mixed_effects_model <- .MixedEffectsModel(ParametricModel(
    response_unit, covariate_units, predict_fn, parameters, descriptors
  ))

  mixed_effects_model@fixed_only <- fixed_only
  mixed_effects_model
}

