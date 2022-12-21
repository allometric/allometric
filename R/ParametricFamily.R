setClass(
    'ParametricFamily',
    slots = c(
        response_unit = 'list',
        covariate_units = 'list',
        predict_fn = 'function',
        parameter_set = 'data.frame',
        grouping_descriptions = 'list',
        country = 'character',
        region = 'character',
        fit_species = 'character'
    )
)

ParametricFamily <- function(response_unit, covariate_units, predict_fn,
    parameter_set, grouping_descriptions, country = NA_character_,
    region = NA_character_, fit_species = NA_character_) {

    parametric_family <- new('ParametricFamily')
    parametric_family@response_unit <- response_unit
    parametric_family@covariate_units <- covariate_units
    parametric_family@predict_fn <- predict_fn
    parametric_family@parameter_set <- parameter_set
    parametric_family@grouping_descriptions <- grouping_descriptions
    parametric_family@country <- country
    parametric_family@region <- region
    parametric_family@fit_species <- fit_species

    parametric_family
}


# TODO how do we implement predict? Is the user responsible for providing a
# key of some kind?

setGeneric('select_model', function(family, key) standardGeneric('select_model'))
setMethod('select_model', 'ParametricFamily', function(family, key) {
    parameter_names <- names(family@parameter_set)[
        !names(family@parameter_set) %in% names(family@grouping_descriptions)
    ]

    parameters <- merge(family@parameter_set, key)[, parameter_names, drop=F]
    ParametricModel(
        response_unit = family@response_unit,
        covariate_units = family@covariate_units,
        parameters = parameters,
        predict_fn = family@predict_fn,
        country = family@country,
        region = family@region,
        fit_species = family@fit_species
    )
})