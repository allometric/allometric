.MixedEffectsSet <- setClass("MixedEffectsSet",
  contains = "ModelSet",
  slots = c(
    fixed_only = "logical"
  )
)

MixedEffectsSet <- function(response_unit, covariate_units, predict_fn,
  model_specifications, fixed_only = FALSE, descriptors = list()) {

  mixed_effects_set <- .MixedEffectsSet(
    ModelSet(
      response_unit, covariate_units, predict_fn, model_specifications,
      descriptors
    )
  )

  mixed_effects_set@fixed_only <- fixed_only
  mixed_effects_set
}