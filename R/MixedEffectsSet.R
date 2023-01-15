check_fixed_effects_set_validity <- function(object) {
  errors <- c()
  errors <- c(errors, check_parameters_in_mixed_fns(object))
  errors
}

.MixedEffectsSet <- setClass("MixedEffectsSet",
  contains = "ModelSet",
  slots = c(
    predict_ranef = "function",
    fixed_only = "logical",
    parameter_names = "character"
  ),
  validity = check_fixed_effects_set_validity
)

#' Create a set of mixed effects models
#'
#' A `MixedEffectsSet` represents a group of fixed-effects models that all have
#' the same functional structure. Fitting a large family of models (e.g., for
#' many different species) using the same functional structure is a common
#' pattern in allometric studies, and `MixedEffectsSet` facilitates the
#' installation of these groups of models by allowing the user to specify the
#' parameter estimates and descriptions in a dataframe or spreadsheet.
#'
#' Because mixed-effects models already accommodate a grouping structure,
#' `MixedEffectsSet` tends to be a much rarer occurrence than `FixedEffectsSet`
#' and `MixedEffectsModel`.
#'
#' @inheritParams FixedEffectsSet
#' @inheritParams MixedEffectsModel
#' @export
MixedEffectsSet <- function(response_unit, covariate_units, parameter_names,
                            predict_fn, model_specifications, predict_ranef,
                            fixed_only = FALSE, descriptors = list(),
                            covariate_definitions = list()) {
  mixed_effects_set <- .MixedEffectsSet(
    ModelSet(
      response_unit, covariate_units, predict_fn, model_specifications,
      descriptors, covariate_definitions
    ), predict_ranef = predict_ranef, fixed_only = fixed_only,
    parameter_names = parameter_names
  )

  ranef_names <- get_ranef_names(mixed_effects_set@predict_ranef)
  mod_descriptors <- names(model_specifications)[!names(model_specifications) %in% mixed_effects_set@parameter_names]

  for (i in seq_len(nrow(model_specifications))) {
    mod <- MixedEffectsModel(
      response_unit = response_unit,
      covariate_units = covariate_units,
      predict_fn = predict_fn,
      parameters = model_specifications[i, mixed_effects_set@parameter_names],
      descriptors = model_specifications[i, mod_descriptors],
      predict_ranef = mixed_effects_set@predict_ranef,
      fixed_only = fixed_only,
      covariate_definitions = covariate_definitions
    )

    mod@set_descriptors <- mixed_effects_set@descriptors
    mixed_effects_set@models[[length(mixed_effects_set@models) + 1]] <- mod
  }

  mixed_effects_set
  mixed_effects_set@fixed_only <- fixed_only
  mixed_effects_set
}