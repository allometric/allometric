.MixedEffectsModel <- setClass(
  "MixedEffectsModel",
  contains = "ParametricModel",
  slots = c(
    predict_ranef = "function",
    predict_ranef_populated = "function",
    fixed_only = "logical"
  ),
  validity = check_parametric_model
)

#' Create a mixed effects model
#'
#' `MixedEffectsModel` represents an allometric model that uses fixed and
#' random effects.
#'
#' @inheritParams FixedEffectsModel
#' @param predict_ranef
#'    A function that predicts the random effects, takes any named covariates in
#'    `covariate_units` as arguments
#' @param fixed_only
#'    A boolean value indicating if the model produces predictions using only
#'    fixed effects. This is useful when publications do not provide sufficient
#'    information to predict the random effects.
#' @return An instance of MixedEffectsModel
#' @template ParametricModel_slots
#' @slot predict_ranef The function that predicts the random effects
#' @slot predict_ranef_populated The function that predicts the random effects
#' populated with the fixed effect parameter estimates
#' @slot fixed_only A boolean value indicating if the model produces predictions
#' using only fixed effects
#' @examples
#' MixedEffectsModel(
#'   response_unit = list(
#'     hst = units::as_units("m")
#'   ),
#'   covariate_units = list(
#'     dsob = units::as_units("cm")
#'   ),
#'   parameters = list(
#'     beta_0 = 40.4218,
#'     beta_1 = -0.0276,
#'     beta_2 = 0.936
#'   ),
#'   predict_ranef = function() {
#'     list(b_0_i = 0, b_2_i = 0)
#'   },
#'   predict_fn = function(dsob) {
#'     1.37 + (beta_0 + b_0_i) * (1 - exp(beta_1 * dsob)^(beta_2 + b_2_i))
#'   },
#'   fixed_only = TRUE
#' )
#' @export
MixedEffectsModel <- function(response_unit, covariate_units, predict_ranef,
                              predict_fn, parameters, fixed_only = FALSE,
                              descriptors = list(),
                              response_definition = NA_character_,
                              covariate_definitions = list()) {
  mixed_effects_model <- .MixedEffectsModel(ParametricModel(
    response_unit, covariate_units, predict_fn, parameters, descriptors,
    response_definition, covariate_definitions
  ))

  mixed_effects_model@predict_ranef <- predict_ranef
  mixed_effects_model@fixed_only <- fixed_only

  # Populate the random effect prediction function with the fixed parameters
  mixed_effects_model@predict_ranef_populated <- mixed_effects_model@predict_ranef

  func_body <- body(mixed_effects_model@predict_ranef_populated)
  body(mixed_effects_model@predict_ranef_populated) <- do.call(
    "substitute", list(func_body, mixed_effects_model@specification)
  )

  mixed_effects_model
}

#' @param newdata
#'    A dataframe containing columns that match the names of the arguments given
#'    to `predict_ranef`. The values of this data represents information from a
#'    new group of observations for which predictions are desired (e.g., a new
#'    stand or plot).
#' @rdname predict
setMethod("predict", signature(model = "MixedEffectsModel"), function(model, ..., newdata = NULL, output_units = NULL) {
  # TODO validity checks for predict_ranef, we should throw a warning if
  # the column names of newdata are not the same set of args in predict_ranef
  # probabyl some opportunity for DRY with other validity checks..
  ranef_args <- names(as.list(args(model@predict_ranef)))
  ranef_args <- ranef_args[-length(ranef_args)]

  complete_fn <- model@predict_fn

  if (!is.null(newdata)) {
    ranefs <- do.call(model@predict_ranef_populated, newdata)
  } else {
    ranefs <- model@predict_ranef_populated()
  }
  predict_populated <- body(model@predict_fn_populated)
  body(complete_fn) <- do.call("substitute", list(predict_populated, ranefs))

  converted <- convert_units(..., units_list = model@covariate_units)
  stripped <- strip_units(converted)

  out <- do.call(complete_fn, stripped)

  if("units" %in% class(out)) {
    out_stripped <- units::drop_units(out)
  } else {
    out_stripped <- out
  }

  deparsed <- units::deparse_unit(model@response_unit[[1]])
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

setMethod("init_set_of_one", signature(model = "MixedEffectsModel"), function(model) {
  MixedEffectsSet(
    response_unit = model@response_unit,
    covariate_units = model@covariate_units,
    predict_fn = model@predict_fn,
    parameter_names = names(model@parameters),
    model_specifications = model@specification,
    predict_ranef = model@predict_ranef,
    fixed_only = model@fixed_only,
    response_definition = model@response_definition,
    covariate_definitions = model@covariate_definitions
  )
})

#' @inherit model_call
#' @keywords internal
setMethod("model_call", signature(object = "MixedEffectsModel"), function(object) {
  response_var <- names(object@response_unit)[[1]]

  arg_names <- names(as.list(args(object@predict_fn)))
  arg_names <- arg_names[-length(arg_names)]
  arg_names <- c(arg_names, "newdata")
  arg_names_str <- paste(arg_names, collapse = ", ")

  paste(response_var, " = ", "f(", arg_names_str, ")", sep = "")
})

setMethod("show", "MixedEffectsModel", function(object) {
  variable_descriptions <- get_variable_descriptions(object)
  variable_descriptions <- paste(variable_descriptions, collapse = "\n")

  mod_call <- model_call(object)
  cat("Model Call:", "\n")
  cat(mod_call, "\n", "\n")
  cat(variable_descriptions, "\n", "\n")
 
  cat("Random Effects Variables:", "\n")
  ranef_vars <- names(as.list(args(object@predict_ranef)))
  ranef_vars <- ranef_vars[-length(ranef_vars)]
  ranef_vars_fmt <- paste(ranef_vars, collapse = ", ")
  cat(ranef_vars_fmt, "\n")

  cat("\n")
  cat("Parameter Estimates:", "\n")
  print(parameters(object))

  cat("\n")
  cat("Model Descriptors:", "\n")
  print(descriptors(object))
})


#' Check equivalence of mixed effects models
#'
#' Fixed effects models are considered equal if all of the following are true:
#' \itemize{
#'  \item{The model IDs are equal (or not present)}
#'  \item{The response unit names and units are the same}
#'  \item{The covariate names and units are the same and are in the same order}
#'  \item{The specification names and values are the same}
#'  \item{The predict_fn are the same}
#'  \item{The predict_ranef are the same}
#'  \item{The fixed_only slots are the same}
#'  \item{The response definitions are the same}
#'  \item{The covariate definitions are the same}
#' }
#'
#' @param e1 A `MixedEffectsModel` object
#' @param e2 A `MixedEffectsModel` object
setMethod("==", signature(e1 = "MixedEffectsModel", e2 = "MixedEffectsModel"),
  function(e1, e2) {
  ids_equal <- check_ids_equal(e1, e2)
  response_equal <- check_response_equal(e1, e2)
  covariates_equal <- check_covariates_equal(e1, e2)
  specifications_equal <- check_list_equal(specification(e1), specification(e2))
  predict_fn_equal <- check_predict_fn_equal(e1@predict_fn, e2@predict_fn)
  predict_ranef_equal <- check_predict_fn_equal(e1@predict_ranef, e2@predict_ranef)
  fixed_only_equal <- e1@fixed_only == e2@fixed_only
  res_def_equal <- check_res_def_equal(e1, e2)
  covt_defs_equal <- check_list_equal(e1@covariate_definitions, e2@covariate_definitions)

  all(
    ids_equal,
    response_equal,
    covariates_equal,
    specifications_equal,
    predict_fn_equal,
    predict_ranef_equal,
    fixed_only_equal,
    res_def_equal,
    covt_defs_equal
  )
})