# Functions used to convert models and publications to S4 objects from JSON

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

#' Convert the descriptors JSON data to a named list of descriptors
#'
#' @keywords internal
descriptors_to_S4 <- function(descriptors_data) {
  # Which columns must be scalars (one value, not lists)
  scalar_col_names <- c("family", "genus", "species")

  for(i in seq_along(descriptors_data)) {
    name_i <- names(descriptors_data)[[i]]
    val_i <- descriptors_data[[i]]

    if(length(val_i) == 0 && name_i %in% scalar_col_names) {
      descriptors_data[[name_i]] <- NA
    } else if(length(val_i) == 0) {
      descriptors_data[[name_i]] <- NA
    } else if (name_i %in% scalar_col_names) {
      descriptors_data[[name_i]] <- val_i
    } else {
      descriptors_data[[name_i]] <- list(unlist(val_i))
    }
  }

  tibble::as_tibble_row(descriptors_data)
}

covt_defs_to_S4 <- function(covt_defs_data) {
  covt_defs <- list()

  for(i in 1:nrow(covt_defs_data)) {
    covt_defs[[covt_defs_data$name[[i]]]] <- covt_defs_data$definition
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

  FixedEffectsModel(
    response = response_to_S4(parsed_json$response),
    covariates = covariates_to_S4(parsed_json$covariates),
    parameters = parameters_to_S4(parsed_json$parameters),
    predict_fn = predict_fn_to_S4(parsed_json$predict_fn_body, parsed_json$covariates),
    descriptors = descriptors_to_S4(parsed_json$descriptors),
    response_definition = response_definition,
    covariate_definitions = covariate_definitions
  )
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

fromJSON <- function(json_data) {
  parsed_json <- jsonlite::fromJSON(json_data, simplifyVector = TRUE, simplifyMatrix = FALSE, simplifyDataFrame = FALSE)
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