#' Retrieve all publication file names in the publication subdirectories
#'
#' The publication subdirectories divide the publications into groups sorted
#' by last name. This function returns a list containing the publication paths
#' and the publication names.
#'
#' @keywords internal
get_pub_file_specs <- function(pub_path) {
  sub_dirs <- list.files(pub_path)
  pub_paths <- c()
  pub_names <- c()

  for(dir in sub_dirs) {
    dir_path <- file.path(pub_path, dir)

    names <- list.files(dir_path)
    paths <- file.path(dir_path, names)

    pub_paths <- c(pub_paths, paths)
    pub_names <- c(pub_names, names)
  }

  list(pub_paths = pub_paths, pub_names = pub_names)
}

#' Hashes a function string
#'
#' We need some sort of stable data structure that will serve as a unique ID
#' for a model, but will also change in the event that the model changes. This
#' way, models can be "versioned" across time, which may be useful for debugging
#' purposes down the line. This function trims whitespace and lowercases
#' the predict_fn_populated pasted with the descriptors, which serves as a
#' reasonable proxy for the model.
#'
#' @keywords internal
get_model_hash <- function(predict_fn_populated, descriptors) {
  descriptors_string <- gsub(" ", "", tolower(paste(descriptors, collapse = "")))
  fn_string <- gsub(" ", "", tolower(paste(deparse(predict_fn_populated), collapse = "")))
  hash_str <- paste(descriptors_string, fn_string, sep = "")
  as.character(openssl::md5(hash_str))
}

append_search_descriptors <- function(row, model_descriptors) {
  row$country <- list(unlist(model_descriptors$country))
  row$region <- list(unlist(model_descriptors$region))
  row$taxa <- model_descriptors$taxa
  row
}

#' Creates a dataframe row from model information
#'
#' @keywords internal
create_model_row <- function(model, pub, model_id) {
  model_descriptors <- descriptors(model)

  if(!"taxa" %in% colnames(model_descriptors)) {
    model_descriptors$taxa <- list(Taxa())
  }

  model_row <- tibble::as_tibble(list(pub_id = pub@id))
  model_row$id <- model_id
  model_row$model <- c(model)

  # Gets rid of column not exist errors.
  suppressWarnings(
    model_row <- append_search_descriptors(
      model_row,
      model_descriptors
    )
  )

  family_name <- pub@citation$author$family
  model_row$family_name <- list(as.character(family_name))

  covt_name <- names(model@covariates)
  model_row$covt_name <- list(covt_name)

  pub_year <- as.numeric(pub@citation$year)
  model_row$pub_year <- pub_year

  response_def <- get_variable_def(names(model@response)[[1]], return_exact_only = T)
  model_row$model_type <- model@model_type

  model_row
}

#' Aggregates the set of models in a publication into a model_tbl
#'
#' @param pub The publication object
#' @keywords internal
aggregate_pub_models <- function(pub) {
  agg_models <- list()

  response_sets <- pub@response_sets
  for (i in seq_along(response_sets)) {
    response_set <- response_sets[[i]]
    for (j in seq_along(response_set)) {
      model_set <- response_set[[j]]
      for (k in seq_along(model_set@models)) {
        model <- model_set@models[[k]]
        hash <- get_model_hash(model@predict_fn_populated, descriptors(model))
        model_id <- substr(hash, 1, 8)

        agg_models[[model_id]] <- create_model_row(model, pub, model_id)
      }
    }
  }

  dplyr::bind_rows(agg_models)
}

#' Iteratively process publication files
#'
#' This function allows a user to flexibly extract information as it loops over
#' the publication files. Two main internal use-cases exist for this. First,
#' it is used to install models as is done in `insall_models()` and, second,
#' it is used to populate the remote MongoDB. Most users will not be interested
#' in this function, but it is exposed for usage in the `allodata` package.
#'
#' @param verbose Whether or not to print verbose messages to console
#' @param func The publication processing function. It should take a Publication
#' object as its only argument.
#' @param pub_path An optional path to a publication directory, by
#' default the internally stored set of publications is used.
#' @param params_path An optional path to a parameters directory, by
#' default the internally stored set of parameter files is used.
#' @export
map_publications <- function(verbose, func, pub_path = NULL, params_path = NULL) {
  if(is.null(pub_path)) {
    pub_path <- system.file("models-main/publications", package = "allometric")
  }

  if(!is.null(params_path)) {
    set_params_path(params_path)
  }

  pub_specs <- get_pub_file_specs(pub_path)

  n_pubs <- length(pub_specs$pub_paths)

  pb <- progress::progress_bar$new(
    format = "Running publication file: :pub_id [:bar] :percent",
    total = n_pubs,
    width = 75
  )

  output <- list()

  for (i in 1:n_pubs) {
    pub_env <- new.env()

    pub_r_path <- pub_specs$pub_paths[[i]]
    pub_r_file <- pub_specs$pub_names[[i]]
    pub_name <- tools::file_path_sans_ext(pub_r_file)

    tryCatch({
      source(pub_r_path, local = pub_env)
      pub <- get(pub_name, envir = pub_env)
      output[[pub_name]] <- func(pub)
    }, error = function(e) {
      warning(
        paste(
          "Publication file",
          pub_name,
          "encountered an error during execution:",
          e
        )
      )
    })

    if (verbose) {
      pb$tick(tokens = list(pub_id = pub_name))
    }

    # Remove pub_env from memory
    rm("pub_env")
  }

  # reset the param search path
  if(!is.null(params_path)) {
    set_params_path("pacakge")
  }

  output
}

#' Ingest a set of models by running the publication files
#'
#' @param pub_path A path to a directory containing publication files
#' @param params_path A path to a directory containing parameter files
#' @export
ingest_models <- function(verbose, pub_path = NULL, params_path = NULL) {
  out_order <- c(
    "id", "model_type", "country", "region", "taxa"
  )

  allometric_models <- map_publications(
      verbose, aggregate_pub_models,
      pub_path = pub_path, params_path = params_path
    ) %>%
    dplyr::bind_rows() %>%
    dplyr::arrange(.data$pub_id)

  not_in_order <- colnames(allometric_models)[
    !colnames(allometric_models) %in% out_order
  ]

  order_cols <- c(out_order, not_in_order)

  new_model_tbl(allometric_models[, order_cols])
}