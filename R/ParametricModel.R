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


setMethod("specification", "ParametricModel", function(mod) mod@specification)
setMethod("specification<-", "ParametricModel", function(mod, value) {
  mod@specification <- value
  mod
})

setMethod("descriptors", "ParametricModel", function(mod) {
  mod@specification[!names(mod@specification) %in% names(mod@parameters)]
})


setMethod("descriptors<-", "ParametricModel", function(mod, value) {
  mod@specification[!names(mod@specification) %in% names(mod@parameters)] <- value
  mod
})


setMethod("parameters", "ParametricModel", function(mod) {
  mod@parameters
})

#' Base class for all parametric models.
#'
#' This is a base class used for `FixedEffectsModel` and `MixedEffectsModel`
#'
#' @export
#' @keywords internal
ParametricModel <- function(response_unit, covariate_units, predict_fn,
                            parameters, descriptors = list(),
                            covariate_definitions = list()) {
  # Coerce to tbl_df
  parameters <- tibble::as_tibble( as.list(parameters) )
  descriptors <- tibble::as_tibble( as.list(descriptors) )

  parametric_model <- .ParametricModel(
    AllometricModel(
      response_unit, covariate_units, predict_fn, descriptors,
      covariate_definitions
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

setMethod("model_call", signature(model = "ParametricModel"), function(model) {
  response_var <- names(model@response_unit)[[1]]

  arg_names <- names(as.list(args(model@predict_fn)))
  arg_names <- arg_names[-length(arg_names)]
  arg_names_str <- paste(arg_names, collapse = ", ")

  paste(response_var, " = ", "f(", arg_names_str, ")", sep = "")
})


setMethod("show", "ParametricModel", function(object) {
  form <- get_model_str(object)
  # TODO format the descriptions. They should be indented by 2 spaces and the
  # unit left backets should align by inserting spaces. Seems like do the
  # latter then the former.
  variable_descriptions <- get_variable_descriptions(object)

  mod_call <- model_call(object)
  cat("Model Call:", "\n")
  cat(mod_call, "\n")

  cat("\n")
  cat("Parameter Estimates:", "\n")
  print(parameters(object))

  cat("\n")
  cat("Model Descriptors:", "\n")
  print(descriptors(object))
})


setMethod("get_model_str", "ParametricModel", function(mod) {
  .get_model_str(mod)
})


setMethod("get_variable_descriptions", "ParametricModel", function(mod) {
  .get_variable_descriptions_fmt(mod)
})
