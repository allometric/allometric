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

filter_models <- function(data, ...) {
  results <- list()

  expressions <- rlang::exprs(...)

  for(pub in data) {
    for(response_set in pub@response_sets) {
      for(model_set in response_set) {
        for(model in model_set@models) {
          check <- check_description(model@model_description, expressions)
          if(check) {
            results[[length(results) + 1]] <- model
          }
        }
      }
    }
  }
  results
}