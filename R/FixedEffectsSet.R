.FixedEffectsSet <- setClass("FixedEffectsSet",
  contains = "ModelSet"
)

FixedEffectsSet <- function(response_unit, covariate_units, predict_fn,
  model_specifications, descriptors = list()) {

  fixed_effects_set <- .FixedEffectsSet(
    ModelSet(
      response_unit, covariate_units, predict_fn, model_specifications, 
      descriptors
    )
  )

  fixed_effects_set

}