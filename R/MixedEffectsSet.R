.MixedEffectsSet <- setClass("MixedEffectsSet",
  contains = "ModelSet",
  slots = c(
    fixed_only = "logical"
  )
)

#' @export
MixedEffectsSet <- function(response_unit, covariate_units, predict_fn,
                            model_specifications, fixed_only = FALSE, descriptors = list()) {
  mixed_effects_set <- .MixedEffectsSet(
    ModelSet(
      response_unit, covariate_units, predict_fn, model_specifications,
      descriptors
    )
  )

  if ("list" %in% class(model_specifications)) {
    model_specifications <- tibble(data.frame(model_specifications))
  }

  mod_descriptors <- names(model_specifications)[!names(model_specifications) %in% mixed_effects_set@parameter_names]

  for (i in seq_len(nrow(model_specifications))) {
    mod <- MixedEffectsModel(
      response_unit = response_unit,
      covariate_units = covariate_units,
      predict_fn = predict_fn,
      parameters = model_specifications[i, mixed_effects_set@parameter_names],
      descriptors = model_specifications[i, mod_descriptors],
      fixed_only = fixed_only
    )

    mod@set_descriptors <- mixed_effects_set@descriptors
    mixed_effects_set@models[[length(mixed_effects_set@models) + 1]] <- mod
  }

  mixed_effects_set
  mixed_effects_set@fixed_only <- fixed_only
  mixed_effects_set
}


