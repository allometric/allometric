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
#' @export
#' @keywords internal
ParametricSet <- function(response_unit, covariate_units, predict_fn,
                          model_specifications, parameter_names,
                          descriptors = list(), covariate_definitions = list()
                          ) {

  parametric_set <- .ParametricSet(
    ModelSet(
      response_unit, covariate_units, predict_fn, descriptors,
      covariate_definitions
    ),
    parameter_names = parameter_names,
    model_specifications = model_specifications
  )

  parametric_set
}

setMethod("descriptors", "ParametricSet", function(object) {
  names(object@model_specifications)[!names(object@model_specifications) %in% object@parameter_names]
})