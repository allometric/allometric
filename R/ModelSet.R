

check_model_set_validity <- function(object) {
  # TODO the number of distinct rows of model_specifications using the
  # non-parameter columns needs to be equalto the total number of rows
  errors <- c()
  errors <- c(errors, check_descriptor_validity(object@descriptors))
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

setMethod("[[", signature(x = "ModelSet", i = "numeric"), function(x, i) {
  x@models[[i]]
})



setMethod("rd_model_equation", "ModelSet", function(mod) {
  response_name <- names(mod@response_unit)[[1]]
  func_body <- body(mod@predict_fn)
  func_str <- toString(func_body[length(func_body)])

  clean_str <- gsub("p\\$", "", func_str)
  clean_str <- stringr::str_trim(clean_str)

  model_str <- paste(response_name, "=", clean_str)

  sprintf("\\code{%s}", model_str)
})

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

  # TODO a lot of DRY here, can this by "synthesized" with summary.R fns?
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


setMethod("rd_parameter_table", "ModelSet", function(mod) {
  n_mods <- nrow(mod@model_specifications)
  lines <- utils::capture.output(print(mod@model_specifications, n = n_mods))

  # TODO this can shift the column names weirdly, but an issue for another day...
  lines_no_quote <- stringr::str_replace_all(lines, "\"", " ")

  lines_trim <- lines_no_quote[-c(1, 3)]

  fmt_lines <- paste(lines_trim, collapse = "\n")

  sprintf("\\preformatted{%s}", fmt_lines)
})
