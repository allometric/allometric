setClass(
    'ParametricModel',
    contains = 'AllometricModel',
    slots = c(
        parameters = 'numeric'
    )
)

#' Base class for all parametric allometric models.
#'
#' `ParametricModel` represents a generic parametric allometric model, it
#' inherits from the base class `AllometricModel`. Parametric models are defined
#' by providing a named list containing the response unit, a named list
#' containing the covariate units, and a named list of parameters.
ParametricModel <- function(response_unit, covariate_units, parameters,
    predict_fn) {

    parametric_model <- new('ParametricModel',
        response_unit = response_unit, covariate_units = covariate_units,
        predict_fn = predict_fn)

    parametric_model
}

setGeneric('predict', function(mod, covariates) standardGeneric('predict'))

setMethod('predict', 'ParametricModel', function(mod, covariates) {
    mod@predict_fn(mod@parameters, covariates)
})