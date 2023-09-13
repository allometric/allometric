

#' Retrieve all publication file names in the publication subdirectories
#'
#' The publication subdirectories divide the publications into groups sorted
#' by last name. This function returns the publication file paths in alphabetic
#' order.
#'
#' @keywords internal
get_pub_file_spec <- function(pub_path) {
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


#' Determines which publication files need to be ran for installation
#'
#' The pub_list is regenerated if any files in models/publications have been
#' modified after the creation of the pub_list. Only those files are returned
#' unless ignore_cache is set to TRUE, in which case all files will be returned.
#'
#' @keywords internal
get_run_pubs <- function(ignore_cache = FALSE, verbose = FALSE) {
  pub_list_path <- system.file("extdata/pub_list.RDS", package = "allometric")
  pub_path <- system.file("models/publications", package = "allometric")

  pub_file_spec <- get_pub_file_spec(pub_path)
  pub_file_names <- pub_file_spec$pub_names
  pub_file_paths <- pub_file_spec$pub_paths

  file_info <- file.info(pub_file_paths)
  pub_info <- file.info(pub_list_path)

  file_info.fmt <- file_info %>% tibble::tibble() %>%
    dplyr::mutate(file_path = pub_file_paths, file_name = pub_file_names)

  if (pub_list_path == "" || ignore_cache) {
    return(file_info.fmt)
  } else {
    rerun_info <- file_info.fmt %>%
      dplyr::mutate(rerun = .data$mtime >= pub_info$mtime) %>%
      dplyr::filter(.data$rerun)

    return(rerun_info)
  }
}

get_pub_list <- function(pub_list_path) {
  if (pub_list_path == "") {
    return(list())
  } else {
    return(readRDS(pub_list_path))
  }
}

update_pub_list <- function(run_pubs, verbose = TRUE) {
  pub_list_path <- system.file("extdata/pub_list.RDS", package = "allometric")
  pub_path <- system.file("publications", package = "allometric")

  pub_list <- get_pub_list(pub_list_path)

  pb <- progress::progress_bar$new(
    format = "running publication file :pub_id [:bar] :percent",
    total = nrow(run_pubs)
  )

  if(nrow(run_pubs) == 0 && verbose) {
    cat("No publications required an update.")
  }

  for (i in seq_len(nrow(run_pubs))) {
    pub_env <- new.env()

    pub_r_path <- run_pubs$file_path[[i]]
    pub_r_file <- run_pubs$file_name[[i]]

    source(pub_r_path, local = pub_env)
    pub_name <- tools::file_path_sans_ext(pub_r_file)
    pub <- get(pub_name, envir = pub_env)

    if (verbose) {
      pb$tick(tokens = list(pub_id = pub@id))
    }

    # Remove pub_env from memory
    rm("pub_env")
    pub_list[[pub@id]] <- pub
  }


  pub_list_path <- file.path(
    system.file("extdata", package = "allometric"),
    "pub_list.RDS"
  )
  saveRDS(pub_list, pub_list_path)
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

#' Transforms a set of searched models into a tibble of models and descriptors
#'
#' @keywords internal
aggregate_results <- function(results) {
  search_descriptors <- c(
    "family", "genus", "species", "country", "region"
  )

  out_order <- c(
    "id", "model_type", "country", "region", "family", "genus", "species",
    "model"
  )

  agg_results <- list()
  for (i in seq_along(results)) {
    result <- results[[i]]
    model <- result$model
    pub <- result$pub

    model_descriptors <- descriptors(model)

    descriptors_row <- tibble::as_tibble(list(pub_id = pub@id))

    descriptors_row$id <- result$id[[1]]
    descriptors_row$model <- c(model)

    # Gets rid of column not exist errors.
    suppressWarnings(
      descriptors_row <- append_search_descriptors(
        descriptors_row,
        model_descriptors
      )
    )

    family_name <- pub@citation$author$family
    descriptors_row$family_name <- list(as.character(family_name))

    covt_name <- names(model@covariate_units)
    descriptors_row$covt_name <- list(covt_name)

    pub_year <- as.numeric(pub@citation$year)
    descriptors_row$pub_year <- pub_year

    response_def <- get_variable_def(names(model@response_unit)[[1]], return_exact_only = T)
    descriptors_row$model_type <- model@model_type

    agg_results[[i]] <- descriptors_row
  }

  agg_results <- dplyr::bind_rows(agg_results) %>%
    dplyr::arrange(.data$family, .data$genus, .data$species)

  # Order the columns
  not_in_order <- colnames(agg_results)[!colnames(agg_results) %in% out_order]
  order_cols <- c(out_order, not_in_order)

  agg_results[, order_cols]
}

id_exists <- function(model_ids, proxy_id) {
  match_ix <- which(model_ids$proxy_id == proxy_id)

  if (identical(match_ix, integer(0))) {
    return(FALSE)
  } else {
    return(TRUE)
  }
}

uuid8 <- function() {
  # 8 is more than sufficient for our purposes and infinitely more readable.
  uuid_init <- uuid::UUIDgenerate()
  substr(uuid_init, 1, 8)
}

append_id <- function(model_ids, proxy_id, id) {
  model_ids <- dplyr::bind_rows(list(model_ids, data.frame(proxy_id = proxy_id, id = id)))
  model_ids
}

get_model_results <- function() {
  pub_list_path <- system.file("extdata/pub_list.RDS", package = "allometric")
  pub_list <- readRDS(pub_list_path)

  results <- list()
  model_ids_path <- system.file("model_ids.csv", package = "allometric")

  if (file.exists(model_ids_path)) {
    model_ids <- utils::read.csv(model_ids_path,
      colClasses = c(proxy_id = "character", id = "character")
    ) %>%
      tibble::as_tibble()
    current_ids <- model_ids$proxy_id
  } else {
    model_ids <- tibble::tibble(id = character(0), proxy_id = character(0), .rows = 0)
    model_ids_path <- file.path(system.file("", package = "allometric"), "model_ids.csv")
    current_ids <- model_ids$proxy_id
  }

  for (i in seq_along(pub_list)) {
    pub <- pub_list[[i]]
    response_sets <- pub@response_sets
    for (j in seq_along(response_sets)) {
      response_set <- response_sets[[j]]
      for (k in seq_along(response_set)) {
        model_set <- response_set[[k]]
        for (l in seq_along(model_set@models)) {
          model <- model_set@models[[l]]
          proxy_id <- get_model_hash(model@predict_fn_populated, descriptors(model))

          if (!proxy_id %in% current_ids) {
            id <- substr(proxy_id, 1, 8)
            model_ids <- append_id(model_ids, proxy_id, id)
          } else {
            if (sum(model_ids$proxy_id == proxy_id) > 1) {
              stop(paste("Duplicate model hash found for model in pub:", pub@id))
            }
            id <- model_ids[model_ids$proxy_id == proxy_id, "id"]
          }

          current_ids <- current_ids[!current_ids == proxy_id]
          results[[length(results) + 1]] <- list(
            pub = pub,
            model = model,
            id = id
          )
        }
      }
    }
  }

  delete_ids <- current_ids
  delete_ixs <- which(model_ids$proxy_id %in% delete_ids)

  if (!identical(delete_ixs, integer(0))) {
    model_ids <- model_ids[-delete_ixs, ]
  }

  utils::write.csv(model_ids, model_ids_path, row.names = F)
  results
}
