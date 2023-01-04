# An S3 class that extends tbl_df
# See: https://github.com/DavisVaughan/2020-06-01_dplyr-vctrs-compat/blob/master/dplyr-vctrs-compat.Rmd
# So far this is pretty bare bones, but later versions of allometric may need
# to go further. this is a good start

new_model_tbl <- function(tibble) {
  structure(tibble, class = c('model_tbl', class(tibble)))
}

model_tbl_can_reconstruct <- function(x, to) {
    if(!'model' %in% names(x)) {
        return(FALSE)
    } else {
        return(TRUE)
    }
}

df_reconstruct <- function(x, to) {
  attrs <- attributes(to)

  # Keep column and row names of `x`
  attrs$names <- names(x)
  attrs$row.names <- .row_names_info(x, type = 0L)

  # Otherwise copy over attributes of `to`
  attributes(x) <- attrs

  x
}

new_bare_tibble <- function(x) {
  # Strips all attributes off `x` since `new_tibble()` currently doesn't
  x <- vctrs::new_data_frame(x)
  tibble::new_tibble(x, nrow = nrow(x))
}

model_tbl_reconstruct <- function(x, to) {
  if(model_tbl_can_reconstruct(x, to)) {
    df_reconstruct(x, to)
  } else {
    new_bare_tibble(x)
  }
}


`[.model_tbl` <- function(x, i, j, ...) {
  out <- NextMethod()
  model_tbl_reconstruct(out, x)
}

`names<-.model_tbl` <- function(x, value) {
  out <- NextMethod()
  model_tbl_reconstruct(out, x)
}

#' @export
select_model <- function(data, id) {
  UseMethod("select_model")
}

#' @export
select_model.model_tbl <- function(data, id) {
  if(is.character(id)) {
    out <- data[data$id == id, "model"][[1, 1]][[1]]
  } else if(is.numeric(id)) {
    out <- data[id, "model"][[1, 1]][[1]]
  }

  out
}


unnest_cross <- function(data, cols, ...) {
  .df_out <- data
  purrr::walk(
    cols,
    function(col) {
      .df_out <<- tidyr::unnest(.df_out, dplyr::all_of(col), ...)
    }
  )
  .df_out
}

#' @export
unnest_models <- function(data) {
  UseMethod("unnest_models")
}

#' @export
unnest_models.model_tbl <- function(data,
  expand_cols = c('country', 'region', 'family_names', 'covt_names')) {
  unnested <- unnest_cross(data, expand_cols)

  model_tbl_reconstruct(unnested, data)
}
