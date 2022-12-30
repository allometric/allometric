
check_model_set_validity <- function(object) {
  # TODO the number of distinct rows of model_specifications using the
  # non-parameter columns needs to be equalto the total number of rows
  errors <- c()
  errors <- c(errors, check_covts_in_args(object))
  errors <- c(errors, check_args_in_predict_fn(object))
  errors
}

.ModelSet <- setClass(
  "ModelSet",
  slots = c(
    response_unit = "list",
    covariate_units = "list",
    predict_fn = "function",
    model_specifications = "tbl_df",
    descriptors = "list",
    pub_descriptors = "list",
    parameter_names = "character",
    models = "list"
  ),
  validity = check_model_set_validity
)

ModelSet <- function(response_unit, covariate_units, predict_fn,
                     model_specifications, descriptors = list()) {
  model_set <- .ModelSet()

  model_specifications <- tibble::as_tibble(model_specifications)

  model_set@response_unit <- response_unit
  model_set@covariate_units <- covariate_units
  model_set@predict_fn <- predict_fn
  model_set@model_specifications <- model_specifications
  model_set@descriptors <- descriptors

  model_set@parameter_names <- get_parameter_names(
    predict_fn, names(model_set@covariate_units)
  )

  model_set
}

setMethod("[[", signature(x = "ModelSet", i = "numeric"), function(x, i) {
  x@models[[i]]
})



setGeneric("rd_model_equation", function(mod) standardGeneric("rd_model_equation"))
setMethod("rd_model_equation", "ModelSet", function(mod) {
  response_name <- names(mod@response_unit)[[1]]

  # TODO assumes a one-line function...will mess with this later.
  func_str <- toString(body(mod@predict_fn))
  clean_str <- gsub("p\\$", "", func_str)
  clean_str <- gsub("\\{,", "", clean_str)
  clean_str <- stringr::str_trim(clean_str)

  model_str <- paste(response_name, "=", clean_str)

  sprintf("\\code{%s}", model_str)
})

setGeneric("rd_variable_defs", function(mod) standardGeneric("rd_variable_defs"))
setMethod("rd_variable_defs", "ModelSet", function(mod) {
  top <- "\\itemize{"
  bottom <- "}"

  response <- names(mod@response_unit)[[1]]
  response_description <- get_variable_def(response)$description

  unit_str <- utils::capture.output(mod@response_unit[[response]])
  unit_str <- stringr::str_sub(unit_str, 3)

  response_label_str <- paste(response, unit_str)

  response_str <- sprintf(
    "\\item{\\code{%s}}{ - %s}", response_label_str,
    response_description
  )

  covt_strs <- c()

  # TODO a lot of DRY here.
  for (i in seq_along(mod@covariate_units)) {
    covariate <- mod@covariate_units[[i]]
    covariate_name <- names(mod@covariate_units)[[i]]
    covt_unit_str <- utils::capture.output(covariate)
    covt_unit_str <- stringr::str_sub(covt_unit_str, 3)

    covt_description <- get_variable_def(covariate_name)$description
    covt_label_str <- paste(covariate_name, covt_unit_str)


    if (identical(covt_description, character(0))) {
      covt_description <- "variable not defined"
    }

    covt_str <- sprintf("\\item{\\code{%s}}{ - %s}", covt_label_str, covt_description)
    covt_strs <- c(covt_strs, covt_str)
  }

  c(top, response_str, covt_strs, bottom)
})

setGeneric("rd_parameter_table", function(mod) standardGeneric("rd_parameter_table"))

setMethod("rd_parameter_table", "ModelSet", function(mod) {
  n_mods <- nrow(mod@model_specifications)
  lines <- utils::capture.output(print(mod@model_specifications, n = n_mods))

  # TODO this can shift the column names weirdly, but an issue for another day...
  lines_no_quote <- stringr::str_replace_all(lines, "\"", " ")

  lines_trim <- lines_no_quote[-c(1, 3)]

  lines_trim_side <- substring(lines_trim, 4)

  fmt_lines <- paste(lines_trim_side, collapse = "\n")

  sprintf("\\preformatted{%s}", fmt_lines)
})
