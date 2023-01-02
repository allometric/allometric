

#' @export
install_models <- function() {
  pub_list <- get_pub_list()
  results <- get_model_results(pub_list)
  data <- aggregate_results_ext(results)

  out_path <- file.path(system.file("extdata", package = "allometric"), "allometric_models.RDS")
  saveRDS(data, out_path)
  .GlobalEnv$allometric_models <- data
}
