.onLoad <- function(libname, pkgname) {
  # FIXME this idea does not seem to work
  rds_path <- system.file("extdata/allometric_models.RDS", package = pkgname)

  if (rds_path == "") {
    cat("Install models with install_models() before beginning.")
  } else {
    .GlobalEnv$allometric_models <- readRDS(rds_path)
  }
}

