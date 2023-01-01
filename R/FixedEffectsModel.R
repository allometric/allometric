.FixedEffectsModel <- setClass(
  "FixedEffectsModel",
  contains = "ParametricModel",
  validity = check_parametric_model
)

#' Instantiate a fixed effects model.
#'
#' This class is essentially a wrapper around `ParametricModel` but clarifies
#' the intent between `FixedEffectsModel` and `MixedEffectsModel`.
#'
#' @export
FixedEffectsModel <- function(response_unit, covariate_units, predict_fn,
                              parameters, descriptors = list()) {
  fixed_effects_model <- .FixedEffectsModel(ParametricModel(
    response_unit, covariate_units, predict_fn, parameters, descriptors
  ))

  fixed_effects_model
}


setMethod("predict", signature(mod = "FixedEffectsModel"), function(mod, ...) {
  mod@predict_fn_populated(...)
})

setMethod("init_set_of_one", signature(mod = "FixedEffectsModel"), function(mod) {
  FixedEffectsSet(
    response_unit = mod@response_unit,
    covariate_units = mod@covariate_units,
    predict_fn = mod@predict_fn,
    model_specifications = mod@specification
  )
})