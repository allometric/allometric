prepare_authors <- function(authors) {
  out <- list()

  for(i in seq_along(authors)) {
    author_parsed <- list(
      given = paste(authors[[i]]$given, collapse = " "),
      family = paste(authors[[i]]$family, collapse = " ")
    )

    out[[i]] <- author_parsed
  }

  out
}

prepare_citation <- function(citation) {
  # Prepare output list with required fields
  unclassed_citation <- attributes(unclass(citation)[[1]])
  prepared_authors <- prepare_authors(citation$author)

  optional <- c(
    "institution", "publisher", "journal", "volume", "number", "pages",
    "address", "month", "school", "note", "organization", "series", "booktitle",
    "editor", "howpublished"
  )

  required <- list(
    title = jsonlite::unbox(citation$title),
    bibtype = jsonlite::unbox(unclassed_citation$bibtype),
    pub_id = jsonlite::unbox(unclassed_citation$key),
    year = jsonlite::unbox(as.numeric(citation$year)),
    authors = prepared_authors
  )

  for(opt in optional) {
    val <- do.call("$", list(citation, opt))

    if(!is.null(val)) {
      required[[opt]] <- jsonlite::unbox(val)
    }
  }

  required
}

prepare_variables <- function(variables) {
  variable_names <- names(variables)
  out <- list()

  for(i in 1:length(variables)) {
    out[[i]] <- list(
      name = variable_names[[i]],
      unit = parse_unit_str(variables[[i]])
    )
  }

  out
}

unbox_nested <- function(object) {
  for(i in 1:length(object)) {
    for(j in 1:length(object[[i]])) {
      object[[i]][[j]] <- jsonlite::unbox(object[[i]][[j]])
    }
  }
  object
}

unbox_nonnested <- function(object) {
  for(i in 1:length(object)) {
    object[[i]] <- jsonlite::unbox(object[[i]])
  }

  object
}

prepare_descriptors <- function(descriptors) {
  descriptors_list <- as.list(descriptors)

  for(i in 1:length(descriptors_list)) {
    if(typeof(descriptors_list[[i]]) == "list")  {
      descriptors_list[[i]] <- unlist(descriptors_list[[i]])
    }
  }

  descriptors_list
}

#' The RefManageR::Cite function is notoriously unreliable. Instead, we create
#' our own inline citation directly.
prepare_inline_citation <- function(citation) {
  n_authors <- length(citation$author)

  pub_year <- citation$year
  family_names <- c()

  for(i in 1:n_authors) {
    family_names <- c(family_names, citation$author[[i]]$family)
  }

  if(n_authors == 2) {
    out <- paste(
      family_names[[1]], " and ", family_names[[2]],
      " (", pub_year, ")",
      sep = ""
    )
  } else if(n_authors == 1) {
    out <- paste(
      family_names[[1]], " ",
      "(", pub_year, ")",
      sep = ""
    )
  } else {
    out <- paste(
      family_names[[1]], " et al. ",
      "(", pub_year, ")",
      sep = ""
    )
  }

  out
}

parse_func_body <- function(func_body) {
  body_list <- as.list(body(func_body))[-1]
  body_characters <- c()

  for(i in 1:length(body_list)) {
    deparsed_line <- deparse(body_list[[i]])
    pasted_line <- paste(deparsed_line, collapse = "")
    squished_line <- stringr::str_squish(pasted_line)

    body_characters <- c(body_characters, squished_line)
  }

  body_characters
}

prepare_model <- function(model) {
  proxy_id <- get_model_hash(
    model@predict_fn_populated, descriptors(model)
  )

  model_id <- substr(proxy_id, 1, 8)
  model_descriptors <- descriptors(model)

  list(
    model_id = jsonlite::unbox(model_id),
    pub_id = jsonlite::unbox(model@pub_id),
    model_type = jsonlite::unbox(get_model_type(names(model@response_unit))[[1]]),
    response = prepare_variables(model@response_unit)[[1]],
    covariates = unbox_nested(prepare_variables(model@covariate_units)),
    descriptors = prepare_descriptors(model_descriptors),
    parameters = unbox_nonnested(as.list(model@parameters)),
    model_call = jsonlite::unbox(model_call(model)),
    predict_fn_body = parse_func_body(model@predict_fn),
    predict_fn_populated_body = parse_func_body(model@predict_fn_populated)
  )
}

prepare_publication <- function(publication) {
  prepared_citation <- prepare_citation(publication@citation)
  models <- list()


  l <- 1
  for(i in 1:length(publication@response_sets)) { # response set
    response_set_i <- publication@response_sets[[i]]
    for(j in 1:length(response_set_i)) { # model set
      model_set_ij <- response_set_i[[j]]

      for(k in 1:length(model_set_ij@models)) {
        model_ijk <- model_set_ij@models[[k]]

        models[[l]] <- prepare_model(model_ijk, publication)

        l <- l + 1
      }

    }
  }


  list(
    pub = list(
      "_id" = jsonlite::unbox(publication@id),
      citation = prepared_citation,
      pub_descriptors = ifelse(nrow(publication@descriptors) == 0, list(), as.list(publication@descriptors))
    ),
    models = models
  )
}