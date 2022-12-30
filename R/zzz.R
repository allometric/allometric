.onLoad <- function(libname, pkgname) {
  # FIXME this idea does not seem to work
  mod_check <- system.file("data/allometric_models.RDS", package = pkgname)

  if (mod_check == "") {
    #install_models()
  } else {
    #library(tibble)
    rds_path <- system.file("extdata/allometric_models.RDS", package = pkgname)
    data <- readRDS(rds_path)
    .GlobalEnv$allometric_models <- data
  }
}
