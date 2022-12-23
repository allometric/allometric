library(units)
library(tibble)
library(bibtex)

setOldClass('units')
setOldClass('BibEntry')

setClass('AllometricModel',
    slots = c(
        response_unit = 'list',
        covariate_units = 'list',
        descriptors = 'list',
        predict_fn = 'function',
        id = 'numeric'
    )
)

#' @export
AllometricModel <- function(response_unit, covariate_units, descriptors,
    predict_fn, id = NA_integer_) {
    allometric_model <- new('AllometricModel')
    allometric_model@response_unit <- response_unit
    allometric_model@covariate_units <- covariate_units
    allometric_model@predict_fn <- predict_fn
    allometric_model@descriptors <- descriptors
    allometric_model@id <- id
    allometric_model
}

# TODO set validity...especially for descriptors, I think enforcing the
# country slot is good

measure_def <- data.frame(
    measure = c('d', 'v', 'g', 'h', 'b', 'r'),
    measure_label = c('diameter', 'volume', 'basal area','height', 'biomass',
        'ratio')
)

component_def <- data.frame(
    component = c('s', 'b', 'f', 'c', 'n', 'p'),
    component_label = c('stem', 'branch', 'foliage', 'crown', 'stand', 'plot')
)

# This obviously has combinations that will never be used, this should be
# prevented at the administration phase
measure_component_def <- merge(measure_def, component_def)

setGeneric('predict_fn', function(x) standardGeneric('predict_fn'))
setMethod('predict_fn', 'AllometricModel', function(x) x@predict_fn)

setGeneric(
    'get_measure_label',
    function(x) standardGeneric('get_measure_label')
)

setMethod(
    'get_measure_label',
    signature(x='AllometricModel'),
    function(x) {
        response_name <- names(x@response_unit)[[1]]
        measure <- substr(response_name, 1, 1)
        measure_def[measure_def$measure==measure, 'measure_label']
    }
)

setGeneric(
    'get_component_label',
    function(x) standardGeneric('get_component_label')
)

setMethod(
    'get_component_label',
    signature(x='AllometricModel'),
    function(x) {
        response_name <- names(x@response_unit)[[1]]
        component <- substr(response_name, 2, 2)
        component_def[component_def$component==component, 'component_label']
    }
)