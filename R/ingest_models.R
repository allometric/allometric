

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
  row$family <- model_descriptors$family
  row$genus <- model_descriptors$genus
  row$species <- model_descriptors$species
  row
}

#' Creates a dataframe row from model information
#'
#' @keywords internal
create_model_row <- function(model, pub, model_id) {
  model_descriptors <- descriptors(model)

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

  covt_name <- names(model@covariate_units)
  model_row$covt_name <- list(covt_name)

  pub_year <- as.numeric(pub@citation$year)
  model_row$pub_year <- pub_year

  response_def <- get_variable_def(names(model@response_unit)[[1]], return_exact_only = T)
  model_row$model_type <- model@model_type

  model_row
}

#' Aggregates the set of models in a publication into a model_tbl
#'
#' @param pub The publication object
#' @param current_ids An optional vector of currently ingestedmodel  IDs.
#' @keywords internal
aggregate_pub_models <- function(pub, current_ids = c()) {
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

        if(model_id %in% current_ids) {
          msg <- paste(
            "Duplicate model ID found:", model_id, "in publication", pub@id
          )
          stop(msg)
        }

        agg_models[[model_id]] <- create_model_row(model, pub, model_id)
      }
    }
  }

  dplyr::bind_rows(agg_models)
}

#' Create allometric models from parameter and publication files
#'
#' This function ingests models by running each publication R file and
#' populating a dataframe that contains each model object and some metadata.
#' The result of this function creates the table of models obtained using
#' `load_models()`. See `install_models()` for the end-user entrypoint.
#'
#' @keywords internal
ingest_models <- function(verbose, pub_path = NULL) {
  if(is.null(pub_path)) {
    pub_path <- system.file("models-main/publications", package = "allometric")
  }

  pub_specs <- get_pub_file_specs(pub_path)

  n_pubs <- length(pub_specs$pub_paths)

  pb <- progress::progress_bar$new(
    format = "Running publication file: :pub_id [:bar] :percent",
    total = n_pubs,
    width = 75
  )

  model_list <- list()

  out_order <- c(
    "id", "model_type", "country", "region", "family", "genus", "species",
    "model"
  )

  current_ids <- c()

  for (i in 1:n_pubs) {
    pub_env <- new.env()

    pub_r_path <- pub_specs$pub_paths[[i]]
    pub_r_file <- pub_specs$pub_names[[i]]
    pub_name <- tools::file_path_sans_ext(pub_r_file)

    tryCatch({
      source(pub_r_path, local = pub_env)
      pub <- get(pub_name, envir = pub_env)
      model_list[[pub_name]] <- aggregate_pub_models(pub, current_ids)
      current_ids <- c(current_ids, model_list[[pub_name]][["id"]])
    }, error = function(e) {
      warning(paste("Publication file", pub_name, "encountered an error during execution."))
    })

    if (verbose) {
      pb$tick(tokens = list(pub_id = pub_name))
    }

    # Remove pub_env from memory
    rm("pub_env")
  }

  allometric_models <- model_list %>%
    dplyr::bind_rows() %>%
    dplyr::arrange(.data$family, .data$genus, .data$species)

  not_in_order <- colnames(allometric_models)[
    !colnames(allometric_models) %in% out_order
  ]

  order_cols <- c(out_order, not_in_order)

  new_model_tbl(allometric_models[, order_cols])
}
