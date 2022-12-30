

#' @export
install_models <- function() {
  source(system.file("build_scripts/1_update_pub_list.R", package = "allometric"))
  source(system.file("build_scripts/2_update_allometric_models.R", package = "allometric"))

  data <- readRDS(system.file("extdata/allometric_models.RDS", package = "allometric"))
  .GlobalEnv$allometric_models <- data
}
