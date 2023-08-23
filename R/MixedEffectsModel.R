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

#' Create a mixed effects model
#'
#' `MixedEffectsModel` represents an allometric model that uses fixed and
#' random effects.
#'
#' @inheritParams FixedEffectsModel
#' @param predict_ranef
#'    A function that predicts the random effects, takes any named covariates in
#'    `covariate_units` as arguments.
#' @param fixed_only
#'    A boolean value indicating if the model produces predictions using only
#'    fixed effects. This is useful when publications do not provide sufficient
#'    information to predict the random effects.
#' @return An instance of MixedEffectsModel
#' @export
MixedEffectsModel <- function(response_unit, covariate_units, predict_ranef,
                              predict_fn, parameters, fixed_only = FALSE,
                              descriptors = list(),
                              covariate_definitions = list()) {
  mixed_effects_model <- .MixedEffectsModel(ParametricModel(
    response_unit, covariate_units, predict_fn, parameters, descriptors,
    covariate_definitions
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

#' @param newdata
#'    A dataframe containing columns that match the names of the arguments given
#'    to `predict_ranef`. The values of this data represents information from a
#'    new group of observations for which predictions are desired (e.g., a new
#'    stand or plot).
#' @rdname predict
setMethod("predict", signature(mod = "MixedEffectsModel"), function(mod, ..., newdata = NULL, output_units = NULL) {
  # TODO validity checks for predict_ranef, we should throw a warning if
  # the column names of newdata are not the same set of args in predict_ranef
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

  converted <- convert_units(..., units_list = mod@covariate_units)
  stripped <- strip_units(converted)

  out <- do.call(complete_fn, stripped)

  if("units" %in% class(out)) {
    out_stripped <- units::drop_units(out)
  } else {
    out_stripped <- out
  }

  deparsed <- units::deparse_unit(mod@response_unit[[1]])
  out_stripped <- do.call(units::set_units, list(out_stripped, deparsed))

  if(!is.null(output_units)) {
    converted <- convert_units(
      out_stripped,
      units_list = list(units::as_units(output_units))
    )

    out_stripped <- converted[[1]]
  }

  out_stripped

})

setMethod("init_set_of_one", signature(mod = "MixedEffectsModel"), function(mod) {
  MixedEffectsSet(
    response_unit = mod@response_unit,
    covariate_units = mod@covariate_units,
    predict_fn = mod@predict_fn,
    parameter_names = names(mod@parameters),
    model_specifications = mod@specification,
    predict_ranef = mod@predict_ranef,
    fixed_only = mod@fixed_only,
    covariate_definitions = mod@covariate_definitions
  )
})


setMethod("model_call", signature(model = "MixedEffectsModel"), function(model) {
  response_var <- names(model@response_unit)[[1]]

  arg_names <- names(as.list(args(model@predict_fn)))
  arg_names <- arg_names[-length(arg_names)]
  arg_names <- c(arg_names, "newdata")
  arg_names_str <- paste(arg_names, collapse = ", ")

  paste(response_var, " = ", "f(", arg_names_str, ")", sep = "")
})
