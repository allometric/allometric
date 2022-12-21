setClass('Publication',
    slots = c(
        citation = 'BibEntry',
        n_published_models = 'numeric',
        n_published_families = 'numeric',
        models = 'list',
        families = 'list'
    )
)

#' @export
Publication <- function(citation, n_published_models = NA_integer_,
    n_published_families = NA_integer_, models = list(), families = list()) {
    publication <- new('Publication')
    publication@citation <- citation
    publication@n_published_models <- n_published_models
    publication@n_published_families <- n_published_families
    publication@models <- models
    publication@families <- families
    publication
}


setGeneric('add_model',
    function(publication, model) standardGeneric('add_model')
)

setMethod('add_model', 'Publication', function(publication, model) {
    publication@models[[length(publication@models) + 1]] <- model
    publication
})


setGeneric('add_family', function(publication, parametric_family) standardGeneric('add_family'))

setMethod('add_family', 'Publication', function(publication, parametric_family) {
    publication@families[[length(publication@families) + 1]] <- parametric_family
    publication
})