# An S3 class that extends tbl_df
# See: https://github.com/DavisVaughan/2020-06-01_dplyr-vctrs-compat/blob/master/dplyr-vctrs-compat.Rmd
# So far this is pretty bare bones, but later versions of allometric may need
# to go further. this is a good start

new_model_tbl <- function(tibble) {
  structure(tibble, class = c("model_tbl", class(tibble)))
}

model_tbl_can_reconstruct <- function(x, to) {
  if (!"model" %in% names(x)) {
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
  if (model_tbl_can_reconstruct(x, to)) {
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

#' Select an allometric model
#'
#' This is a generic function used to select allometric models out of larger
#' collections, like `model_tbl`.
#'
#' @param model_tbl A `model_tbl` object
#' @param id The model id or index
#' @return An allometric model object
#' @export
select_model <- function(model_tbl, id) {
  UseMethod("select_model")
}

#' Select a model from `allometric_models`
#'
#' This function is used to select a single model from a `model_tbl`
#' dataframe using its id.
#'
#' @inheritParams select_model
#' @return An allometric model object
#' @keywords internal
#' @export
select_model.model_tbl <- function(model_tbl, id) {
  if (is.character(id)) {
    out <- model_tbl[model_tbl$id == id, "model"][[1, 1]][[1]]
  } else if (is.numeric(id)) {
    out <- model_tbl[id, "model"][[1, 1]][[1]]
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

#' Unnest columns of a dataframe
#'
#' @param data A dataframe
#' @param cols A character vector indicating the columns to unnest
#' @return The unnested `model_tbl`
#' @export
unnest_models <- function(data, cols) {
  UseMethod("unnest_models")
}

#' Unnest the columns of `model_tbl`
#'
#' A `model_tbl` often contains nested information within the cells of the
#' table. This function allows a user to unnest the columns of interest.
#'
#' @param data A `model_tbl`
#' @param cols A character vector of columns to unnest
#' @return The unnested `model_tbl`
#' @keywords internal
#' @export
unnest_models.model_tbl <- function(data, cols) {
  unnested <- unnest_cross(data, cols)

  model_tbl_reconstruct(unnested, data)
}

#' Unnest the taxa column of a `model_tbl`
#'
#' In some cases it is convenient to expand the taxonomic specifications for
#' each model contained in the `taxa` column. This function achieves this,
#' and adds `family`, `genus`, and `species` character columns. Models with
#' more than one taxon are replicated as new rows.
#'
#' @param data A `model_tbl`
#' @return A `model_tbl` with family, genus and species columns attached
#' @export
unnest_taxa <- function(data) {
  UseMethod("unnest_taxa")
}

expand_taxa <- function(taxa) {
  lapply(
    taxa,
    function(taxon) {
      return(
        list(
          family = taxon@family, genus = taxon@genus, species = taxon@species
        ))
    })
}

concat_taxa_data <- function(x, i) {
  expanded_taxa_data <- dplyr::bind_rows(expand_taxa(x$taxa[[1]]))

  if(nrow(expanded_taxa_data) == 0) {
    expanded_taxa_data <- tibble::tibble(family = NA, genus = NA, species = NA)
  }

  dplyr::bind_cols(x, expanded_taxa_data)
}

#' Unnest the taxa column of a `model_tbl`
#'
#' In some cases it is convenient to expand the taxonomic specifications for
#' each model contained in the `taxa` column. This function achieves this,
#' and adds `family`, `genus`, and `species` character columns. Models with
#' more than one taxon are replicated as new rows.
#'
#' @param data A `model_tbl`
#' @return A `model_tbl` with family, genus and species columns attached
#' @export
unnest_taxa.model_tbl <- function(data) {
  expanded <- data %>%
    dplyr::group_by(dplyr::row_number()) %>%
    dplyr::group_map(concat_taxa_data) %>%
    dplyr::bind_rows()

  model_tbl_reconstruct(expanded, data)
}

#' Predict allometric attributes using a column of allometric models
#'
#' A frequent pattern in forest inventory anaylsis is the need to produce
#' predictions of models with the same functional form, but using different
#' models. `predict_allo` enables this by allowing the user to pass a
#' list-column of models as an argument, along with the associated covariates.
#' This pattern plays well with `dplyr` functions such as `dplyr::mutate()`.
#'
#' @param model_list A list-column of models
#' @param ... Additional arguments passed to each model's `predict_fn`
#' @return A vector of predictions
#' @export
#' @examples
#' tree_data <- tibble::tibble(
#'  dbh = c(10, 20), ht = c(50, 75), model = c(list(brackett_rubra), list(brackett_acer))
#' )
#'
#' tree_data %>%
#'   dplyr::mutate(vol = predict_allo(model, dbh, ht))
predict_allo <- function(model_list, ...) {
  predict(model_list[[1]], ...)
}

#' Merge a `model_tbl` with another data frame.
#'
#' This merge function ensures that, when `model_tbl` is used in a merge that
#' the resultant dataframe is still a `model_tbl`.
#'
#' @param x A data frame or `model_tbl`
#' @param y A data frame or `model_tbl`
#' @param ... Additional arguments passed to `merge`
#' @return A `model_tbl` merged with the inputs
#' @export
merge.model_tbl <- function(x, y, ...) {
  x_ <- as.data.frame(x)
  merged <- merge(x_, y, ...)
  model_tbl_reconstruct(merged, x)
}

append_search_descriptors <- function(row, model_descriptors) {
  row$country <- list(unlist(model_descriptors$country))
  row$region <- list(unlist(model_descriptors$region))
  row$taxa <- model_descriptors$taxa
  row
}

#' Creates a dataframe row from model information
#'
#' @keywords internal
create_model_row <- function(model) {
  model_descriptors <- model@descriptors

  if(!"taxa" %in% colnames(model_descriptors)) {
    model_descriptors$taxa <- list(allometric::Taxa())
  }

  model_row <- tibble::as_tibble(list(pub_id = model@pub_id))
  model_row$model <- c(model)

  # Gets rid of column not exist errors.
  suppressWarnings(
    model_row <- append_search_descriptors(
      model_row,
      model_descriptors
    )
  )

  family_name <- model@citation$author$family
  model_row$family_name <- list(as.character(family_name))

  covt_name <- names(model@covariates)
  model_row$covt_name <- list(covt_name)

  pub_year <- as.numeric(model@citation$year)
  model_row$pub_year <- pub_year

  response_def <- allometric::get_variable_def(names(model@response)[[1]], return_exact_only = T)
  model_row$model_type <- model@model_type

  model_row
}