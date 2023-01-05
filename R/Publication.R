#' Check validity of descriptors
#' 
#' There must not be any duplicate names across the three sets 
#' (pub, set, model). If there is, stop execution with error that names the
#' duplicated descriptors
check_descriptor_set <- function(descriptor_set) {
  dups <- names(descriptor_set)[duplicated(names(descriptor_set))]

  if(length(dups) > 0) {
    stop(paste("Duplicated descriptors:", dups))
  }
}

check_publication_validity <- function(object) {
  errors <- c()
  errors <- c(errors, check_descriptor_validity(object@descriptors))
  if (length(errors) == 0) TRUE else errors
}

.Publication <- setClass("Publication",
  slots = c(
    citation = "BibEntry",
    response_sets = "list",
    descriptors = "list",
    id = "character"
  ),
  validity = check_publication_validity
)

#' @export
Publication <- function(citation, descriptors = list()) {
  publication <- .Publication(
    citation = citation,
    descriptors = descriptors,
    response_sets = list()
  )

  publication@id <- paste(
    tolower(publication@citation$author[[1]]$family),
    publication@citation$year,
    sep = "_"
  )

  publication
}

#' @export
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
    for (i in seq_along(model_set@models)) {
      check_descriptor_set(c(publication@descriptors, model_set@descriptors, model_set@models[[i]]@descriptors))

      model_set@models[[i]]@pub_descriptors <- publication@descriptors
      model_set@models[[i]]@set_descriptors <- model_set@descriptors
      model_set@models[[i]]@citation <- publication@citation
      model_set@models[[i]]@specification <- c(
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

setMethod("add_model", signature(
  publication = "Publication",
  model = "FixedEffectsModel"
), function(publication, model) {
  set_of_one <- init_set_of_one(model)
  set_of_one@pub_descriptors <- publication@descriptors

  publication <- add_set(publication, set_of_one)
  publication
})

setMethod("add_model", signature(
  publication = "Publication",
  model = "MixedEffectsModel"
), function(publication, model) {
  set_of_one <- init_set_of_one(model)
  set_of_one@pub_descriptors <- publication@descriptors

  publication <- add_set(publication, set_of_one)
  publication
})

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

setMethod(
  "n_sets",
  "Publication",
  function(publication) {
    length(publication@model_sets)
  }
)

setMethod(
  "summary",
  "Publication",
  function(publication) {
    print(utils::str(publication@citation))
  }
)

setMethod("show", "Publication", function(object) {
  cat(RefManageR::TextCite(object@citation))

  response_names <- names(object@response_sets)

  for(response_name in response_names) {
    cat('\n')
    n_sets <- length(object@response_sets[[response_name]])
    if(n_sets > 1) {
      cat(sprintf('--- %s: %s model sets', response_name, n_sets))
    } else {
      cat(sprintf('--- %s: %s model set', response_name, n_sets))
    }

    for(i in 1:n_sets) {
      n_models <- length(object@response_sets[[response_name]][[i]]@models)
      cat('\n')
      if(n_models > 1) {
        cat(sprintf('--------- %s models', n_models))
      } else {
        cat(sprintf('--------- %s model', n_models))
      }
    }
  }
})

