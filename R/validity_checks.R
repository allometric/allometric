#' Check if all parameter_names are in predict_fn
#'
#' @keywords internal
check_parameters_in_predict_fn <- function(object) {
  predict_body <- body(object@predict_fn)
  predict_fn_vars <- all.vars(predict_body)

  if (!all(object@parameter_names %in% predict_fn_vars)) {
    return("Named parameters are not found in the predict_fn body.")
  }
}

#' Check if all parameter_names are in predict_fn and predict_ranef
#'
#' @keywords internal
check_parameters_in_mixed_fns <- function(object) {
  predict_fn_body <- body(object@predict_fn)
  predict_ranef_body <- body(object@predict_ranef)

  predict_fn_vars <- all.vars(predict_fn_body)
  predict_ranef_vars <- all.vars(predict_ranef_body)

  all_vars <- c(predict_fn_vars, predict_ranef_vars)

  if (!all(object@parameter_names %in% all_vars)) {
    return("Named parameters are not found in the predict_fn and predict_ranef bodies.")
  }
}

#' Check if all covariates in covariates are used as arguments in
#' predict_fn
#'
#' @keywords internal
check_covts_in_args <- function(object) {
  errors <- c()
  fn_args <- names(as.list(args(object@predict_fn)))
  fn_args <- fn_args[-length(fn_args)]

  covt_names <- names(object@covariates)
  if (!(all(covt_names %in% fn_args) & all(fn_args %in% covt_names))) {
    msg <- paste("The predict_fn arguments and the names in covariates mismatch.")
    errors <- c(errors, msg)
  }

  errors
}

#' Check if the arguments of the predict_fn are all in the predict_fn body.
#'
#' @keywords internal
check_args_in_predict_fn <- function(object) {
  errors <- c()

  fn_body <- body(object@predict_fn)
  fn_args <- names(as.list(args(object@predict_fn)))

  fn_args <- fn_args[-length(fn_args)]

  body_vars <- all.vars(fn_body)

  if (!all(fn_args %in% body_vars)) {
    msg <- paste(
      "Not all predict_fn args",
      paste(fn_args, collapse = ", "),
      "are in the function body."
    )
    errors <- c(msg, errors)
  }

  errors
}

#' Checks if a region code is defined in the ISO_3166_2 table
#'
#' @keywords internal
check_region_in_iso <- function(region_codes) {
  errors <- c()
  for (code in region_codes) {
    if (!all(code %in% ISOcodes::ISO_3166_2$Code)) {
      msg <- paste("Region code", code, "not found in ISO_3166-2")
      errors <- c(msg, errors)
    }
  }

  errors
}

#' Checks if a country code is defined in ISO_3166_1$Alpha_2
#'
#' @keywords internal
check_country_in_iso <- function(country_codes) {
  errors <- c()

  for (code in country_codes) {
    if (!all(code %in% ISOcodes::ISO_3166_1$Alpha_2)) {
      msg <- paste("Country code", code, "not found in ISO_3166-1 alpha 2")
      errors <- c(msg, errors)
    }
  }

  errors
}

check_tbl_rows <- function(descriptors) {
  errors <- c()

  if (nrow(descriptors) > 1) {
    msg <- "Descriptors must be coercible to a one-row tbl_df."
    errors <- c(errors, msg)
  }

  errors
}

#' Checks that descriptors are valid
#'
#' @keywords internal
check_descriptor_validity <- function(descriptors) {
  errors <- c()

  errors <- c(errors, check_tbl_rows(descriptors))

  if ("country" %in% names(descriptors)) {
    # [[1]] refers to the list that is country
    errors <- c(errors, check_country_in_iso(descriptors$country[[1]]))
  }

  if ("region" %in% names(descriptors)) {
    # [[1]] refers to the list that is region
    errors <- c(errors, check_region_in_iso(descriptors$region[[1]]))
  }

  if (any(names(descriptors) %in% c("family", "genus", "species"))) {
    errors <- c(errors, "Descriptor fields cannot contain family, genus, or species. Use the taxa field instead.")
  }

  errors
}

check_model_specifications_unique <- function(model_specifications, parameter_names) {
  errors <- c()
  n <- nrow(model_specifications)

  specs_distinct <- model_specifications %>%
    dplyr::select(-dplyr::all_of(parameter_names)) %>%
    dplyr::distinct()

  if(nrow(specs_distinct) != n) {
    errors <- c(errors, "Descriptors in the model specification must uniquely identify all models.")
  }

  errors
}

#' Checks if a citation contains a key
#'
#' @keywords internal
check_citation_key <- function(citation) {
  errors <- c()

  if(is.null(citation$key)) {
    errors <- c(errors, "No key defined for this publication.")
  }

  errors
}

#' Determines if a taxon has a valid hierarchy
#'
#' @keywords internal
check_taxon_hierarchy <- function(object) {
  # Define the complete hierarchy as a list of vectors
  errors <- c()

  hierarchy <- list(
    family = c("family"),
    genus = c("family", "genus"),
    species = c("family", "genus", "species")
  )

  vals <- c(object@family, object@genus, object@species)
  defined_fields <- c("family", "genus", "species")[!is.na(vals)]

  if (all(is.na(defined_fields))) {
    errors <- c(errors, "Taxon must at least have a family specified")
  }

  for (level in names(hierarchy)) {
    if (level %in% defined_fields) {
      if (!all(hierarchy[[level]] %in% defined_fields)) {
        errors <- c(errors, "Invalid taxonomic hierarchy")
      }
    }
  }

  errors
}