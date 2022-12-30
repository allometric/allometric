.FixedEffectsSet <- setClass("FixedEffectsSet",
  contains = "ModelSet"
)

#' @export
FixedEffectsSet <- function(response_unit, covariate_units, predict_fn,
  model_specifications, descriptors = list()) {

  fixed_effects_set <- .FixedEffectsSet(
    ModelSet(
      response_unit, covariate_units, predict_fn, model_specifications, 
      descriptors
    )
  )

  if ("list" %in% class(model_specifications)) {
    model_specifications <- tibble(data.frame(model_specifications))
  }

  mod_descriptors <- names(model_specifications)[!names(model_specifications) %in% fixed_effects_set@parameter_names]

  for (i in 1:nrow(model_specifications)) {
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