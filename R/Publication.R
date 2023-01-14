#' Check validity of descriptors
#'
#' There must not be any duplicate names across the three sets 
#' (pub, set, model). If there is, stop execution with error that names the
#' duplicated descriptors
#' 
#' @keywords internal
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
    descriptors = "tbl_df",
    id = "character"
  ),
  validity = check_publication_validity
)

listify <- function(list_of_vecs) {
  out <- list()

  for(name in names(list_of_vecs)) {
    out[[name]] <- ifelse(length(list_of_vecs[[name]]) == 1, list_of_vecs[[name]], list(list_of_vecs[[name]]))
  }

  out
}

#' Create a publication that contains allometric models
#'
#' `Publication` represents a technical or scientific document that contains
#' allometric models. Initially, publications do not contain models, and models
#' are added using the `add_model` or `add_set` methods.
#'
#' @param citation
#'    The citation of the paper declared using the `RefManageR::BibEntry` class
#' @param descriptors
#'    A named list of descriptors that are defined for all models contained in
#'    the publication.
#'
#' @export
Publication <- function(citation, descriptors = list()) {
  descriptors <- tibble::as_tibble(listify(descriptors))

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

bind2 <- function(...) {
  args <- list(...)
  out <- list()
  for(i in seq_along(args)) {
    table <- args[[i]]
    if(nrow(table) != 0) {
      out[[i]] <- table
    }
  }

  dplyr::bind_cols(out)
}

#' @rdname add_set
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

      # FIXME if any tibble is empty this will be empty
      model_set@models[[i]]@specification <- bind2(
        publication@descriptors,
        model_set@descriptors,
        model_set@models[[i]]@descriptors,
        model_set@models[[i]]@parameters
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
    for(i in seq_along(publication@response_sets)) {
      for(j in seq_along(publication@response_sets[[i]])) {
        n <- n + length(publication@response_sets[[i]][[j]])
      }
    }

    n
  }
)

setMethod(
  "n_sets",
  "Publication",
  function(publication) {
    n <- 0
    for(i in seq_along(publication@response_sets)) {
      n <- n + length(publication@response_sets[[i]])
    }
    n
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

