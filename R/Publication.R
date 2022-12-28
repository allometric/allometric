setClass("Publication",
  slots = c(
    citation = "BibEntry",
    response_sets = "list",
    descriptors = "list",
    id = "character"
  )
)

#' @export
Publication <- function(citation, response_sets = list(),
  descriptors = list()) {
  publication <- methods::new("Publication")
  publication@citation <- citation
  publication@response_sets <- response_sets
  publication@descriptors <- descriptors

  publication@id <- paste(
    tolower(publication@citation$author[[1]]$family),
    publication@citation$year,
    sep = "_"
  )

  publication
}

setGeneric(
  "add_set",
  function(publication, model_set) standardGeneric("add_set")
)

setMethod(
  "add_set",
  "Publication",
  function(publication, model_set) {
    response_name <- names(model_set@response_unit)[[1]]

    # Propagate the pub descriptors to the set
    model_set@pub_descriptors <- publication@descriptors

    # Propagate the pub to the models
    for(i in seq_along(model_set@models)) {
      model_set@models[[i]]@pub_descriptors <- publication@descriptors
      model_set@models[[i]]@set_descriptors <- model_set@descriptors
      model_set@models[[i]]@model_specification <- c(
        publication@descriptors, model_set@descriptors, model_set@models[[i]]@descriptors, model_set@models[[i]]@parameters
      )
    }

    if (is.null(publication@response_sets[[response_name]])) {
      publication@response_sets[[response_name]] <- list(
        model_set
      )
    } else {
      n_mods <- length(publication@response_sets[[response_name]])
      publication@response_sets[[response_name]][[n_mods + 1]] <- model_set
    }

    publication
  }
)

setGeneric(
  "add_model",
  function(publication, model) standardGeneric("add_model")
)

setMethod("add_model", "Publication", function(publication, model) {
  # A model in a publication must be a member of a model set, so adding
  # a single model to a publication creates a "parent" model set
  set_of_one <- ModelSet(
    response_unit = model@response_unit,
    covariate_units = model@covariate_units,
    predict_fn = model@predict_fn,
    model_specifications = model@model_specification,
  )

  set_of_one@pub_descriptors <- publication@descriptors

  publication <- add_set(publication, set_of_one)

  publication
})

setGeneric("n_models", function(publication) standardGeneric("n_models"))

setMethod(
  "n_models",
  "Publication",
  function(publication) {
    n <- 0
    for (i in seq_along(publication@model_sets)) {
      n <- n + length(publication@model_sets[[i]])
    }
    n
  }
)


setGeneric("n_sets", function(publication) standardGeneric("n_sets"))

setMethod(
  "n_sets",
  "Publication",
  function(publication) {
    length(publication@model_sets)
  }
)

setGeneric("summary", function(publication) standardGeneric("summary"))

setMethod(
  "summary",
  "Publication",
  function(publication) {
    print(utils::str(publication@citation))
  }
)

