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
  models_path_check <- system.file("models", package = "allometric")

  if(models_path_check != "") {
    print("Deleting models directory.")
    shell_command <- paste('rmdir /s /q "', models_path_check, '"', sep = "")
    shell(shell_command)
  }
}

#' @export
install_models <- function(ignore_cache = FALSE, verbose = FALSE) {
  downloaded <- check_models_downloaded()

  if(!downloaded) {
    print("Cloning allometric/models repository.")

    pkg_path <- system.file("", package = "allometric")
    model_dir_path <- file.path(pkg_path, "models")

    dir.create(model_dir_path)

    gert::git_clone(
      "https://github.com/allometric/models.git",
      path = model_dir_path,
      verbose = FALSE
    )
  } else {
    print("Pulling allometric/models repository.")

    pkg_path <- system.file("", package = "allometric")
    model_dir_path <- file.path(pkg_path, "models")
    gert::git_pull(repo = model_dir_path)
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
