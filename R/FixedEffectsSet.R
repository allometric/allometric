check_fixed_effects_set_validity <- function(object) {
  errors <- c()
  errors <- c(errors, check_model_specifications_unique(object@model_specifications, object@parameter_names))
  errors <- c(errors, check_parameters_in_predict_fn(object))
  if (length(errors) == 0) TRUE else errors
}


.FixedEffectsSet <- setClass("FixedEffectsSet",
  contains = "ModelSet",
  slots = c(
    parameter_names = "character"
  ),
  validity = check_fixed_effects_set_validity
)

#' Create a set of fixed effects models
#'
#' A `FixedEffectsSet` represents a group of fixed-effects models that all have
#' the same functional structure. Fitting a large family of models (e.g., for
#' many different species) using the same functional structure is a common
#' pattern in allometric studies, and `FixedEffectsSet` facilitates the
#' installation of these groups of models by allowing the user to specify the
#' parameter estimates and descriptions in a dataframe or spreadsheet.
#'
#' @inheritParams FixedEffectsModel
#' @param parameter_names
#'    A character vector naming the columns in `model_specifications` that
#'    represent the parameters
#' @param model_specifications
#'    A dataframe such that each row of the dataframe provides model-level
#'    descriptors and parameter estimates for that model. Models must be
#'    uniquely identifiable using the descriptors
#' @return A set of fixed effects models
#' @export
FixedEffectsSet <- function(response_unit, covariate_units, parameter_names,
                            predict_fn, model_specifications,
                            descriptors = list(),
                            covariate_definitions = list()) {
  descriptors <- tibble::tibble(descriptors)

  fixed_effects_set <- .FixedEffectsSet(
    ModelSet(
      response_unit, covariate_units, predict_fn, model_specifications,
      descriptors, covariate_definitions
    ),
    parameter_names = parameter_names
  )

  model_descriptors <- names(model_specifications)[!names(model_specifications) %in% fixed_effects_set@parameter_names]

  for (i in seq_len(nrow(model_specifications))) {
    model <- FixedEffectsModel(
      response_unit = response_unit,
      covariate_units = covariate_units,
      predict_fn = predict_fn,
      parameters = model_specifications[i, fixed_effects_set@parameter_names],
      descriptors = model_specifications[i, model_descriptors],
      covariate_definitions = covariate_definitions
    )

    model@set_descriptors <- fixed_effects_set@descriptors
    fixed_effects_set@models[[length(fixed_effects_set@models) + 1]] <- model
  }

  fixed_effects_set
}
