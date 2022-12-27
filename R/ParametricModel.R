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

  model_specification_names <- names(object@model_specification)


  if(!all(body_vars_less_args %in% model_specification_names)) {
    msg <- paste("Function body parameters:", paste(body_vars_less_args, collapse = ', '),
      "is not a subset of the model description:", paste(model_specification_names, collapse = ', '))
    errors <- c(errors, msg)
  }
  errors
}



#' Check validity of parametric model
check_parametric_model <- function(object) {
  errors <- c()
  errors <- c(errors, check_args_in_function(object))
  #errors <- c(errors, check_body_vars_subset_description(object))

  errors

}

setClass(
  "ParametricModel",
  contains = "AllometricModel",
  slots = c(
    predict_fn_populated = "function",
    parameters = "list"
  ),
  validity = check_parametric_model
)

#'
#' @export
ParametricModel <- function(response_unit, covariate_units,
                            predict_fn, parameters,
                            set_descriptors = list(),
                            pub_descriptors = list(),
                            descriptors = list()) {
  parametric_model <- new("ParametricModel",
    response_unit = response_unit, covariate_units = covariate_units,
    predict_fn = predict_fn, parameters = parameters,
    set_descriptors = set_descriptors, pub_descriptors = pub_descriptors,
    descriptors = descriptors
  )

  parametric_model@model_specification <- c(
    pub_descriptors,
    set_descriptors,
    descriptors,
    parameters
  )

  # Populate a copy of the predict_fn with the coefficients
  parametric_model@predict_fn_populated <- parametric_model@predict_fn

  func_body <- body(parametric_model@predict_fn_populated)
  body(parametric_model@predict_fn_populated) <- do.call(
    'substitute', list(func_body, parametric_model@model_specification)
  )

  parametric_model
}

# TODO set validity...must have a finite set of parameters >= length of
# covariates

#' @export
setGeneric("predict", function(mod, ...) standardGeneric("predict"))

setMethod("predict", signature(mod = "ParametricModel"), function(mod, ...) {
  mod@predict_fn_populated(...)
})

setMethod("show", "ParametricModel", function(mod) {
  form <- get_model_str(mod)
  # TODO format the descriptions. They should be indented by 2 spaces and the
  # unit left backets should align by inserting spaces. Seems like do the
  # latter then the former.
  variable_descriptions <- get_variable_descriptions(mod)

  cat('Model Form:', '\n')
  cat(form, '\n', '\n')
  cat(variable_descriptions, sep="\n")

  cat('\n')
  cat('Parameter Estimates:', '\n')
  print(data.frame(mod@parameters))

  cat('\n')
  cat('Model Specification:', '\n')
  print(data.frame(mod@model_specification))
})

setGeneric("get_model_str", function(mod) standardGeneric("get_model_str"))

setMethod("get_model_str", "ParametricModel", function(mod) {
  .get_model_str(mod)
})

setGeneric("get_variable_descriptions", function(mod) standardGeneric("get_variable_descriptions"))

setMethod("get_variable_descriptions", "ParametricModel", function(mod) {
  .get_variable_descriptions(mod)
})