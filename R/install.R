check_models_downloaded <- function(verbose) {
  dist_path <- system.file("models-main/dist", package = "allometric")

  if (dist_path == "") {
    if (verbose) {
      cli::cli_alert_info("No previously downloaded models are found.")
    }
    return(FALSE)
  } else {
    if (verbose) {
      cli::cli_alert_info("Previously downloaded models found.")
    }
    return(TRUE)
  }
}

#' Check if allometric models are currently installed
#'
#' @param verbose Print verbose messages if TRUE
#' @export
check_models_installed <- function(verbose = FALSE) {
  dist_path <- system.file("models-main/dist", package = "allometric")
  dist_files <- file.path(
    dist_path,
    c("models.parquet", "model_specs.parquet", "publications.parquet")
  )

  if (dist_path != "" && all(file.exists(dist_files))) {
    if (verbose) {
      cli::cli_alert_info("Installed models found.")
    }
    return(TRUE)
  } else {
    if (verbose) {
      cli::cli_alert_info("No installed models are found.")
    }
    return(FALSE)
  }
}

#' Delete the local models directory.
#'
#' @keywords internal
delete_models <- function(verbose) {
  models_path_check <- system.file("models-main", package = "allometric")

  if (models_path_check != "") {
    if (verbose) {
      cli::cli_alert_info("Deleting models directory.")
    }

    unlink(models_path_check, recursive = TRUE, force = TRUE)
  }
}

#' Download the compiled v4 models distribution
#'
#' Downloads the three parquet tables (`models`, `model_specs`,
#' `publications`) from the `dist/` directory of the allometric/models
#' repository into the local package directory. Any existing models are
#' removed before downloading.
#'
#' @keywords internal
download_models <- function(verbose) {
  delete_models(verbose)

  pkg_path <- system.file("", package = "allometric")
  dist_path <- file.path(pkg_path, "models-main", "dist")

  download_dist_files(dist_path)
}

#' Download the three v4 parquet tables into a directory
#'
#' @param dist_path The directory to write the parquet files into (created if
#'   needed)
#' @param branch The models repository branch that publishes the compiled
#'   distribution. The v4 parquet output currently lives on the `v4` branch.
#' @keywords internal
download_dist_files <- function(dist_path, branch = "v4") {
  dir.create(dist_path, recursive = TRUE, showWarnings = FALSE)

  base_url <- paste0(
    "https://raw.githubusercontent.com/allometric/models/", branch, "/dist"
  )
  dist_files <- c("models.parquet", "model_specs.parquet", "publications.parquet")

  for (file in dist_files) {
    curl::curl_download(
      file.path(base_url, file),
      file.path(dist_path, file)
    )
  }
}

#' Install allometric models from the models repository
#'
#' Allometric models are stored in a remote repository located on GitHub located
#' \href{https://github.com/allometric/models}{here}. The user must install
#' these models themselves using this function. This function downloads the
#' compiled v4 parquet distribution from the models repository and installs it
#' within the allometric package directory. Refer to `load_models()` for
#' information about loading the models dataframe.
#'
#' @param redownload If `TRUE`, models are re-downloaded from the remote
#' repository.
#' @param verbose If `TRUE`, print verbose messages as models are installed.
#' @return No return value, installs models into the package directory.
#' @export
install_models <- function(redownload = TRUE, verbose = TRUE) {
  downloaded <- check_models_downloaded(verbose)

  if (!downloaded || redownload) {
    download_models(verbose)
  }

  n_models <- nrow(
    arrow::read_parquet(
      file.path(
        system.file("models-main/dist", package = "allometric"),
        "model_specs.parquet"
      )
    )
  )

  if (verbose) {
    cli::cli_alert_success(
      paste(
        n_models,
        "models were succesfully installed, use load_models() to access them."
      )
    )
  }
}
