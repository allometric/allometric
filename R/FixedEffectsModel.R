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
#' @return
#'    An object of class `FixedEffectsModel`
#' @inheritParams ParametricModel
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
setMethod("predict", signature(mod = "FixedEffectsModel"), function(mod, ..., output_units = NULL) {
  converted <- convert_units(..., units_list = mod@covariate_units)
  stripped <- strip_units(converted)

  out <- do.call(mod@predict_fn_populated, stripped)

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

setMethod("init_set_of_one", signature(mod = "FixedEffectsModel"), function(mod) {
  FixedEffectsSet(
    response_unit = mod@response_unit,
    covariate_units = mod@covariate_units,
    parameter_names = names(mod@parameters),
    predict_fn = mod@predict_fn,
    model_specifications = mod@specification,
    covariate_definitions = mod@covariate_definitions
  )
})


setMethod("model_call", signature(model = "FixedEffectsModel"), function(model) {
  response_var <- names(model@response_unit)[[1]]

  arg_names <- names(as.list(args(model@predict_fn)))
  arg_names <- arg_names[-length(arg_names)]
  arg_names_str <- paste(arg_names, collapse = ", ")

  paste(response_var, " = ", "f(", arg_names_str, ")", sep = "")
})
