# Functions used to convert models and publications to JSON

authors_to_json <- function(authors) {
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

citation_to_json <- function(citation) {
  # Prepare output list with required fields
  unclassed_citation <- attributes(unclass(citation)[[1]])
  prepared_authors <- authors_to_json(citation$author)

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

variables_to_json <- function(variables) {
  variable_names <- names(variables)
  out <- list()

  for(i in 1:length(variables)) {
    out[[i]] <- list(
      name = variable_names[[i]],
      unit = parse_unit_str(variables[i])
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

descriptors_to_json <- function(descriptors) {
  descriptors_list <- as.list(descriptors)
  if(length(descriptors_list) == 0) {
    return(NULL) # A null value will be encoded as an empty object in JSON
  } else {
    for(i in 1:length(descriptors_list)) {
      if(typeof(descriptors_list[[i]]) == "list")  {
        descriptors_list[[i]] <- unlist(descriptors_list[[i]])
      } else if(is.na(descriptors_list[[i]])) {
        descriptors_list[[i]] <- list()
      }
    }
  }

  descriptors_list
}

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

covariate_definitions_to_json <- function(covt_def_data) {
  if(length(covt_def_data) == 0) {
    return(list())
  } else {

    variable_names <- names(covt_def_data)
    out <- list()

    for(i in 1:length(covt_def_data)) {
      out[[i]] <- list(
        name = variable_names[[i]],
        definition = covt_def_data[[i]]
      )
    }

    return(unbox_nested(out))
  }
}

model_to_json <- function(model) {
  proxy_id <- get_model_hash(
    model@predict_fn_populated, descriptors(model)
  )

  model_id <- substr(proxy_id, 1, 8)
  model_descriptors <- descriptors(model)
  model_class <- as.character(class(model))

  response_definition <- ifelse(
    is.na(model@response_definition), "", model@response_definition
  )

  required <- list(
    model_id = jsonlite::unbox(model_id),
    pub_id = jsonlite::unbox(model@pub_id),
    model_type = jsonlite::unbox(get_model_type(names(model@response_unit))[[1]]),
    model_class = jsonlite::unbox(model_class),
    response = unbox_nested(variables_to_json(model@response_unit))[[1]],
    covariates = unbox_nested(variables_to_json(model@covariate_units)),
    descriptors = descriptors_to_json(model_descriptors),
    parameters = unbox_nonnested(as.list(model@parameters)),
    predict_fn_body = parse_func_body(model@predict_fn)
  )

  if(!is.na(model@response_definition)) {
    required[["response_definition"]] <- jsonlite::unbox(response_definition)
  }

  if(!length(model@covariate_definitions) == 0) {
    required[["covariate_definitions"]] <- covariate_definitions_to_json(model@covariate_definitions)
  }

  required
}

publication_to_json <- function(publication) {
  citation_json <- citation_to_json(publication@citation)
  models <- list()


  l <- 1
  for(i in 1:length(publication@response_sets)) { # response set
    response_set_i <- publication@response_sets[[i]]
    for(j in 1:length(response_set_i)) { # model set
      model_set_ij <- response_set_i[[j]]

      for(k in 1:length(model_set_ij@models)) {
        model_ijk <- model_set_ij@models[[k]]

        models[[l]] <- model_to_json(model_ijk)

        l <- l + 1
      }

    }
  }


  list(
    pub = list(
      "_id" = jsonlite::unbox(publication@id),
      citation = citation_json,
      pub_descriptors = ifelse(nrow(publication@descriptors) == 0, list(), as.list(publication@descriptors))
    ),
    models = models
  )
}
