check_models_downloaded <- function() {
  model_dir_path <- system.file("models", package = "allometric")

  if(model_dir_path == "") {
    return(FALSE)
  } else {
    return(TRUE)
  }
}

#' Delete the local models directory.
#'
#' @keywords internal
delete_models <- function() {
  models_path_check <- system.file("models-main", package = "allometric")

  if(models_path_check != "") {
    cat("Deleting models directory.\n")
    shell_command <- paste('rmdir /s /q "', models_path_check, '"', sep = "")
    shell(shell_command)
  }

  model_list_path_check <- system.file("extdata/model_list.RDS", package = "allometric")
  pub_list_path_check <- system.file("extdata/pub_list.RDS", package = "allometric")

  if(model_list_path_check != "") {
    cat("Deleting model list.\n")
    shell_command <- paste('rm "', model_list_path_check, '"', sep = "")
    shell(shell_command)
  }

  if(pub_list_path_check != "") {
    cat("Deleting publication list.\n")
    shell_command <- paste('rm "', pub_list_path_check, '"', sep = "")
    shell(shell_command)
  }
}

#' Download allometric models
#'
#' This clones allometric models from GitHub into the local package directory
#' @keywords internal
download_models <- function() {
  delete_models()

  pkg_path <- system.file("", package = "allometric")
  
  model_dir_path <- file.path(pkg_path, "models-main")
  zip_path <- file.path(pkg_path, "models.zip")

  dir.create(model_dir_path)
  cat("Downloading allometric/models repository.\n")

  curl::curl_download(
    "https://github.com/allometric/models/archive/refs/heads/main.zip",
    zip_path
  )

  unzip(zip_path, exdir = pkg_path)
  rm(zip_path)
}

#' Install allometric models
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
#' @export
install_models <- function(redownload = FALSE,
    ignore_cache = FALSE, verbose = FALSE
  ) {
  downloaded <- check_models_downloaded()

  if(!downloaded || redownload) {
    download_models()
  }

  run_pub_list <- get_run_pubs(ignore_cache, verbose)
  update_pub_list(run_pub_list)

  results <- get_model_results()
  data <- aggregate_results(results)
  data <- new_model_tbl(data)

  out_path <- file.path(
    system.file("extdata", package = "allometric"), "allometric_models.RDS"
  )

  saveRDS(data, out_path)
  .GlobalEnv$allometric_models <- data
}
