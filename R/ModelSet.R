setClass(
    'ModelSet',
    slots = c(
        response_unit = 'list',
        covariate_units = 'list',
        predict_fn = 'function',
        common_descriptors = 'list',
        models = 'list',
        id = 'numeric'
    )
)

ModelSet <- function(response_unit, covariate_units, predict_fn,
    common_descriptors, model_descriptions, id = NA_integer_) {

    model_set <- new('ModelSet')
    model_set@response_unit <- response_unit
    model_set@covariate_units <- covariate_units
    model_set@predict_fn <- predict_fn
    model_set@common_descriptors <- common_descriptors
    model_set@id <- id

    if("list" %in% class(model_descriptions)) {
        model_descriptions <- tibble(data.frame(model_descriptions))
    }

    for(i in 1:nrow(model_descriptions)) {
        mod <- ParametricModel(
            response_unit = response_unit,
            covariate_units = covariate_units,
            model_description = model_descriptions[i,],
            predict_fn = predict_fn,
            id = i
        )

        model_set@models[[length(model_set@models) + 1]] <- mod

    }

    model_set
}

# TODO add select_model method for model sets