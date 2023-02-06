.onLoad <- function(libname, pkgname) {
  rds_path <- system.file("extdata/allometric_models.RDS", package = pkgname)

  if (rds_path == "") {
    warning(
      "Install allometric models with install_models() before beginning.",
      call. = FALSE
    )
  } else {
    .GlobalEnv$allometric_models <- readRDS(rds_path)
  }
}
