if (!("tibble" %in% installed.packages())) setOldClass("tbl_df")

#' @export
# setGeneric("filter_models", function(data, ...) standardGeneric("filter_models"))


#' @export
setGeneric("select_model", function(data, ix) standardGeneric("select_model"))

setMethod("select_model", signature(data = "tbl_df", ix = "numeric"), function(data, ix) {
  data[ix, "model"][[1, 1]][[1]]
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
