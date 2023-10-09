.FixedEffectsModel <- setClass(
  "FixedEffectsModel",
  contains = "ParametricModel",
  validity = check_parametric_model
)

#' Create a fixed effects model
#'
#' `FixedEffectsModel` represents an allometric model that only uses fixed
#' effects.
#'
#' @param parameters A named list of parameters and their values
#' @return An object of class `FixedEffectsModel`
#' @inheritParams ParametricModel
#' @template AllometricModel_slots
#' @template ParametricModel_slots
#' @examples
#' FixedEffectsModel(
#'   response = list(
#'     hst = units::as_units("m")
#'   ),
#'   covariates = list(
#'     dsob = units::as_units("cm")
#'   ),
#'   parameters = list(
#'     beta_0 = 51.9954,
#'     beta_1 = -0.0208,
#'     beta_2 = 1.0182
#'   ),
#'   predict_fn = function(dsob) {
#'     1.37 + beta_0 * (1 - exp(beta_1 * dsob)^beta_2)
#'   }
#' )
#' @export
FixedEffectsModel <- function(response, covariates, predict_fn,
                              parameters, descriptors = list(),
                              response_definition = NA_character_,
                              covariate_definitions = list()) {
  fixed_effects_model <- .FixedEffectsModel(ParametricModel(
    response, covariates, predict_fn, parameters, descriptors,
    response_definition, covariate_definitions
  ))

  fixed_effects_model
}

#' @rdname predict
setMethod("predict", signature(model = "FixedEffectsModel"), function(model, ..., output_units = NULL) {
  converted <- convert_units(..., units_list = model@covariates)
  stripped <- strip_units(converted)

  out <- do.call(model@predict_fn_populated, stripped)

  if("units" %in% class(out)) {
    out_stripped <- units::drop_units(out)
  } else {
    out_stripped <- out
  }

  deparsed <- units::deparse_unit(model@response[[1]])
  out_stripped <- do.call(units::set_units, list(out_stripped, deparsed))

  if(!is.null(output_units)) {
    converted <- convert_units(
      out_stripped,
      units_list = list(units::as_units(output_units))
    )

    out_stripped <- converted[[1]]
  }

  out_stripped
})

setMethod("init_set_of_one", signature(model = "FixedEffectsModel"), function(model) {
  FixedEffectsSet(
    response = model@response,
    covariates = model@covariates,
    parameter_names = names(model@parameters),
    predict_fn = model@predict_fn,
    model_specifications = model@specification,
    response_definition = model@response_definition,
    covariate_definitions = model@covariate_definitions
  )
})


#' @inherit model_call
#' @keywords internal
setMethod("model_call", signature(object = "FixedEffectsModel"), function(object) {
  response_var <- names(object@response)[[1]]

  arg_names <- names(as.list(args(object@predict_fn)))
  arg_names <- arg_names[-length(arg_names)]
  arg_names_str <- paste(arg_names, collapse = ", ")

  paste(response_var, " = ", "f(", arg_names_str, ")", sep = "")
})

setMethod("show", "FixedEffectsModel", function(object) {
  # TODO format the descriptions. They should be indented by 2 spaces and the
  # unit left backets should align by inserting spaces. Seems like do the
  # latter then the former.
  variable_descriptions <- get_variable_descriptions(object)
  variable_descriptions <- paste(variable_descriptions, collapse = "\n")

  mod_call <- model_call(object)
  cat("Model Call:", "\n")
  cat(mod_call, "\n", "\n")

  cat(variable_descriptions, "\n")

  cat("\n")
  cat("Parameter Estimates:", "\n")
  print(parameters(object))

  cat("\n")
  cat("Model Descriptors:", "\n")
  print(descriptors(object))
})

#' Check equivalence of fixed effects models
#'
#' Fixed effects models are considered equal if all of the following are true:
#' \itemize{
#'  \item{The model IDs are equal (or not present)}
#'  \item{The response unit names and units are the same}
#'  \item{The covariate names and units are the same and are in the same order}
#'  \item{The specification names and values are the same}
#'  \item{The predict_fn is the same}
#'  \item{The response definitions are the same}
#'  \item{The covariate definitions are the same}
#' }
#'
#' @param e1 A `FixedEffectsModel` object
#' @param e2 A `FixedEffectsModel` object
setMethod("==", signature(e1 = "FixedEffectsModel", e2 = "FixedEffectsModel"),
  function(e1, e2) {
  ids_equal <- check_ids_equal(e1, e2)
  response_equal <- check_response_equal(e1, e2)
  covariates_equal <- check_covariates_equal(e1, e2)
  specifications_equal <- check_list_equal(specification(e1), specification(e2))
  predict_fn_equal <- check_predict_fn_equal(e1@predict_fn, e2@predict_fn)
  res_def_equal <- check_res_def_equal(e1, e2)
  covt_defs_equal <- check_list_equal(e1@covariate_definitions, e2@covariate_definitions)

  all(
    ids_equal,
    response_equal,
    covariates_equal,
    specifications_equal,
    predict_fn_equal,
    res_def_equal,
    covt_defs_equal
  )
})

#' Convert a fixed effects model to a JSON representation
#'
#' This function converts a fixed effects model into a JSON representation.
#' Primarily, this is used internally to populate a remotely hosted
#' MongoDatabase.
#'
#' @param object A fixed effects model
#' @param ... Additional arguments passed to jsonlite::toJSON
#' @return A string containing the JSON representation of the object
#' @export
#' @examples
#' toJSON(brackett_rubra, pretty = TRUE)
setMethod("toJSON", "FixedEffectsModel", function(object, ...) {
  json_list <- model_to_json(object)
  jsonlite::toJSON(json_list, digits = NA, ...)
})