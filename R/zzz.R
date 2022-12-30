.onLoad <- function(libname, pkgname) {
  # FIXME this idea does not seem to work
  mod_check <- system.file("data/allometric_models.RDS", package = pkgname)

  if (mod_check == "") {
    install_models()
  } else {
    library(tibble)
    data <- readRDS("./data/allometric_models.RDS")
    .GlobalEnv$allometric_models <- data
  }
}
