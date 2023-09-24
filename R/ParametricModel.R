#' Check validity of parametric model
#'
#' @keywords internal
check_parametric_model <- function(object) {
  errors <- c()
  errors <- c(errors, check_args_in_predict_fn(object))

  errors
}


.ParametricModel <- setClass(
  "ParametricModel",
  contains = "AllometricModel",
  slots = c(
    predict_fn_populated = "function",
    parameters = "tbl_df",
    specification = "tbl_df"
  ),
  validity = check_parametric_model
)


setMethod("specification", "ParametricModel", function(object) object@specification)
setMethod("specification<-", "ParametricModel", function(model, value) {
  model@specification <- value
  model
})

setMethod("descriptors", "ParametricModel", function(object) {
  object@specification[!names(object@specification) %in% names(object@parameters)]
})


setMethod("descriptors<-", "ParametricModel", function(object, value) {
  object@specification[!names(object@specification) %in% names(object@parameters)] <- value
  object
})


setMethod("parameters", "ParametricModel", function(object) {
  object@parameters
})

#' Base class for all parametric models.
#'
#' This is a base class used for `FixedEffectsModel` and `MixedEffectsModel`
#'
#' @inheritParams AllometricModel
#' @return An object of class ParametricModel
#' @export
#' @keywords internal
ParametricModel <- function(response_unit, covariate_units, predict_fn,
                            parameters, descriptors = list(),
                            response_definition = NA_character_,
                            covariate_definitions = list()) {
  # Coerce to tbl_df
  parameters <- tibble::as_tibble( as.list(parameters) )
  descriptors <- tibble::as_tibble( as.list(descriptors) )

  parametric_model <- .ParametricModel(
    AllometricModel(
      response_unit, covariate_units, predict_fn, descriptors,
      response_definition, covariate_definitions
    ),
    parameters = parameters,
    specification = tibble::tibble()
  )

  descriptor_set <- c(
    parametric_model@pub_descriptors,
    parametric_model@set_descriptors,
    parametric_model@descriptors
  )


  check_descriptor_set(descriptor_set)

  specification(parametric_model) <- tibble::as_tibble(
    c(
      descriptor_set,
      parametric_model@parameters
    )
  )

  # Populate a copy of the predict_fn with the coefficients
  parametric_model@predict_fn_populated <- parametric_model@predict_fn

  func_body <- body(parametric_model@predict_fn_populated)
  body(parametric_model@predict_fn_populated) <- do.call(
    "substitute", list(func_body, parametric_model@specification)
  )

  parametric_model
}

#' @inherit model_call
#' @keywords internal
setMethod("model_call", signature(object = "ParametricModel"), function(object) {
  response_var <- names(object@response_unit)[[1]]

  arg_names <- names(as.list(args(object@predict_fn)))
  arg_names <- arg_names[-length(arg_names)]
  arg_names_str <- paste(arg_names, collapse = ", ")

  paste(response_var, " = ", "f(", arg_names_str, ")", sep = "")
})



setMethod("get_model_str", "ParametricModel", function(object) {
  .get_model_str(object)
})

setMethod("get_variable_descriptions", "ParametricModel", function(object) {
  .get_variable_descriptions_fmt(object)
})
