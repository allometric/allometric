setClass(
  "ParametricModel",
  contains = "AllometricModel",
  slots = c(
    model_description = "list"
  )
)



#' Base class for parametric model.
#' 
#' ```{r}
#' 1+1
#' ```
#'
#' @export
ParametricModel <- function(response_unit, covariate_units,
                            predict_fn, model_description, id = NA_integer_) {
  parametric_model <- new("ParametricModel",
    response_unit = response_unit, covariate_units = covariate_units,
    predict_fn = predict_fn, model_description = model_description, id = id
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

setMethod("predict", "ParametricModel", function(mod, ...) {
  mod@predict_fn(...)
})



