setClass('Publication',
    slots = c(
        citation = 'BibEntry',
        model_sets = 'list',
        id = 'character'
    )
)

#' @export
Publication <- function(citation, model_sets = list()) {
    publication <- new('Publication')
    publication@citation <- citation
    publication@model_sets <- model_sets

    publication@id <- paste(
        tolower(publication@citation$author[[1]]$family),
        publication@citation$year,
        sep = '_'
    )

    publication
}

setGeneric(
    'add_model',
    function(publication, model) standardGeneric('add_model')
)

setMethod('add_model', 'Publication', function(publication, model) {
    # A model in a publication must be a member of a model set, so adding
    # a single model to a publication creates a "parent" model set

    set_of_one <- ModelSet(
        response_unit = model@response_unit,
        covariate_units = model@covariate_units,
        predict_fn = model@predict_fn,
        common_descriptors = model@descriptors,
        model_descriptions = model@model_description,
        id = length(publication@model_sets) + 1
    )

    publication@model_sets[[length(publication@model_sets) + 1]] <- set_of_one
    publication
})

setGeneric(
    'add_set',
    function(publication, model_set) standardGeneric('add_set')
)

setMethod(
    'add_set',
    'Publication',
    function(publication, model_set) {
        model_set@id <- length(publication@model_sets) + 1
        publication@model_sets[[length(publication@model_sets) + 1]] <- model_set
        publication
    }
)

setGeneric('n_models', function(publication) standardGeneric('n_models'))

setMethod(
    'n_models',
    'Publication',
    function(publication) {
        n <- 0
        for(i in seq_along(publication@model_sets)) {
            n <- n + length(publication@model_sets[[i]])
        }
        n
    }
)


setGeneric('n_sets', function(publication) standardGeneric('n_sets'))

setMethod(
    'n_sets',
    'Publication',
    function(publication) {
        length(publication@model_sets)
    }
)

setGeneric('summary', function(publication) standardGeneric('summary'))

setMethod(
    'summary',
    'Publication',
    function(publication) {
        print(str(publication@citation))
    }
)

