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
    response_unit = "list",
    covariate_units = "list",
    predict_fn = "function",
    model_specifications = "tbl_df",
    descriptors = "tbl_df",
    pub_descriptors = "tbl_df",
    models = "list",
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
#' @param model_specifications A tbl_df of model specifications, which contain
#'    columns for the parameters and the descriptors.
#' @return An instance of a ModelSet
#' @export
#' @keywords internal
ModelSet <- function(response_unit, covariate_units, predict_fn,
                     model_specifications, descriptors = list(),
                     covariate_definitions = list()) {
  descriptors <- tibble::as_tibble(descriptors)

  model_set <- .ModelSet(
    response_unit = response_unit,
    covariate_units = covariate_units,
    predict_fn = predict_fn,
    model_specifications = model_specifications,
    descriptors = descriptors,
    pub_descriptors = tibble::tibble(),
    covariate_definitions = covariate_definitions
  )
  model_set
}
