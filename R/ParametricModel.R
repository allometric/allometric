setClass(
    'ParametricModel',
    contains = 'AllometricModel',
    slots = c(
        parameters = 'numeric'
    )
)



ParametricModel <- function(response_unit, covariate_units, parameters,
    predict_fn, citation, country = NA_character_, region = NA_character_,
    fit_species = NA_character_) {

    parametric_model <- new('ParametricModel',
        response_unit = response_unit, covariate_units = covariate_units,
        predict_fn = predict_fn, citation = citation, country = country,
        region = region, fit_species = fit_species)

    parametric_model@parameters <- parameters

    parametric_model
}

setGeneric('predict', function(mod, covariates) standardGeneric('predict'))

setMethod('predict', 'ParametricModel', function(mod, covariates) {
    mod@predict_fn(mod@parameters, covariates)
})