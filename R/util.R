

get_ranef_names <- function(predict_ranef) {
  predict_body <- body(predict_ranef)
  last_line_ix <- length(predict_body)
  ranef_list <- predict_body[[last_line_ix]]
  expr_names <- names(ranef_list)
  list_names <- expr_names[-1]
  list_names
}

build_publication <- function(pub_path) {
  source(pub_path)
}

# No clean way to check for existing custom units...
tryCatch(
  {
    units::install_unit("log")
    return(TRUE)
  }, error = function(cond) {
  }, warning = function(cond) {
  }
)
