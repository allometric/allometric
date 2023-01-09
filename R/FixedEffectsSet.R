check_fixed_effects_set_validity <- function(object) {
  # TODO the number of distinct rows of model_specifications using the
  # non-parameter columns needs to be equalto the total number of rows
  errors <- c()
  errors <- c(errors, check_descriptor_validity(object@descriptors))
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
#'    represent the parameters.
#' @param model_specifications
#'    A dataframe such that each row of the dataframe provides model-level
#'    descriptors and parameter estimates for that model. Models must be
#'    uniquely identifiable using the descriptors.
#' @export
FixedEffectsSet <- function(response_unit, covariate_units, parameter_names,
                            predict_fn, model_specifications,
                            descriptors = list()) {
  descriptors <- tibble::tibble(descriptors)

  fixed_effects_set <- .FixedEffectsSet(
    ModelSet(
      response_unit, covariate_units, predict_fn, model_specifications,
      descriptors
    ), parameter_names = parameter_names
  )

  if ("list" %in% class(model_specifications)) {
    model_specifications <- tibble::tibble(data.frame(model_specifications))
  }

  mod_descriptors <- names(model_specifications)[!names(model_specifications) %in% fixed_effects_set@parameter_names]

  for (i in seq_len(nrow(model_specifications))) {
    mod <- FixedEffectsModel(
      response_unit = response_unit,
      covariate_units = covariate_units,
      predict_fn = predict_fn,
      parameters = model_specifications[i, fixed_effects_set@parameter_names],
      descriptors = model_specifications[i, mod_descriptors]
    )

    mod@set_descriptors <- fixed_effects_set@descriptors
    fixed_effects_set@models[[length(fixed_effects_set@models) + 1]] <- mod
  }

  fixed_effects_set
}

