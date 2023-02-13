

#' @export
install_models <- function(ignore_cache = FALSE, verbose = FALSE) {
  run_pub_list <- get_run_pubs(ignore_cache, verbose)
  update_pub_list(run_pub_list)

  results <- get_model_results()
  data <- aggregate_results(results)
  data <- new_model_tbl(data)

  #out_path <- file.path(system.file("extdata", package = "allometric"), "allometric_models.RDS")
  #saveRDS(data, out_path)
  #.GlobalEnv$allometric_models <- data
}
