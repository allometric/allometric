check_fixed_effects_set_validity <- function(object) {
  errors <- c()
  errors <- c(errors, check_parameters_in_mixed_fns(object))
  errors
}

.MixedEffectsSet <- setClass("MixedEffectsSet",
  contains = "ParametricSet",
  slots = c(
    predict_ranef = "function",
    fixed_only = "logical"
  ),
  validity = check_fixed_effects_set_validity
)

#' Create a set of mixed effects models
#'
#' A `MixedEffectsSet` represents a group of mixed-effects models that all have
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
#' @return An instance of MixedEffectsSet
#' @template ParametricModel_slots
#' @slot predict_ranef The function that predicts the random effects
#' @slot predict_ranef_populated The function that predicts the random effects
#' populated with the fixed effect parameter estimates
#' @slot fixed_only A boolean value indicating if the model produces predictions
#' using only fixed effects
#' @slot model_specifications A `tibble::tbl_df` of model specifications, where
#' each row reprents one model identified with descriptors and containing the
#' parameter estimates.
#' @examples
#' mixed_effects_set <- MixedEffectsSet(
#'   response = list(
#'     vsia = units::as_units("ft^3")
#'   ),
#'   covariates = list(
#'     dsob = units::as_units("in")
#'   ),
#'   parameter_names = "a",
#'   predict_ranef = function(dsob, hst) {
#'     list(a_i = 1)
#'   },
#'   predict_fn = function(dsob) {
#'     (a + a_i) * dsob^2
#'   },
#'   model_specifications = tibble::tibble(a = c(1, 2))
#' )
#' @export
MixedEffectsSet <- function(response, covariates, parameter_names,
                            predict_fn, model_specifications, predict_ranef,
                            fixed_only = FALSE, descriptors = list(),
                            response_definition = NA_character_,
                            covariate_definitions = list()) {
  mixed_effects_set <- .MixedEffectsSet(
    ParametricSet(
      response, covariates, predict_fn, model_specifications,
      parameter_names, descriptors, response_definition, covariate_definitions
    ),
    predict_ranef = predict_ranef,
    fixed_only = fixed_only
  )

  ranef_names <- get_ranef_names(mixed_effects_set@predict_ranef)
  mod_descriptors <- names(model_specifications)[!names(model_specifications) %in% mixed_effects_set@parameter_names]

  for (i in seq_len(nrow(model_specifications))) {
    model <- MixedEffectsModel(
      response = response,
      covariates = covariates,
      predict_fn = predict_fn,
      parameters = model_specifications[i, mixed_effects_set@parameter_names],
      descriptors = model_specifications[i, mod_descriptors],
      predict_ranef = mixed_effects_set@predict_ranef,
      fixed_only = fixed_only,
      response_definition =  response_definition,
      covariate_definitions = covariate_definitions
    )

    model@set_descriptors <- mixed_effects_set@descriptors
    mixed_effects_set@models[[length(mixed_effects_set@models) + 1]] <- model
  }

  mixed_effects_set
  mixed_effects_set@fixed_only <- fixed_only
  mixed_effects_set
}

setMethod("show", "MixedEffectsSet", function(object) {
  variable_descriptions <- get_variable_descriptions(object)
  variable_descriptions <- paste(variable_descriptions, collapse = "\n")

  mod_call <- model_call(object)
  n_models <- length(object@models)

  header <- paste("MixedEffectsSet (", n_models, " models):", sep="")

  cat(header, "\n", "\n")
  cat(mod_call, "\n")

  cat(variable_descriptions, "\n", "\n")

  cat("Parameter Names:", "\n")
  cat(paste(object@parameter_names, collapse = ", "), "\n", "\n")

  cat("Random Effects Variables:", "\n")
  ranef_vars <- names(as.list(args(object@predict_ranef)))
  ranef_vars <- ranef_vars[-length(ranef_vars)]
  ranef_vars_fmt <- paste(ranef_vars, collapse = ", ")
  cat(ranef_vars_fmt, "\n", "\n")

  cat("Model Specifications (head): ", "\n")

  print(utils::head(specification(object)))
})