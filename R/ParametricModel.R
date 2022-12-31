

check_body_vars_subset_description <- function(object) {
  errors <- c()
  fn_body <- body(object@predict_fn)
  fn_args <- names(as.list(args(object@predict_fn)))

  body_vars <- all.vars(fn_body)
  body_vars_less_args <- body_vars[!body_vars %in% fn_args]

  model_specification_names <- names(object@specification)


  if (!all(body_vars_less_args %in% model_specification_names)) {
    msg <- paste(
      "Function body parameters:", paste(body_vars_less_args, collapse = ", "),
      "is not a subset of the model description:", paste(model_specification_names, collapse = ", ")
    )
    errors <- c(errors, msg)
  }
  errors
}



#' Check validity of parametric model
check_parametric_model <- function(object) {
  errors <- c()
  errors <- c(errors, check_args_in_predict_fn(object))
  # errors <- c(errors, check_body_vars_subset_description(object))

  errors
}


.ParametricModel <- setClass(
  "ParametricModel",
  contains = "AllometricModel",
  slots = c(
    predict_fn_populated = "function",
    parameters = "list",
    specification = "list"
  ),
  validity = check_parametric_model
)

setGeneric("specification", function(mod) standardGeneric("specification"))
setGeneric("specification<-", function(mod, value) standardGeneric("specification<-"))

setMethod("specification", "ParametricModel", function(mod) mod@specification)
setMethod("specification<-", "ParametricModel", function(mod, value) {
  mod@specification <- value
  mod
})

setGeneric("descriptors", function(mod) standardGeneric("descriptors"))

setMethod("descriptors", "ParametricModel", function(mod) {
  mod@specification[!names(mod@specification) %in% names(mod@parameters)]
})

setGeneric("parameters", function(mod) standardGeneric("parameters"))

setMethod("parameters", "ParametricModel", function(mod) {
  mod@parameters
})

#' Base class for all parametric models.
#'
#' This is a base class used for `FixedEffectsModel` and `MixedEffectsModel`
#'
#' @export
ParametricModel <- function(response_unit, covariate_units, predict_fn,
                            parameters, descriptors = list()) {
  parametric_model <- .ParametricModel(
    AllometricModel(
      response_unit, covariate_units, predict_fn, descriptors
    ),
    parameters = parameters
  )

  parametric_model@pub_descriptors <- list()
  parametric_model@set_descriptors <- list()

  descriptor_set <- c(
    parametric_model@pub_descriptors,
    parametric_model@set_descriptors,
    parametric_model@descriptors
  )

  check_descriptor_set(descriptor_set)

  specification(parametric_model) <- c(
    descriptor_set,
    parametric_model@parameters
  )

  # Populate a copy of the predict_fn with the coefficients
  parametric_model@predict_fn_populated <- parametric_model@predict_fn

  func_body <- body(parametric_model@predict_fn_populated)
  body(parametric_model@predict_fn_populated) <- do.call(
    "substitute", list(func_body, parametric_model@specification)
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

setMethod("show", "ParametricModel", function(object) {
  form <- get_model_str(object)
  # TODO format the descriptions. They should be indented by 2 spaces and the
  # unit left backets should align by inserting spaces. Seems like do the
  # latter then the former.
  variable_descriptions <- get_variable_descriptions(object)

  cat("Model Form:", "\n")
  cat(form, "\n", "\n")
  cat(variable_descriptions, sep = "\n")

  cat("\n")
  cat("Parameter Estimates:", "\n")
  print(data.frame(parameters(object)))

  cat("\n")
  cat("Model Descriptors:", "\n")
  print(data.frame(descriptors(object)))
})

setGeneric("get_model_str", function(mod) standardGeneric("get_model_str"))

setMethod("get_model_str", "ParametricModel", function(mod) {
  .get_model_str(mod)
})

setGeneric("get_variable_descriptions", function(mod) standardGeneric("get_variable_descriptions"))

setMethod("get_variable_descriptions", "ParametricModel", function(mod) {
  .get_variable_descriptions(mod)
})



