check_fixed_effects_set <- function(object) {
  errors <- c()
  errors <- c(errors, check_model_specifications_unique(object@model_specifications, object@parameter_names))
  errors <- c(errors, check_parameters_in_predict_fn(object))
  if (length(errors) == 0) TRUE else errors
}


.FixedEffectsSet <- setClass("FixedEffectsSet",
  contains = "ParametricSet",
  validity = check_fixed_effects_set
)

#' Create a set of fixed effects models
#'
#' A `FixedEffectsSet` represents a group of fixed-effects models that all have
#' the same functional structure. Fitting a large family of models (e.g., for
#' many different species) using the same functional structure is a common
#' pattern in allometric studies, and `FixedEffectsSet` facilitates the
#' installation of these groups of models by allowing the user to specify the
#' parameter estimates and descriptions in a dataframe.
#'
#' @inheritParams FixedEffectsModel
#' @param parameter_names
#'    A character vector naming the columns in `model_specifications` that
#'    represent the parameters
#' @param model_specifications
#'    A dataframe such that each row of the dataframe provides model-level
#'    descriptors and parameter estimates for that model. Models must be
#'    uniquely identifiable using the descriptors. This is usually established
#'    using the `load_parameter_frame()` function.
#' @return A set of fixed effects models
#' @template AllometricModel_slots
#' @slot parameter_names A character vector indicating the parameter names
#' @slot model_specifications A `tibble::tbl_df` of model specifications, where
#' each row reprents one model identified with descriptors and containing the
#' parameter estimates.
#' @examples
#' fixef_set <- FixedEffectsSet(
#'   response_unit = list(
#'     vsia = units::as_units("ft^3")
#'   ),
#'   covariate_units = list(
#'     dsob = units::as_units("in")
#'   ),
#'   predict_fn = function(dsob) {
#'     a * dsob^2
#'   },
#'   parameter_names = "a",
#'   model_specifications = tibble::tibble(mod = c(1,2), a = c(1, 2))
#' )
#' @export
FixedEffectsSet <- function(response_unit, covariate_units, parameter_names,
                            predict_fn, model_specifications,
                            descriptors = list(),
                            response_definition = NA_character_,
                            covariate_definitions = list()) {
  descriptors <- tibble::tibble(descriptors)

  fixed_effects_set <- .FixedEffectsSet(
    ParametricSet(
      response_unit, covariate_units, predict_fn, model_specifications,
      parameter_names, descriptors, response_definition, covariate_definitions
    )
  )

  model_descriptors <- descriptors(fixed_effects_set)

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



setMethod("show", "FixedEffectsSet", function(object) {
  variable_descriptions <- get_variable_descriptions(object)
  variable_descriptions <- paste(variable_descriptions, collapse = "\n")

  mod_call <- model_call(object)
  n_models <- length(object@models)

  header <- paste("FixedEffectsSet (", n_models, " models):", sep="")

  cat(header, "\n", "\n")
  cat(mod_call, "\n")

  cat(variable_descriptions, "\n", "\n")

  cat("Parameter Names:", "\n")
  cat(paste(object@parameter_names, collapse = ", "), "\n", "\n")

  cat("Model Specifications (head): ", "\n")

  print(utils::head(specification(object)))
})
