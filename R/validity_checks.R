#' Are all named parameters in the function body?
check_parameters_in_predict_fn <- function(object) {
  predict_body <- body(object@predict_fn)
  predict_fn_vars <- all.vars(predict_body)

  if(!all(object@parameter_names %in% predict_fn_vars)) {
    return("Named parameters are not found in the predict_fn body.")
  }
}

check_parameters_in_mixed_fns <- function(object) {
  predict_fn_body <- body(object@predict_fn)
  predict_ranef_body <- body(object@predict_ranef)

  predict_fn_vars <- all.vars(predict_fn_body)
  predict_ranef_vars <- all.vars(predict_ranef_body)

  all_vars <- c(predict_fn_vars, predict_ranef_vars)

  if(!all(object@parameter_names %in% all_vars)) {
    return("Named parameters are not found in the predict_fn and predict_ranef bodies.")
  }
}

#' Are all covariates given as arguments?
check_covts_in_args <- function(object) {
  errors <- c()
  fn_args <- names(as.list(args(object@predict_fn)))
  fn_args <- fn_args[-length(fn_args)]

  covt_names <- names(object@covariate_units)
  if(!(all(covt_names %in% fn_args) & all(fn_args %in% covt_names))) {
    msg <- paste('The predict_fn arguments and the names in covariate_units mismatch.')
    errors <- c(errors, msg)
  }

  errors
}


#' Are the arguments given in the predict function inside the body?
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

check_region_in_iso <- function(region_code) {
  errors <- c()
  for(code in region_code) {
    if(!code %in% ISOcodes::ISO_3166_2$Code) {
      msg <- paste("Region code", code, "not found in ISO_3166-2")
      errors <- c(msg, errors)
    }
  }

  errors
}

check_country_in_iso <- function(country_code) {
  errors <- c()

  for(code in country_code) {
    if(!code %in% ISOcodes::ISO_3166_1$Alpha_2) {
      msg <- paste("Country code", code, "not found in ISO_3166-1 alpha 2")
      errors <- c(msg, errors)
    }
  }

  errors
}

check_descriptor_validity <- function(descriptors) {
  errors <- c()

  if("country" %in% names(descriptors)) {
    errors <- c(errors, check_country_in_iso(descriptors$country))
  }
  
  if("region" %in% names(descriptors)) {
    errors <- c(errors, check_region_in_iso(descriptors$region))
  }

  errors
}