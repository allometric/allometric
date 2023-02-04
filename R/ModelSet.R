

check_model_set_validity <- function(object) {
  # TODO the number of distinct rows of model_specifications using the
  # non-parameter columns needs to be equalto the total number of rows
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



setMethod("rd_model_equation", "ModelSet", function(set) {
  response_name <- names(set@response_unit)[[1]]
  func_body <- body(set@predict_fn)
  func_str <- toString(func_body[length(func_body)])

  clean_str <- gsub("p\\$", "", func_str)
  clean_str <- stringr::str_trim(clean_str)

  model_str <- paste(response_name, "=", clean_str)

  sprintf("\\code{%s}", model_str)
})

setMethod("rd_variable_defs", "ModelSet", function(set) {
  top <- "\\itemize{"
  bottom <- "}"

  variable_descs <- .get_variable_descriptions(set)
  body_strs <- c()
  for (i in seq_len(nrow(variable_descs))) {
    var_i <- variable_descs[i, ]
    var_unit_str <- paste(var_i$name, var_i$unit_label)

    var_str <- sprintf(
      "\\item{\\code{%s}}{ - %s}",
      var_unit_str,
      var_i$desc
    )

    body_strs <- c(body_strs, var_str)
  }

  c(top, body_strs, bottom)
})


setMethod("rd_parameter_table", "ModelSet", function(set) {
  n_mods <- nrow(set@model_specifications)
  lines <- utils::capture.output(print(set@model_specifications, n = n_mods))

  # TODO this can shift the column names weirdly, but an issue for another day...
  lines_no_quote <- stringr::str_replace_all(lines, "\"", " ")

  lines_trim <- lines_no_quote[-c(1, 3)]

  fmt_lines <- paste(lines_trim, collapse = "\n")

  sprintf("\\preformatted{%s}", fmt_lines)
})
