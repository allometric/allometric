check_model_set_validity <- function(object) {
  errors <- c()
  errors <- c(errors, check_covts_in_args(object))
  errors <- c(errors, check_args_in_predict_fn(object))
  errors <- c(errors, check_descriptor_set(object))
  if (length(errors) == 0) TRUE else errors
}

.ModelSet <- setClass(
  "ModelSet",
  slots = c(
    response = "list",
    covariates = "list",
    predict_fn = "function",
    descriptors = "tbl_df",
    pub_descriptors = "tbl_df",
    models = "list",
    response_definition = "character",
    covariate_definitions = "list"
  ),
  validity = check_model_set_validity
)
#' Base class for model sets
#'
#' This class is primarily used as a parent class for other model set
#' implementations.
#'
#' @inherit AllometricModel
#' @return An instance of a ModelSet
#' @export
#' @keywords internal
ModelSet <- function(response, covariates, predict_fn,
                     descriptors = list(),
                     response_definition = NA_character_,
                     covariate_definitions = list()) {
  
  descriptors <- descriptors_to_tibble_row(descriptors)

  model_set <- .ModelSet(
    response = response,
    covariates = covariates,
    predict_fn = predict_fn,
    descriptors = descriptors,
    pub_descriptors = tibble::tibble(),
    response_definition = response_definition,
    covariate_definitions = covariate_definitions
  )

  model_set
}
