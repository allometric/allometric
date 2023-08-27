#' @slot response_unit A one-element list with the name indicating the response
#' variable and the value as the response variable units obtained using
#' `units::as_units()`
#' @slot covariate_units A list containing the covariate names as names and 
#' values as the values of the covariate units obtained using
#' `units::as_units()`
#' @slot predict_fn The prediction function, which takes covariates as arguments
#' and returns model predictions
#' @slot descriptors A `tibble::tbl_df` containing the model descriptors
#' @slot set_descriptors A `tibble::tbl_df` containing the set descriptors
#' @slot pub_descriptors A `tibble::tbl_df` containing the publication
#' descriptors
#' @slot citation A `RefManageR::BibEntry` object containing the reference
#' publication
#' @slot covariate_definitions User-provided covariate definitions
#' @slot model_type The model type, which is parsed from the `response_unit`
#' name
