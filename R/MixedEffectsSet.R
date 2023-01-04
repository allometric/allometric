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

#' @export
MixedEffectsSet <- function(response_unit, covariate_units, parameter_names,
                            predict_fn, model_specifications, predict_ranef,
                            fixed_only = FALSE, descriptors = list()) {
  mixed_effects_set <- .MixedEffectsSet(
    ModelSet(
      response_unit, covariate_units, predict_fn, model_specifications,
      descriptors
    ), predict_ranef = predict_ranef, fixed_only = fixed_only,
    parameter_names = parameter_names
  )

  if ("list" %in% class(model_specifications)) {
    model_specifications <- tibble::tibble(data.frame(model_specifications))
  }

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
      fixed_only = fixed_only
    )

    mod@set_descriptors <- mixed_effects_set@descriptors
    mixed_effects_set@models[[length(mixed_effects_set@models) + 1]] <- mod
  }

  mixed_effects_set
  mixed_effects_set@fixed_only <- fixed_only
  mixed_effects_set
}


