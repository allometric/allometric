library(units)
library(tibble)

setOldClass('units')

setClass('AllometricModel',
    slots = c(
        response_unit = 'list',
        covariate_units = 'list',
        predict_fn = 'function'
    )
)

#' Base class for all allometric models.
#'
#' `AllometricModel` represents a generic alloemtric model. In almost all cases
#' it is a class used for inheritance to create more specific allometric model
#' use-cases.
AllometricModel <- function(response_unit, covariate_units, predict_fn) {
    allometric_model <- new('AllometricModel')
    allometric_model@response_unit <- response_unit
    allometric_model@covariate_units <- covariate_units
    allometric_model@predict_fn <- predict_fn
    allometric_model
}

setGeneric('predict_fn', function(x) standardGeneric('predict_fn'))
setMethod('predict_fn', 'AllometricModel', function(x) x@predict_fn)
