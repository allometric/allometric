setClass(
    'ModelSet',
    slots = c(
        response_unit = 'list',
        covariate_units = 'list',
        predict_fn = 'function',
        common_descriptors = 'list',
        parameters_frame = 'tbl',
        models = 'list'
    )
)

ModelSet <- function(response_unit, covariate_units, predict_fn,
    parameters_frame, common_descriptors) {

    model_set <- new('ModelSet')
    model_set@response_unit <- response_unit
    model_set@covariate_units <- covariate_units
    model_set@predict_fn <- predict_fn
    model_set@common_descriptors <- common_descriptors

    for(i in 1:nrow(parameters_frame)) {
        #mod <- ParametricModel(
        #    response_unit = response_unit,
        #    covariate_units = covariate_units,
        #    descriptors = descriptors,
        #    parameters = 
        #    predict_fn = predict_fn
        #)
    }

    model_set
}

# TODO add select_model method for model sets