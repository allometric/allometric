get_parameter_names <- function(predict_fn, covariate_names) {
  body_vars <- all.vars(body(predict_fn))
  body_vars[!body_vars %in% covariate_names]
}