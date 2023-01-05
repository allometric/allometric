

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


build_publication <- function(pub_path) {
  source(pub_path)
}
