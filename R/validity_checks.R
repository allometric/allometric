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

#' Check if all covariates in covariate_units are used as arguments in
#' predict_fn
#'
#' @keywords internal
check_covts_in_args <- function(object) {
  errors <- c()
  fn_args <- names(as.list(args(object@predict_fn)))
  fn_args <- fn_args[-length(fn_args)]

  covt_names <- names(object@covariate_units)
  if (!(all(covt_names %in% fn_args) & all(fn_args %in% covt_names))) {
    msg <- paste("The predict_fn arguments and the names in covariate_units mismatch.")
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
check_region_in_iso <- function(region_code) {
  errors <- c()
  for (code in region_code) {
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
check_country_in_iso <- function(country_code) {
  errors <- c()

  for (code in country_code) {
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

check_tbl_atomic <- function(descriptors) {
  errors <- c()

  if (nrow(descriptors) > 0) {
    for (name in names(descriptors)) {
      if (!is.atomic(descriptors[[name]][[1]])) {
        msg <- paste("Non-atomic descriptor:", name)
        errors <- c(errors, msg)
      }
    }
  }

  errors
}

#' Checks that descriptors are valid
#'
#' @keywords internal
check_descriptor_validity <- function(descriptors) {
  errors <- c()

  errors <- c(errors, check_tbl_rows(descriptors))
  errors <- c(errors, check_tbl_atomic(descriptors))

  if ("country" %in% names(descriptors)) {
    errors <- c(errors, check_country_in_iso(descriptors$country))
  }

  if ("region" %in% names(descriptors)) {
    errors <- c(errors, check_region_in_iso(descriptors$region))
  }

  errors
}

#' 
check_model_specifications_unique <- function(model_specifications, parameter_names) {
  errors <- c()
  n <- nrow(model_specifications)

  specs_distinct <- model_specifications %>%
    dplyr::select(-parameter_names) %>%
    dplyr::distinct()

  if(nrow(specs_distinct) != n) {
    errors <- c(errors, "Descriptors in the model specification must uniquely identify all models.")
  }

  errors
}
