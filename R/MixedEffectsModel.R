.MixedEffectsModel <- setClass(
  "MixedEffectsModel",
  contains = "ParametricModel",
  slots = c(
    predict_ranef = "function",
    predict_ranef_populated = "function",
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
MixedEffectsModel <- function(response_unit, covariate_units, predict_ranef,
                              predict_fn, parameters, fixed_only = FALSE,
                              descriptors = list()) {
  mixed_effects_model <- .MixedEffectsModel(ParametricModel(
    response_unit, covariate_units, predict_fn, parameters, descriptors
  ))

  mixed_effects_model@predict_ranef <- predict_ranef
  mixed_effects_model@fixed_only <- fixed_only

  # Populate the random effect prediction function with the fixed parameters
  mixed_effects_model@predict_ranef_populated <- mixed_effects_model@predict_ranef

  func_body <- body(mixed_effects_model@predict_ranef_populated)
  body(mixed_effects_model@predict_ranef_populated) <- do.call(
    "substitute", list(func_body, mixed_effects_model@specification)
  )

  mixed_effects_model
}

setMethod("predict", signature(mod = "MixedEffectsModel"), function(mod, ..., newdata = NULL) {
  # TODO validity checks for predict_ranef, we should throw a warning if 
  # the columna names of newdata are not the same set of args in predict_ranef
  # probabyl some opportunity for DRY with other validity checks..
  ranef_args <- names(as.list(args(mod@predict_ranef)))
  ranef_args <- ranef_args[-length(ranef_args)]

  complete_fn <- mod@predict_fn

  if (!is.null(newdata)) {
    ranefs <- do.call(mod@predict_ranef_populated, newdata)
  } else {
    ranefs <- mod@predict_ranef_populated()
  }
  predict_populated <- body(mod@predict_fn_populated)
  body(complete_fn) <- do.call("substitute", list(predict_populated, ranefs))

  complete_fn(...)
})

setMethod("init_set_of_one", signature(mod = "MixedEffectsModel"), function(mod) {
  MixedEffectsSet(
    response_unit = mod@response_unit,
    covariate_units = mod@covariate_units,
    predict_fn = mod@predict_fn,
    parameter_names = names(mod@parameters),
    model_specifications = mod@specification,
    predict_ranef = mod@predict_ranef,
    fixed_only = mod@fixed_only
  )
})