# Functions that produce summary text, used as internal functions for class
# methods

.get_model_str <- function(object) {
  response_name <- names(object@response_unit)[[1]]
  func_str <- toString(body(object@predict_fn))
  clean_str <- gsub('\\{,', '', func_str)
  clean_str <- stringr::str_trim(clean_str)

  model_str <- paste(response_name, '=', clean_str)
  model_str
}

.get_variable_description_str <- function(variable_name, unit_str) {
  variable_description <- get_variable_def(variable_name)$description
  variable_label_str <- paste(variable_name, unit_str)

  if(identical(variable_description, character(0))) {
    variable_description <- 'variable not defined'
  }

  paste(variable_label_str, ': ', variable_description, sep='')
}

.get_variable_descriptions <- function(object) {
  response_name <- names(object@response_unit)[[1]]
  response_unit_str <- units::deparse_unit(object@response_unit[[response_name]])
  response_unit_str <- paste('[', response_unit_str, ']', sep='')

  response_str <- .get_variable_description_str(response_name,
    response_unit_str)

  covt_strs <- c()

  for(i in seq_along(object@covariate_units)) {
    covt_name <- names(object@covariate_units)[[i]]
    covt_unit_str <- units::deparse_unit(object@covariate_units[[covt_name]])
    covt_unit_str <- paste('[', covt_unit_str, ']', sep='')
    covt_str <- .get_variable_description_str(covt_name, covt_unit_str)
    covt_strs <- c(covt_strs, covt_str)
  }

  c(response_str, covt_strs)
}
