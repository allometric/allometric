

#' Checks if the pub_list be generated
#' 
#' The pub_list is regenerated if any file in inst/publications has been
#' modified after the creation of the pub_list
check_run_pub_list <- function(pub_list_path) {
  pub_path <- system.file('publications', package='allometric')
  pub_file_paths <- file.path(pub_path, list.files(pub_path))
  file_info <- file.info(pub_file_paths)
  pub_info <- file.info(pub_list_path)

  if(any(file_info$mtime >= pub_info$mtime)) {
    return(TRUE)
  } else {
    return (FALSE)
  }
}

run_pub_list <- function(verbose = F) {
  pub_path <- system.file('publications', package='allometric')

  pub_r_files <- list.files(pub_path)
  pub_r_paths <- file.path(pub_path, pub_r_files)

  pub_list <- list()

  pub_env <- new.env()

  for (i in seq_along(pub_r_paths)) {
    pub_r_path <- pub_r_paths[[i]]
    pub_r_file <- pub_r_files[[i]]

    if(verbose) {
      cat(paste("Updating publication list for:", pub_r_path, "\n"))
    }

    source(pub_r_path, local = pub_env) # FIXME this loads all pubs into memory anyway...
    pub_name <- tools::file_path_sans_ext(pub_r_file)
    pub <- get(pub_name, envir = pub_env)

    pub_list[[pub@id]] <- pub
  }

  # Remove pub_env from memory
  rm("pub_env")

  pub_list_path <- file.path(system.file('extdata', package = 'allometric'),
    'pub_list.RDS')
  saveRDS(pub_list, pub_list_path)
}

#' 
get_pub_list <- function(verbose = F) {
  pub_list_path <- system.file('extdata/pub_list.RDS', package = 'allometric')


  if(pub_list_path == "")  {
    run_pub_list()
  } else {
    run <- check_run_pub_list(pub_list_path)
    if(run) run_pub_list()
  }

  pub_list_path <- system.file('extdata/pub_list.RDS', package = 'allometric')
  readRDS(pub_list_path)
}

#' Hashes a function string
#'
#' We need some sort of stable data structure that will serve as a unique ID
#' for a model, but will also change in the event that the model changes. This
#' way, models can be "versioned" across time, which may be useful for debugging
#' purposes down the line. This function trims whitespace and lowercases 
#' the predict_fn_populated, which serves as a reasonable proxy for the model.
get_model_hash <- function(predict_fn_populated, descriptors) {
  descriptors_string <- gsub(" ", "", tolower(paste(descriptors, collapse="")))
  fn_string <- gsub(" ", "", tolower(paste(deparse(predict_fn_populated), collapse = "")))
  hash_str <- paste(descriptors_string, fn_string, sep="")
  as.character(openssl::md5(hash_str))
}

#' Transforms a set of searched models into a tibble of models and descriptors
aggregate_results_ext <- function(results) {
  search_descriptors <- c(
    "family", "genus", "species", "country", "region"
  )

  out_order <- c(
    "id", "component", "measure", "country", "region",
    "family", "genus", "species", "model"
  )

  agg_results <- list()
  for (i in seq_along(results)) {
    result <- results[[i]]
    model <- result$model
    pub <- result$pub

    model_descriptors <- c(
      model@descriptors,
      model@pub_descriptors,
      model@set_descriptors
    )

    descriptors_row <- tibble::as_tibble(list(pub_id = pub@id))

    descriptors_row$id <- result$id
    descriptors_row$model <- c(model)

    descriptors_row$country <- list(model_descriptors$country)

    if(is.null(model_descriptors$country)) {
      stop(paste(TextCite(pub@citation), 'did not contain a country code.'))
    }

    descriptors_row$region <- list(model_descriptors$region)
    descriptors_row$family <- model_descriptors$family
    descriptors_row$genus <- model_descriptors$genus
    descriptors_row$species <- model_descriptors$species

    family_names <- pub@citation$author$family
    descriptors_row$family_names <- list(as.character(family_names))

    covt_names <- names(model@covariate_units)
    descriptors_row$covt_names <- list(covt_names)

    pub_year <- as.numeric(pub@citation$year)
    descriptors_row$pub_year <- pub_year

    response_def <- get_variable_def(names(model@response_unit)[[1]])

    descriptors_row$component <- response_def$component_name
    descriptors_row$measure <- response_def$measure_name

    agg_results[[i]] <- descriptors_row
  }

  agg_results <- dplyr::bind_rows(agg_results) %>%
    dplyr::arrange(family, genus, species)

  # Order the columns
  not_in_order <- colnames(agg_results)[!colnames(agg_results) %in% out_order]
  order_cols <- c(out_order, not_in_order)

  agg_results[, order_cols]
}

id_exists <- function(model_ids, proxy_id) {
  match_ix <- which(model_ids$proxy_id == proxy_id)

  if(identical(match_ix, integer(0))) {
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

get_model_results <- function(pub_list) {
  results <- list()
  model_ids_path <- system.file('model_ids.csv', package = 'allometric')
  model_ids <- read.csv(model_ids_path,
    colClasses = c(proxy_id = 'character', id = 'character'))

  current_ids <- model_ids$proxy_id

  for (i in seq_along(pub_list)) {
    pub <- pub_list[[i]]
    response_sets <- pub@response_sets
    for (j in  seq_along(response_sets)) {
      response_set <- response_sets[[j]]
      for (k in seq_along(response_set)) {
        model_set <- response_set[[k]]
        for (l in seq_along(model_set@models)) {
          model <- model_set@models[[l]]
          proxy_id <- get_model_hash(model@predict_fn_populated, descriptors(model))

          if(!proxy_id %in% current_ids) {
            id <- uuid8()
            model_ids <- append_id(model_ids, proxy_id, id)
          } else {
            id <- model_ids[model_ids$proxy_id == proxy_id, 'id']
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

  # these models no longer exist
  delete_ids <- current_ids
  delete_ixs <- which(model_ids$proxy_id %in% delete_ids)

  if(!identical(delete_ixs, integer(0))) {
    model_ids <- model_ids[-delete_ixs,]
  }

  write.csv(model_ids, model_ids_path, row.names=F)
  results
}






get_allometric_models_ext <- function(pub_list) {
  pub_list <- update_pub_list()
  results <- get_model_results()

  aggregate_results_ext(results)
}

update_references <- function() {

}

update_reference_index <- function() {

}