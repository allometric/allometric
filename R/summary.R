# Functions that produce summary text, used as internal functions for class
# methods

.get_model_str <- function(object) {
  response_name <- names(object@response_unit)[[1]]
  predict_body <- body(object@predict_fn)
  last_line_ix <- length(predict_body)

  func_str <- deparse(predict_body[[last_line_ix]], width.cutoff = 500)
  clean_str <- gsub("\\{,", "", func_str)
  clean_str <- stringr::str_trim(clean_str)

  model_str <- paste(response_name, "=", clean_str)
  model_str
}

#'
#' @param variable A one-element list of either a response_unit or a
#' covariate_unit
#' @keywords internal
.get_variable_description_str <- function(variable, covariate_descriptions) {
  variable_name <- names(variable)[[1]]

  if(class(variable[[variable_name]]) == "symbolic_units") {
    # Handles the unitless case
    unit_str <- ''
  } else {
    unit_str <- units::deparse_unit(variable[[variable_name]])
  }

  unit_str <- paste('[', unit_str, ']', sep='')

  if(variable_name %in% names(covariate_descriptions)) {
    variable_description <- covariate_descriptions[[variable_name]]
  } else {
    variable_description <- get_variable_def(variable_name)$description
  }


  variable_label_str <- paste(variable_name, unit_str)

  if (identical(variable_description, character(0))) {
    variable_description <- "variable not defined"
  }

  paste(variable_label_str, ": ", variable_description, sep = "")
}

.get_variable_descriptions <- function(object) {
  response_str <- .get_variable_description_str(
    object@response_unit,
    object@covariate_definitions
  )

  covt_strs <- c()

  for (i in seq_along(object@covariate_units)) {
    covt_str <- .get_variable_description_str(
      object@covariate_units[i],
      object@covariate_definitions
    )
    covt_strs <- c(covt_strs, covt_str)
  }

  c(response_str, covt_strs)
}
