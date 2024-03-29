# Functions that produce summary text, used as internal functions for class
# methods

.get_model_str <- function(object) {
  response_name <- names(object@response)[[1]]
  predict_body <- body(object@predict_fn)
  last_line_ix <- length(predict_body)

  func_str <- deparse(predict_body[[last_line_ix]], width.cutoff = 500)
  clean_str <- gsub("\\{,", "", func_str)
  clean_str <- stringr::str_trim(clean_str)

  model_str <- paste(response_name, "=", clean_str)
  model_str
}

parse_unit_str <- function(variable) {
  variable_name <- names(variable)[[1]]

  if (inherits(variable[[variable_name]], "symbolic_units")) {
    # Handles the unitless case
    unit_str <- ""
  } else {
    unit_str <- units::deparse_unit(variable[[variable_name]])
  }

  unit_str
}

.get_response_description <- function(response, response_description) {
  variable_name <- names(response)[[1]]

  unit_str <- parse_unit_str(response)
  unit_str <- paste("[", unit_str, "]", sep = "")

  if(!is.na(response_description)) {
    variable_description <- response_description
  } else {
    variable_description <- get_variable_def(variable_name, return_exact_only = T)$description
  }

  if (identical(variable_description, character(0))) {
    variable_description <- "variable not defined"
  }

  list(
    name = variable_name,
    unit_label = unit_str,
    desc = variable_description
  )
}

.get_covariate_description <- function(covariate, covariate_descriptions) {
  variable_name <- names(covariate)[[1]]

  unit_str <- parse_unit_str(covariate)
  unit_str <- paste("[", unit_str, "]", sep = "")

  if (variable_name %in% names(covariate_descriptions)) {
    variable_description <- covariate_descriptions[[variable_name]]
  } else {
    variable_description <- get_variable_def(variable_name, return_exact_only = T)$description
  }

  if (identical(variable_description, character(0))) {
    variable_description <- "variable not defined"
  }

  list(
    name = variable_name,
    unit_label = unit_str,
    desc = variable_description
  )
}

.get_variable_descriptions <- function(object) {
  vars <- c(object@response, object@covariates)
  var_descs <- list()

  var_descs[[1]] <- .get_response_description(
    vars[1],
    object@response_definition
  )

  for (i in 2:length(vars)) {
    var_desc <- .get_covariate_description(
      vars[i],
      object@covariate_definitions
    )
    var_descs[[i]] <- var_desc
  }

  dplyr::bind_rows(var_descs)
}

.get_variable_descriptions_fmt <- function(object) {
  variable_descs <- .get_variable_descriptions(object)
  out <- c()

  for (i in seq_len(nrow(variable_descs))) {
    desc_i <- variable_descs[i, ]
    desc_str <- paste(
        desc_i$name, " ", desc_i$unit_label, ": ", desc_i$desc, sep = ""
      )
    out <- c(out, desc_str)
  }

  out
}

