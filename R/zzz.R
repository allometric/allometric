.onLoad <- function(libname, pkgname) {
  # FIXME this idea does not seem to work
  rds_path <- system.file("extdata/allometric_models.RDS", package = pkgname)

  if (rds_path == "") {
    warning("Install allometric models with install_models() before beginning.", call.=F)
  } else {
    .GlobalEnv$allometric_models <- readRDS(rds_path)
  }
}
