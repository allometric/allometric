library(units)
library(tibble)
library(bibtex)

setOldClass('units')
setOldClass('bibentry')

setClass('AllometricModel',
    slots = c(
        response_unit = 'list',
        covariate_units = 'list',
        predict_fn = 'function',
        citation = 'bibentry',
        country = 'character',
        region = 'character',
        fit_species = 'character'
    )
)

AllometricModel <- function(response_unit, covariate_units, predict_fn,
    citation, country = NA_character_, region = NA_character_,
    fit_species = NA_character_) {
    allometric_model <- new('AllometricModel')
    allometric_model@response_unit <- response_unit
    allometric_model@covariate_units <- covariate_units
    allometric_model@predict_fn <- predict_fn
    allometric_model@citation <- citation
    allometric_model@country <- country
    allometric_model@region <- region
    allometric_model@fit_species <- fit_species
    allometric_model
}

setGeneric('predict_fn', function(x) standardGeneric('predict_fn'))
setMethod('predict_fn', 'AllometricModel', function(x) x@predict_fn)