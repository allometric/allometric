check_models_downloaded <- function(verbose) {
  model_dir_path <- system.file("models-refactor_variable_args", package = "allometric")

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

#' Delete the local models directory.
#'
#' @keywords internal
delete_models <- function(verbose) {
  models_path_check <- system.file("models-refactor_variable_args", package = "allometric")

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

  model_dir_path <- file.path(pkg_path, "models-refactor_variable_args")
  zip_path <- file.path(pkg_path, "models.zip")

  dir.create(model_dir_path)

  latest_commit <- gh::gh("GET /repos/allometric/models/commits/main")
  sha_7 <- substr(latest_commit$sha, 1, 7)

  if(verbose) {
    msg <- paste(
      "Downloading allometric/models repository.\n   Retrieving latest commit: ", sha_7, "\n",
      sep = ""
    )

    cat(msg)
  }

  curl::curl_download(
    "https://github.com/allometric/models/archive/refs/heads/refactor_variable_args.zip",
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
#' dataframe containing the models. This dataframe is stored in the global
#' environment variable `allometric_models` upon completion of the function.
#' Refer to `allometric::allometric_models` for further information.
#'
#' @param redownload If `TRUE`, models are re-downloaded from the remote
#' repository.
#' @param ignore_cache If `TRUE`, models are re-installed regardless of their
#' installation timestamp. Otherwise, only newly modified model files are reran.
#' This is primarily for development purposes.
#' @param verbose If `TRUE`, print verbose messages as models are installed.
#' @return No return value, installs models into the package directory.
#' @export
install_models <- function(redownload = FALSE,
    ignore_cache = FALSE, verbose = TRUE
  ) {
  downloaded <- check_models_downloaded(verbose)

  if(!downloaded || redownload) {
    download_models(verbose)
  }

  allometric_models <- ingest_models(verbose)

  out_path <- file.path(
    system.file("extdata", package = "allometric"), "allometric_models.RDS"
  )

  if(verbose) {
    n_models <- nrow(allometric_models)
    msg <- paste(
      n_models,
      "models succesfully installed, use load_models() to view them.\n"
    )
    cat(msg)
  }

  saveRDS(allometric_models, out_path)
}