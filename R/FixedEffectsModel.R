.FixedEffectsModel <- setClass(
  "FixedEffectsModel",
  contains = "ParametricModel",
  validity = check_parametric_model
)

#' Create a fixed effects model
#'
#' `FixedEffectsModel` represents an allometric model that only uses fixed
#' effects. Most allometric models, especially those from literature before
#' the 2010's fall under this category.
#'
#' @param response_unit
#'    A named list containing one element, with a name representing the response
#'    variable and a value representing the units of the response variable
#'    using the `units::as_units` function.
#' @param covariate_units
#'    A named list containing the covariate specifications, with names
#'    representing the covariate name and the values representing the units of
#'    the coavariate using the `units::as_units` function.
#' @param predict_fn
#'    A function that takes the covariates specified in `covariate_units` as
#'    arguments and produces an allometric prediction. The last line of the
#'    function must be a mathematical expression that does not use a `return`
#'    statement.
#' @param descriptors
#'    An optional list of descriptors that are specified at the model-level.
#' @return
#'    An object of class `FixedEffectsModel`
#' @export
FixedEffectsModel <- function(response_unit, covariate_units, predict_fn,
                              parameters, descriptors = list()) {
  fixed_effects_model <- .FixedEffectsModel(ParametricModel(
    response_unit, covariate_units, predict_fn, parameters, descriptors
  ))

  fixed_effects_model
}

#' @rdname predict
setMethod("predict", signature(mod = "FixedEffectsModel"), function(mod, ...) {
  mod@predict_fn_populated(...)
})

setMethod("init_set_of_one", signature(mod = "FixedEffectsModel"), function(mod) {
  FixedEffectsSet(
    response_unit = mod@response_unit,
    covariate_units = mod@covariate_units,
    parameter_names = names(mod@parameters),
    predict_fn = mod@predict_fn,
    model_specifications = mod@specification
  )
})


setMethod("model_call", signature(model = "FixedEffectsModel"), function(model) {
  response_var <- names(model@response_unit)[[1]]

  arg_names <- names(as.list(args(model@predict_fn)))
  arg_names <- arg_names[-length(arg_names)]
  arg_names_str <- paste(arg_names, collapse = ', ')

  paste(response_var, ' = ', 'f(', arg_names_str, ')', sep='')
})