check_args_in_function <- function(object) {
  errors <- c()

  fn_body <- body(object@predict_fn)
  fn_args <- names(as.list(args(object@predict_fn)))

  fn_args <- fn_args[-length(fn_args)]

  body_vars <- all.vars(fn_body)

  if(!all(fn_args %in% body_vars)) {
    msg <- paste("Not all predict_fn args",
      paste(fn_args, collapse = ', '),
      "are in the function body."
    )
    errors <- c(msg, errors)
  }

  errors
}


check_body_vars_subset_description <- function(object) {
  errors <- c()
  fn_body <- body(object@predict_fn)
  fn_args <- names(as.list(args(object@predict_fn)))

  body_vars <- all.vars(fn_body)
  body_vars_less_args <- body_vars[!body_vars %in% fn_args]

  model_description_names <- names(object@model_description)


  if(!all(body_vars_less_args %in% model_description_names)) {
    msg <- paste("Function body parameters:", paste(body_vars_less_args, collapse = ', '),
      "is not a subset of the model description:", paste(model_description_names, collapse = ', '))
    errors <- c(errors, msg)
  }
  errors
}



#' Check validity of parametric model
check_parametric_model <- function(object) {
  errors <- c()
  errors <- c(errors, check_args_in_function(object))
  errors <- c(errors, check_body_vars_subset_description(object))

  errors

}

setClass(
  "ParametricModel",
  contains = "AllometricModel",
  validity = check_parametric_model
)

#'
#' @export
ParametricModel <- function(response_unit, covariate_units,
                            predict_fn, model_description,
                            set_descriptors = list(),
                            pub_descriptors = list(),
                            id = NA_integer_) {
  parametric_model <- new("ParametricModel",
    response_unit = response_unit, covariate_units = covariate_units,
    predict_fn = predict_fn, model_description = model_description,
    set_descriptors = set_descriptors, pub_descriptors = pub_descriptors,
    id = id
  )

  # Populate the predict_fn with the coefficients
  func_body <- body(parametric_model@predict_fn)
  body(parametric_model@predict_fn) <- do.call(
    'substitute', list(func_body, parametric_model@model_description)
  )

  parametric_model
}

# TODO set validity...must have a finite set of parameters >= length of
# covariates

setGeneric("predict", function(mod, ...) standardGeneric("predict"))

setMethod("predict", signature(mod = "ParametricModel"), function(mod, ...) {
  mod@predict_fn(...)
})