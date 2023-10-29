.ParametricSet <- setClass(
  "ParametricSet",
  contains = "ModelSet",
  slots = c(
    parameter_names = "character",
    model_specifications = "tbl_df"
  )
) # TODO validity checks

#' Base class for all parametric sets.
#'
#' This is a base class used for `FixedEffectsSet` and `MixedEffectsSet`
#'
#' @inheritParams ModelSet
#' @return An object of class ParametricSet
#' @export
#' @keywords internal
ParametricSet <- function(response, covariates, predict_fn,
                          model_specifications, parameter_names,
                          descriptors = list(),
                          response_definition = NA_character_,
                          covariate_definitions = list()
                          ) {

  parametric_set <- .ParametricSet(
    ModelSet(
      response, covariates, predict_fn, descriptors,
      response_definition, covariate_definitions
    ),
    parameter_names = parameter_names,
    model_specifications = model_specifications
  )

  parametric_set
}

setMethod("descriptors", "ParametricSet", function(object) {
  names(object@model_specifications)[!names(object@model_specifications) %in% object@parameter_names]
})

setMethod("get_model_str", "ParametricSet", function(object) {
  .get_model_str(object)
})

setMethod("get_variable_descriptions", "ParametricSet", function(object) {
  .get_variable_descriptions_fmt(object)
})

#' @inherit model_call
#' @keywords internal
setMethod("model_call", signature(object = "ParametricSet"), function(object) {
  response_var <- names(object@response)[[1]]

  arg_names <- names(as.list(args(object@predict_fn)))
  arg_names <- arg_names[-length(arg_names)]
  arg_names_str <- paste(arg_names, collapse = ", ")

  paste(response_var, " = ", "f(", arg_names_str, ")", sep = "")
})

setMethod("parameters", "ParametricSet", function(object) {
  object@model_specifications[, object@parameter_names]
})

setMethod("specification", "ParametricSet", function(object) {
  object@model_specifications
})