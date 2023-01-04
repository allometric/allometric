

#' Are all named parameters in the model specification?
check_parameters_in_specification <- function(object) {
}

check_fixed_effects_set_validity <- function(object) {
  # TODO the number of distinct rows of model_specifications using the
  # non-parameter columns needs to be equalto the total number of rows
  errors <- c()
  errors <- c(errors, check_parameters_in_predict_fn(object))
  errors
}


.FixedEffectsSet <- setClass("FixedEffectsSet",
  contains = "ModelSet",
  slots = c(
    parameter_names = "character"
  ),
  validity = check_fixed_effects_set_validity
)

#' @export
FixedEffectsSet <- function(response_unit, covariate_units, parameter_names,
                            predict_fn, model_specifications,
                            descriptors = list()) {
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

