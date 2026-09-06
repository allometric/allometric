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

#' Extract descriptors of a `model_tbl` into columns
#'
#' Descriptors describe the context of an allometric model, such as the
#' country or region where the model data were collected, the processing
#' group or equation of a model set, or any other fields declared by the
#' publication. A `model_tbl` surfaces a few curated descriptors as columns
#' (`taxa`, `region`, `component`); the rest are stored on each model object.
#' This function widens the requested descriptors into columns of the table,
#' one row per model, so they can be filtered, selected, and browsed like any
#' other column.
#'
#' Scalar descriptors (e.g. `country`, `proc_group`, `p`) become atomic
#' columns, with `NA` where a model does not declare the descriptor.
#' Descriptors that are multi-valued in any row (e.g. a model applicable to
#' several regions) are returned as list columns, matching the style of the
#' `region` column; rows that do not declare the descriptor hold `NULL`.
#' Descriptor columns that are already present in the table are returned
#' unchanged.
#'
#' @param data A `model_tbl`
#' @param ... Descriptor names to extract, given with tidyselect semantics
#'   (e.g. `country`, or `dplyr::any_of(c("country", "p"))`). When a name is
#'   not found, or nothing is selected, an error lists the descriptors
#'   available in the table.
#' @return A `model_tbl` with the requested descriptor columns added after
#'   the existing columns. Each model contributes one row, so the number of
#'   rows is unchanged.
#' @export
#' @examples
#' models <- load_models()
#'
#' models |>
#'   extract_descriptors(country, proc_group) |>
#'   dplyr::filter(proc_group == "taxa")
extract_descriptors <- function(data, ...) {
  UseMethod("extract_descriptors")
}

#' @inheritParams extract_descriptors
#' @description
#' The `model_tbl` method of `extract_descriptors()`.
#' @return A `model_tbl` with the requested descriptor columns added.
#' @export
extract_descriptors.model_tbl <- function(data, ...) {
  if (!"model" %in% names(data)) {
    stop("`data` must contain a `model` column", call. = FALSE)
  }

  # One row of descriptors per model, resolved at load time from the
  # specification, set, and publication levels.
  desc_rows <- vector("list", nrow(data))
  for (i in seq_len(nrow(data))) {
    d <- tryCatch(descriptors(data$model[[i]]), error = function(e) NULL)
    if (!is.data.frame(d)) {
      stop(
        "extract_descriptors() requires a `model_tbl` of individual ",
        "models; row ", i, " does not provide a descriptor table",
        call. = FALSE
      )
    }
    desc_rows[[i]] <- d
  }

  keys <- unique(unlist(lapply(desc_rows, names)))
  if (length(keys) == 0) {
    stop("no descriptors found in the table", call. = FALSE)
  }

  avail <- tibble::new_tibble(
    stats::setNames(rep(list(character()), length(keys)), keys),
    nrow = 0
  )
  sel <- tryCatch(
    tidyselect::eval_select(rlang::expr(c(...)), avail),
    error = function(e) {
      stop(
        conditionMessage(e), "\nAvailable descriptors: ",
        paste(keys, collapse = ", "), call. = FALSE
      )
    }
  )
  if (length(sel) == 0) {
    stop(
      "select at least one descriptor to extract. Available ",
      "descriptors: ", paste(keys, collapse = ", "), call. = FALSE
    )
  }

  requested <- names(sel)
  to_add <- requested[!requested %in% names(data)]
  if (length(to_add) == 0) {
    return(data)
  }

  out <- tibble::as_tibble(data)
  for (k in to_add) {
    cells <- lapply(desc_rows, function(d) {
      if (k %in% names(d) && nrow(d) > 0) d[[k]][[1]] else NULL
    })
    multi <- any(vapply(
      cells, function(v) !is.null(v) && length(v) > 1, logical(1)
    ))
    if (multi) {
      out[[k]] <- lapply(cells, function(v) if (is.null(v)) NULL else v)
    } else {
      out[[k]] <- vctrs::vec_c(
        !!!lapply(cells, function(v) if (is.null(v)) NA else v)
      )
    }
  }

  new_model_tbl(out)
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