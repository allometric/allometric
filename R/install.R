check_models_downloaded <- function(verbose) {
  model_dir_path <- system.file("models-lfs", package = "allometric")

  if(model_dir_path == "") {
    if(verbose) {
      cat("No previously downloaded models are found.\n")
    }
    return(FALSE)
  } else {
    if(verbose) {
      cat("Previously downloaded models found.\n")
    }
    return(TRUE)
  }
}

#' Check if allometric models are currently installed
#'
#' @param verbose Print verbose messages if TRUE
#' @export
check_models_installed <- function(verbose = FALSE) {
  model_data_path <- system.file(
    "extdata/allometric_models.RDS",
    package = "allometric"
  )

  if(model_data_path == "") {
    if(verbose) {
      cat("No installed models are found.\n")
    }
    return(FALSE)
  } else {
    if(verbose) {
      cat("Installed models found.\n")
    }
    return(TRUE)
  }
}

#' Delete the local models directory.
#'
#' @keywords internal
delete_models <- function(verbose) {
  models_path_check <- system.file("models-lfs", package = "allometric")

  if(models_path_check != "") {
    if(verbose) {
      cat("Deleting models directory.\n")
    }

    shell_command <- paste('rmdir /s /q "', models_path_check, '"', sep = "")
    shell(shell_command)
  }

  model_list_path_check <- system.file(
    "extdata/model_list.RDS", package = "allometric"
  )

  pub_list_path_check <- system.file(
    "extdata/pub_list.RDS", package = "allometric"
  )

  if(model_list_path_check != "") {
    if(verbose) {
      cat("Deleting model list.\n")
    }
    shell_command <- paste('rm "', model_list_path_check, '"', sep = "")
    shell(shell_command)
  }

  if(pub_list_path_check != "") {
    if(verbose) {
      cat("Deleting publication list.\n")
    }
    shell_command <- paste('rm "', pub_list_path_check, '"', sep = "")
    shell(shell_command)
  }
}

#' Download allometric models
#'
#' This function downloads allometric models from GitHub into the local package
#' directory. Any existing models are removed before downloading.
#'
#' @keywords internal
download_models <- function(verbose) {
  delete_models(verbose)

  pkg_path <- system.file("", package = "allometric")

  model_dir_path <- file.path(pkg_path, "models-lfs")
  zip_path <- file.path(pkg_path, "models.zip")

  dir.create(model_dir_path)

  curl::curl_download(
    "https://github.com/allometric/models/archive/refs/heads/lfs.zip",
    zip_path
  )

  utils::unzip(zip_path, exdir = pkg_path)
  file.remove(zip_path)
}

#' Install allometric models from the models repository
#'
#' Allometric models are stored in a remote repository located on GitHub located
#' \href{https://github.com/allometric/models}{here}. The user must install
#' these models themselves using this function. This function clones the models
#' repository within the allometric package directory and constructs a local
#' dataframe containing the models. Refer to `load_models()` for information
#' about loading the models dataframe.
#'
#' @param ingest If `TRUE`, model publication files are run locally, otherwise
#' a previously prepared `.RDS` file is used as the models data.
#' @param redownload If `TRUE`, models are re-downloaded from the remote
#' repository.
#' @param verbose If `TRUE`, print verbose messages as models are installed.
#' @return No return value, installs models into the package directory.
#' @export
install_models <- function(ingest = FALSE, redownload = TRUE, verbose = TRUE) {
  downloaded <- check_models_downloaded(verbose)

  if (!downloaded || redownload) {
    download_models(verbose)
  }

  if (ingest) {
    models <- ingest_models(verbose)

    out_path <- file.path(
      system.file("models-lfs", package = "allometric"), "models.RDS"
    )

    saveRDS(models, out_path)
  } else {
    models <- readRDS(
      file.path(
        system.file("models-lfs", package = "allometric"), "models.RDS"
      )
    )
  }

  if (verbose) {
    n_models <- nrow(models)
    msg <- paste(
      n_models,
      "models are currently installed, use load_models() to view them.\n"
    )
    cat(msg)
  }
}