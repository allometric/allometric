

get_ranef_names <- function(predict_ranef) {
  predict_body <- body(predict_ranef)
  last_line_ix <- length(predict_body)
  ranef_list <- predict_body[[last_line_ix]]
  expr_names <- names(ranef_list)
  list_names <- expr_names[-1]
  list_names
}

get_parameter_names <- function(predict_fn, covariate_names, specifications) {
  predict_body <- body(predict_fn)
  last_line_ix <- length(predict_body)
  body_vars <- all.vars(predict_body[[last_line_ix]])
  body_vars[(!body_vars %in% covariate_names) & (body_vars %in% colnames(specifications))]
}

#' Are all covariates given as arguments?
check_covts_in_args <- function(object) {
  errors <- c()
  fn_args <- names(as.list(args(object@predict_fn)))
  fn_args <- fn_args[-length(fn_args)]

  covt_names <- names(object@covariate_units)
  if(!(all(covt_names %in% fn_args) & all(fn_args %in% covt_names))) {
    msg <- paste('Not all covariate names match function arguments.')
    errors <- c(errors, msg)
  }

  errors
}


#' Are the arguments given in the predict function inside the body?
check_args_in_predict_fn <- function(object) {
  errors <- c()

  fn_body <- body(object@predict_fn)
  fn_args <- names(as.list(args(object@predict_fn)))

  fn_args <- fn_args[-length(fn_args)]

  body_vars <- all.vars(fn_body)

  if (!all(fn_args %in% body_vars)) {
    msg <- paste(
      "Not all predict_fn args",
      paste(fn_args, collapse = ", "),
      "are in the function body."
    )
    errors <- c(msg, errors)
  }

  errors
}

build_publication <- function(pub_path) {
  source(pub_path)
}
