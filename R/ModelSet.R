setClass(
  "ModelSet",
  slots = c(
    response_unit = "list",
    covariate_units = "list",
    predict_fn = "function",
    model_descriptions = 'tbl_df',
    common_descriptors = "list",
    models = "list",
    id = "numeric"
  )
)

ModelSet <- function(response_unit, covariate_units, predict_fn,
                     common_descriptors, model_descriptions, id = NA_integer_) {
  model_set <- new("ModelSet")

  model_descriptions <- as_tibble(model_descriptions)

  model_set@response_unit <- response_unit
  model_set@covariate_units <- covariate_units
  model_set@model_descriptions <- model_descriptions
  model_set@predict_fn <- predict_fn
  model_set@common_descriptors <- common_descriptors
  model_set@id <- id

  if ("list" %in% class(model_descriptions)) {
    model_descriptions <- tibble(data.frame(model_descriptions))
  }

  for (i in 1:nrow(model_descriptions)) {
    mod <- ParametricModel(
      response_unit = response_unit,
      covariate_units = covariate_units,
      model_description = model_descriptions[i, ],
      predict_fn = predict_fn,
      id = i
    )

    model_set@models[[length(model_set@models) + 1]] <- mod
  }

  model_set
}

setMethod("[[", signature(x= "ModelSet", i="numeric"), function(x, i) {
  x@models[[i]]
})


setGeneric('rd_model_equation', function(mod) standardGeneric('rd_model_equation'))
setMethod('rd_model_equation', 'ModelSet', function(mod) {
  response_name <- names(mod@response_unit)[[1]]

  # TODO assumes a one-line function...will mess with this later.
  func_str <- toString(body(mod@predict_fn))
  clean_str <- gsub('p\\$', '', func_str)
  clean_str <- gsub('\\{,', '', clean_str)
  clean_str <- str_trim(clean_str)

  model_str <- paste(response_name, '=', clean_str)

  sprintf('\\code{%s}', model_str)
})

setGeneric('rd_variable_defs', function(mod) standardGeneric('rd_variable_defs'))
setMethod('rd_variable_defs', 'ModelSet', function(mod) {
  top <- '\\itemize{'
  bottom <- '}'

  response <- names(mod@response_unit)[[1]]
  response_description <- get_variable_def(response)$description

  unit_str <- capture.output(mod@response_unit[[response]])
  unit_str <- str_sub(unit_str, 3)

  response_label_str <- paste(response, unit_str)

  response_str <- sprintf('\\item{\\code{%s}}{ - %s}', response_label_str,
    response_description)

  covt_strs <- c()

  # TODO a lot of DRY here.
  for(i in seq_along(mod@covariate_units)) {
    covariate <- mod@covariate_units[[i]]
    covariate_name <- names(mod@covariate_units)[[i]]
    covt_unit_str <- capture.output(covariate)
    covt_unit_str <- str_sub(covt_unit_str, 3)

    covt_description <- get_variable_def(covariate_name)$description
    covt_label_str <- paste(covariate_name, covt_unit_str)


    if(identical(covt_description, character(0))) {
      covt_description <- 'variable not defined'
    }

    covt_str <- sprintf('\\item{\\code{%s}}{ - %s}', covt_label_str, covt_description )
    covt_strs <- c(covt_strs, covt_str)
  }

  c(top, response_str, covt_strs, bottom)
})

setGeneric('rd_parameter_table', function(mod) standardGeneric('rd_parameter_table'))

setMethod('rd_parameter_table', 'ModelSet', function(mod) {
  n_mods <- nrow(mod@model_descriptions)
  lines <- capture.output(print(mod@model_descriptions, n=n_mods))

  fmt_lines <- paste(lines, collapse="\n")

  sprintf('\\preformatted{%s}', fmt_lines)
})

