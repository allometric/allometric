# Functions used to convert models and publications to S4 objects from JSON

concatenate_authors <- function(author_data) {
  n_authors <- length(author_data)
  authors_str <- c()
  for (i in seq_along(author_data)) {

    author <- author_data[[i]]

    author_str <- paste0(author$family, ", ", author$given)

    if (i < n_authors) {
      author_str <- paste0(author_str, " and")
    }

    authors_str <- c(authors_str, author_str)

  }

  authors_str
}

citation_to_S4 <- function(citation_data) {
  authors <- concatenate_authors(citation_data[["authors"]])

  citation_data <- citation_data[names(citation_data) != "authors"]
  citation_data[["author"]] <- authors

  citation_data[["key"]] <- citation_data$pub_id

  do.call(RefManageR::BibEntry, citation_data)
}

response_to_S4 <- function(response_data) {
  response <- list()
  response[[response_data$name]] <- units::as_units(response_data$unit)

  response
}

covariates_to_S4 <- function(covariates_data) {
  covariates <- list()
  
  for(i in seq_along(covariates_data)) {
    covt_name_i <- covariates_data[[i]]$name
    covt_unit_i <- covariates_data[[i]]$unit

    covariates[[covt_name_i]] <- units::as_units(covt_unit_i)
  }

  covariates
}

parameters_to_S4 <- function(parameters_data) {
  parameters <- list()

  for(i in 1:length(parameters_data)) {
    parameters[[names(parameters_data)[[i]]]] <- parameters_data[[i]]
  }

  parameters
}

predict_fn_to_S4 <- function(predict_fn_data, covariates_data) {
  func_args <- c()

  for(i in seq_along(covariates_data)) {
    func_args <- c(func_args, covariates_data[[i]][["name"]])
  }

  func_args <- paste(func_args, collapse = ", ")

  base_func_str <- paste(
    "function(", func_args, ") {}", sep = ""
  )

  func <- eval(parse(text = base_func_str))

  # TODO would be nice to preserve the linebreaks
  body(func) <- parse(text = paste(" {",paste(predict_fn_data, collapse = ";") , "}") )

  func
}

taxa_to_S4 <- function(taxa_list) {
  taxons <- list()

  for (i in seq_along(taxa_list)) {
    taxon_i <- taxa_list[[i]]
    taxons[[i]] <- Taxon(
      family = ifelse(is.null(taxon_i$family[[1]]), NA, taxon_i$family[[1]]),
      genus = ifelse(is.null(taxon_i$genus[[1]]), NA, taxon_i$genus[[1]]),
      species = ifelse(is.null(taxon_i$species[[1]]), NA, taxon_i$species[[1]])
    )
  }

  do.call(Taxa, taxons)
}

#' Convert the descriptors JSON data to a named list of descriptors
#'
#' @keywords internal
descriptors_to_S4 <- function(descriptors_data) {
  for(i in seq_along(descriptors_data)) {
    name_i <- names(descriptors_data)[[i]]
    val_i <- descriptors_data[[i]]

    if(name_i == "taxa") {
      descriptors_data[[name_i]] <- list(taxa_to_S4(val_i))
    } else if(length(val_i) == 0) {
      descriptors_data[[name_i]] <- c(NA_character_)
    } else if(length(val_i) == 1){
      descriptors_data[[name_i]] <- unlist(val_i)
    } else {
      descriptors_data[[name_i]] <- list(unlist(val_i))
    }
  }
  
  tibble::as_tibble_row(descriptors_data)
}

covt_defs_to_S4 <- function(covt_defs_data) {
  covt_defs <- list()

  for(i in seq_along(covt_defs_data)) {
    covt_defs[[covt_defs_data[[i]][["name"]]]] <- covt_defs_data[[i]][["definition"]]
  }

  covt_defs
}

fixef_fromJSON <- function(parsed_json) {
  if(!is.null(parsed_json$response_definition)) {
    response_definition <- parsed_json$response_definition
  } else {
    response_definition <- NA_character_
  }

  if(!is.null(parsed_json$covariate_definitions)) {
    covariate_definitions <- covt_defs_to_S4(parsed_json$covariate_definitions)
  } else {
    covariate_definitions <- list()
  }

  mod <- FixedEffectsModel(
    response = response_to_S4(parsed_json$response),
    covariates = covariates_to_S4(parsed_json$covariates),
    parameters = parameters_to_S4(parsed_json$parameters),
    predict_fn = predict_fn_to_S4(parsed_json$predict_fn_body, parsed_json$covariates),
    descriptors = descriptors_to_S4(parsed_json$descriptors),
    response_definition = response_definition,
    covariate_definitions = covariate_definitions
  )

  if(!is.null(parsed_json$citation)) {
    mod@citation <- citation_to_S4(parsed_json$citation)
  }

  mod@pub_id <- parsed_json$pub_id

  mod
}

mixef_fromJSON <- function(parsed_json) {
  # TODO add response & covariate definitions
  MixedEffectsModel(
    response = response_to_S4(parsed_json$response),
    covariates = covariates_to_S4(parsed_json$covariates),
    parameters = parameters_to_S4(parsed_json$parameters),
    predict_fn = predict_fn_to_S4(parsed_json$predict_fn_body, parsed_json$covariates),
    descriptors = descriptors_to_S4(parsed_json$descriptors),
    response_definition = parsed_json$response_definition,
    covariate_definitions = covt_defs_to_S4(parsed_json$covariate_definitions)
  )
}

fromJSON <- function(parsed_json) {
  model_class <- parsed_json$model_class


  if(model_class == "FixedEffectsModel") {
    s4 <- fixef_fromJSON(parsed_json)
  } else if(model_class == "MixedEffectsModel") {
    s4 <- mixef_fromJSON(parsed_json)
  } else {
    stop("Invalid model_class when parsing from JSON.")
  }

  s4
}