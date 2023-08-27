.FixedEffectsModel <- setClass(
  "FixedEffectsModel",
  contains = "ParametricModel",
  validity = check_parametric_model
)

#' Create a fixed effects model
#'
#' `FixedEffectsModel` represents an allometric model that only uses fixed
#' effects.
#'
#' @param parameters A named list of parameters and their values
#' @return An object of class `FixedEffectsModel`
#' @inheritParams ParametricModel
#' @template AllometricModel_slots
#' @template ParametricModel_slots
#' @examples
#' FixedEffectsModel(
#'   response_unit = list(
#'     hst = units::as_units("m")
#'   ),
#'   covariate_units = list(
#'     dsob = units::as_units("cm")
#'   ),
#'   parameters = list(
#'     beta_0 = 51.9954,
#'     beta_1 = -0.0208,
#'     beta_2 = 1.0182
#'   ),
#'   predict_fn = function(dsob) {
#'     1.37 + beta_0 * (1 - exp(beta_1 * dsob)^beta_2)
#'   }
#' )
#' @export
FixedEffectsModel <- function(response_unit, covariate_units, predict_fn,
                              parameters, descriptors = list(),
                              covariate_definitions = list()) {
  fixed_effects_model <- .FixedEffectsModel(ParametricModel(
    response_unit, covariate_units, predict_fn, parameters, descriptors,
    covariate_definitions
  ))

  fixed_effects_model
}

#' @rdname predict
setMethod("predict", signature(model = "FixedEffectsModel"), function(model, ..., output_units = NULL) {
  converted <- convert_units(..., units_list = model@covariate_units)
  stripped <- strip_units(converted)

  out <- do.call(model@predict_fn_populated, stripped)

  if("units" %in% class(out)) {
    out_stripped <- units::drop_units(out)
  } else {
    out_stripped <- out
  }

  deparsed <- units::deparse_unit(model@response_unit[[1]])
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

setMethod("init_set_of_one", signature(model = "FixedEffectsModel"), function(model) {
  FixedEffectsSet(
    response_unit = model@response_unit,
    covariate_units = model@covariate_units,
    parameter_names = names(model@parameters),
    predict_fn = model@predict_fn,
    model_specifications = model@specification,
    covariate_definitions = model@covariate_definitions
  )
})


#' @inherit model_call
#' @keywords internal
setMethod("model_call", signature(model = "FixedEffectsModel"), function(model) {
  response_var <- names(model@response_unit)[[1]]

  arg_names <- names(as.list(args(model@predict_fn)))
  arg_names <- arg_names[-length(arg_names)]
  arg_names_str <- paste(arg_names, collapse = ", ")

  paste(response_var, " = ", "f(", arg_names_str, ")", sep = "")
})
