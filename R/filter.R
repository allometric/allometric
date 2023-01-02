if (!("tibble" %in% installed.packages())) setOldClass("tbl_df")


# TODO would like to make a new class that derives from tbl_df...
setMethod("select_model", signature(data = "tbl_df", id = "numeric"), function(data, id) {
  data[id, "model"][[1, 1]][[1]]
})

setMethod("select_model", signature(data = "tbl_df", id = "character"), function(data, id) {
  data[data$id == id, "model"][[1, 1]][[1]]
})

check_description <- function(description, expressions) {
  for (filt in expressions) {
    attribute_string <- deparse(filt[[2]])

    eval_string <- sprintf("description$%s", attribute_string)

    attribute_value <- eval(parse(text = eval_string))

    if (is.null(attribute_value)) {
      return(FALSE)
    }

    filt[[2]] <- attribute_value

    if (!eval(filt)) {
      return(FALSE)
    }
  }

  return(TRUE)
}

unnest_cross <- function(data, cols, ...) {
  .df_out <- data
  purrr::walk(
    cols,
    function(col) {
      .df_out <<- tidyr::unnest(.df_out, .data[[col]], ...)
    }
  )
  .df_out
}

#' @export
unnest_models <- function(data,
  expand_cols = c('country', 'region', 'family_names', 'covt_names')) {
  unnest_cross(data, expand_cols)
}
