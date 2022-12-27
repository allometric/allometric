setOldClass("tbl_df")

#' @export
setGeneric("filter_models", function(data, ...) standardGeneric("filter_models"))

setMethod("filter_models", signature(data = "tbl_df"), function(data, ...) {
    dplyr::filter(data, ...)
})

#' @export
setGeneric("select_model", function(data, ix) standardGeneric("select_model"))

setMethod("select_model", signature(data = "tbl_df", ix = "numeric"), function(data, ix) {
    data[ix, "model"][[1,1]][[1]]
})

check_description <- function(description, expressions) {
  for(filt in expressions) {

    attribute_string <- deparse(filt[[2]])

    eval_string <- sprintf("description$%s", attribute_string)

    attribute_value <- eval(parse(text=eval_string))

    if(is.null(attribute_value)) {
      return(FALSE)
    }

    filt[[2]] <- attribute_value

    if (!eval(filt)) {
      return(FALSE)
    }
  }

  return(TRUE)
}

#' Transforms a set of searched models into a tibble of models and descriptors
aggregate_results <- function(results) {
  agg_results <- list()
  for(i in seq_along(results)) {
    result <- results[[i]]
    pub <- result$pub
    model <- result$model

    model_data <- c(
      pub_id = pub@id,
      model@pub_descriptors,
      model@set_descriptors,
      model@descriptors
    )

    # TODO this should be fixed further up in the package by preventing
    # duplicate descriptor fields. See issue #6
    model_data <- model_data[!duplicated(names(model_data))]

    descriptors_row <- tibble::as_tibble(model_data)
    descriptors_row$model <- c(model)

    agg_results[[i]] <- descriptors_row
  }

  dplyr::bind_rows(agg_results)
}

setMethod("filter_models", signature(data="list"), function(data, ...) {
  results <- list()

  expressions <- rlang::exprs(...)

  for(pub in data) {
    for(response_set in pub@response_sets) {
      for(model_set in response_set) {
        for(model in model_set@models) {
          check <- check_description(model@model_specification, expressions)
          if(check) {
            # This to me is really aggressive, but as things are now, things
            # deep in the hierarchy (i.e., model) do not have access to their
            # parents data...
            results[[length(results) + 1]] <- list(
              pub = pub,
              model = model
            )
          }
        }
      }
    }
  }
  aggregate_results(results)
})