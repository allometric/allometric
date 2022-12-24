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

  parametric_model
}

# TODO set validity...must have a finite set of parameters >= length of
# covariates

setGeneric("predict", function(mod, covariates) standardGeneric("predict"))

setMethod("predict", "ParametricModel", function(mod, covariates) {
  mod@predict_fn(mod@parameters, covariates)
})
