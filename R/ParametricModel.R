setClass(
    'ParametricModel',
    contains = 'AllometricModel',
    slots = c(
        parameters = 'list'
    )
)

#' Base class for parametric model.
#' 
#' @export
ParametricModel <- function(response_unit, covariate_units,
    predict_fn, parameters, descriptors) {

    parametric_model <- new('ParametricModel',
        response_unit = response_unit, covariate_units = covariate_units,
        predict_fn = predict_fn, descriptors = descriptors)

    parametric_model@parameters <- parameters

    parametric_model
}

# TODO set validity...must have a finite set of parameters >= length of 
# covariates

setGeneric('predict', function(mod, covariates) standardGeneric('predict'))

setMethod('predict', 'ParametricModel', function(mod, covariates) {
    mod@predict_fn(mod@parameters, covariates)
})