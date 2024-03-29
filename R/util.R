

get_ranef_names <- function(predict_ranef) {
  predict_body <- body(predict_ranef)
  last_line_ix <- length(predict_body)
  ranef_list <- predict_body[[last_line_ix]]
  expr_names <- names(ranef_list)
  list_names <- expr_names[-1]
  list_names
}

build_publication <- function(pub_path) {
  source(pub_path)
}

# No clean way to check for existing custom units...
tryCatch(
  {
    units::install_unit("log")
    return(TRUE)
  }, error = function(cond) {
  }, warning = function(cond) {
  }
)

convert_units <- function(..., units_list) {
  args_l <- list(...)
  for(i in seq_along(args_l)) {
    covt <- args_l[[i]]
    covt_unit <- units_list[[i]]

    if("units" %in% class(covt)) {
      deparsed <- units::deparse_unit(covt_unit)
      args_l[[i]] <- do.call(units::set_units, list(covt, deparsed))
    }
  }

  args_l
}

strip_units <- function(values_list)  {
  for(i in seq_along(values_list)) {
    if("units" %in% class(values_list[[i]])) {
      values_list[[i]] <- units::drop_units(values_list[[i]])
    }
  }
  values_list
}

descriptors_to_tibble_row <- function(descriptors) {
  if("tbl_df" %in% class(descriptors)) {
    return(descriptors)
  }

  if(length(descriptors) == 0) {
    return(tibble::tibble(.rows=0))
  } else {
    for(i in 1:length(descriptors)) { # FIXME descriptors is sometimes a tibble...
      if(length(descriptors[[i]]) > 1) {
        descriptors[[i]] <- list(descriptors[[i]])
      } else if(typeof(descriptors[[i]]) == "list" && length(descriptors[[i]]) == 1) {
        # Handles the case when only one list is within a list (e.g., taxa with only one taxon)
        descriptors[[i]] <- list(descriptors[[i]])
      }
    }
    return(tibble::as_tibble(descriptors))
  }
}