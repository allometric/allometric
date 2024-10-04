#' Get a model with a known `model_id`
#'
#' This function uses the `model/<model_id>` endpoint to retrieve a model
#' with a known `model_id`.
#'
#' @param model_id The 8 character uuid of a model
get_model <- function(model_id, citation = TRUE) {
  if(citation) {
    url <- paste0("https://api.allometric.org/model/", model_id, "?citation=true")
  } else {
    url <- paste0("https://api.allometric.org/model/", model_id)
  }

  res <- httr::GET(url)

  res_content <- httr::content(res)
  model_class <- res_content$model_class

  if(model_class == "FixedEffectsModel") {
    fixef_fromJSON(res_content)
  } else if (model_class == "MixedEffectsModel") {
    mixef_fromJSON(res_content)
  }
}

taxa_args <- c("family", "genus", "species")
descriptor_args <- c("country", "region")

build_filter <- function(filter_args) {
  filter_args <- filter_args[!sapply(filter_args, is.null)]
  filter_names <- names(filter_args)
  query <- list()

  for (i in seq_along(filter_args)) {
    name_i <- filter_names[[i]]

    if (name_i %in% descriptor_args) {
      name_i <- paste0("descriptors.", name_i)
    }

    query_el <- list(
      list(
        `$in` = filter_args[[i]]
      )
    )

    query[[i]] <- query_el[[1]]

    names(query)[[i]] <- name_i
  }

  jsonlite::toJSON(query)
}

#' Query the model database with filters
#'
#' This function uses the `models/{filter}` endpoint to retrieve multiple models
#' matching filter criteria. The results are returned as a `model_tbl`
#'
#' @param model_type
#' @param country
#' @param region
#' @param family
#' @param genus
#' @param species
#' @param pub_id
query_models <- function(
  model_type = NULL, country = NULL, region = NULL, family = NULL, genus = NULL,
  species = NULL, pub_id = NULL, citation = TRUE
)  {
  filter_args <- list(
    model_type = model_type,
    country = country,
    region = region,
    family = family,
    genus = genus,
    species = species,
    pub_id = pub_id
  )

  filter_object <- build_filter(filter_args)

  if (citation) {
    url <- paste0("https://api.allometric.org/models/?citation=true")
  } else {
    url <- paste0("https://api.allometric.org/models/")
  }

  result <- httr::POST(
    url,
    body = filter_object,
    httr::add_headers(
      "Content-Type" = "application/json"
    )
  )

  result_content <- httr::content(result, as = "parsed")

  mod_list <- sapply(result_content, fromJSON)

  model_table <- list()

  for (i in seq_along(mod_list)) {
    model_table[[i]] <- create_model_row(mod_list[[i]])
  }

  dplyr::bind_rows(model_table) |>
    new_model_tbl()
}