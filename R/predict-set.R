#' Predict with a set of allometric models
#'
#' `predict` accepts a list of models (for example, a list-column in a data
#' frame) and applies each model to the covariate values for its row. This
#' makes it straightforward to predict with many models in a single
#' `dplyr::mutate()` call:
#'
#' ```r
#' data |>
#'   dplyr::left_join(my_models, by = "SPCD") |>
#'   dplyr::mutate(vol = predict(model, dsob = DIA * 2.54, hst = HT * 0.3048))
#' ```
#'
#' Covariate arguments may be unnamed, in which case they are matched
#' positionally to each model's covariates and all models must share the same
#' functional form. Alternatively, arguments may be named by covariate, in
#' which case each model is matched by name and only the covariates it
#' requires are used; models whose covariates are not all supplied produce
#' `NA` with a warning. This allows sets of models with different functional
#' forms and covariate orders to be predicted in a single call.
#'
#' Each covariate argument must be length 1 or the number of models, and is
#' recycled as necessary. Rows where the model is `NA` (e.g., unmatched rows
#' after a `dplyr::left_join()`) produce `NA`.
#'
#' @param model A list of allometric models, or a `model_tbl` with one model
#'   per row
#' @param ... Covariate values passed to each model's `predict_fn`. Named
#'   arguments are matched to models by covariate name; unnamed arguments are
#'   matched positionally
#' @param output_units Optionally specify the output units of the predictions
#'   as a string, e.g., `"ft^3"`
#' @return A vector of predictions. When models have units, the result carries
#'   the response units of the first model (converting the others as needed);
#'   pass `output_units` to convert explicitly.
#' @rdname predict-set
setMethod("predict", signature(model = "list"), function(model, ..., output_units = NULL) {
  if (length(model) == 0) {
    return(numeric(0))
  }

  args <- list(...)
  if (length(args) == 0) {
    stop("no covariates supplied to predict()")
  }

  arg_names <- names(args)
  if (is.null(arg_names)) {
    arg_names <- rep("", length(args))
  }
  n_named <- sum(nzchar(arg_names))

  if (n_named > 0 && n_named < length(args)) {
    stop("covariate arguments must be either all named or all unnamed")
  }
  if (anyDuplicated(arg_names[nzchar(arg_names)])) {
    stop("duplicate covariate arguments supplied to predict()")
  }

  model_covariates <- lapply(model, function(m) {
    if (isS4(m)) names(m@covariates) else NULL
  })

  if (n_named == 0) {
    distinct_covt <- unique(model_covariates)
    if (length(distinct_covt) > 1) {
      warning(
        "models in the set have different covariate requirements; ",
        "use named covariate arguments to predict each model correctly"
      )
    }
  } else {
    all_covt <- unique(unlist(model_covariates))
    unused <- setdiff(arg_names[nzchar(arg_names)], all_covt)
    if (length(unused) > 0) {
      warning(
        "covariate argument(s) not used by any model: ",
        paste(unused, collapse = ", ")
      )
    }
  }

  # A single model is predicted directly, preserving vectorized behavior.
  if (length(model) == 1) {
    m1 <- model[[1]]
    if (!isS4(m1)) {
      if (is.logical(m1) && length(m1) == 1 && is.na(m1)) {
        return(NA)
      }
      stop("element 1 of the model column is not an allometric model")
    }
    if (n_named == 0) {
      return(do.call(predict, c(list(m1), args, list(output_units = output_units))))
    }
    covt_names <- names(m1@covariates)
    ix <- match(covt_names, arg_names)
    missing_covt <- covt_names[is.na(ix)]
    if (length(missing_covt) > 0) {
      warning(sprintf(
        "model requires covariates not supplied: %s; returning NA",
        paste(missing_covt, collapse = ", ")
      ))
      return(NA)
    }
    return(do.call(predict, c(list(m1), args[ix], list(output_units = output_units))))
  }

  n_rows <- max(c(length(model), lengths(args)))
  bad_lengths <- vapply(
    args, function(a) length(a) != 1 && length(a) != n_rows, logical(1)
  )
  if (any(bad_lengths)) {
    stop(
      "covariate arguments must be length 1 or the number of models (",
      n_rows, ")"
    )
  }

  preds <- vector("list", n_rows)
  for (i in seq_len(n_rows)) {
    m <- model[[min(i, length(model))]]
    if (!isS4(m)) {
      if (is.logical(m) && length(m) == 1 && is.na(m)) {
        preds[[i]] <- NA
        next
      }
      stop(sprintf("element %d of the model column is not an allometric model", i))
    }

    row_args <- lapply(args, function(a) if (length(a) == 1) a else a[i])

    if (n_named == 0) {
      preds[[i]] <- do.call(predict, c(list(m), row_args, list(output_units = output_units)))
      next
    }

    covt_names <- names(m@covariates)
    ix <- match(covt_names, arg_names)
    missing_covt <- covt_names[is.na(ix)]
    if (length(missing_covt) > 0) {
      pub_id <- ""
      if ("pub_id" %in% methods::slotNames(m)) {
        pub_id <- sprintf(" (pub_id = %s)", m@pub_id)
      }
      warning(
        sprintf(
          "model %d%s requires covariates not supplied: %s; returning NA",
          i, pub_id, paste(missing_covt, collapse = ", ")
        )
      )
      preds[[i]] <- NA
      next
    }

    preds[[i]] <- do.call(
      predict, c(list(m), row_args[ix], list(output_units = output_units))
    )
  }

  is_units_pred <- vapply(preds, function(p) inherits(p, "units"), logical(1))

  if (any(is_units_pred)) {
    na_rows <- vapply(
      preds, function(p) is.logical(p) && length(p) == 1 && is.na(p), logical(1)
    )
    if (any(!is_units_pred & !na_rows)) {
      stop("predict() produced a mix of units and plain numeric results")
    }
    if (any(na_rows)) {
      if (is.null(output_units)) {
        s4_ix <- which(vapply(model, isS4, logical(1)))
        unit_str <- units::deparse_unit(model[[s4_ix[[1]]]]@response[[1]])
      } else {
        unit_str <- output_units
      }
      for (i in which(na_rows)) {
        preds[[i]] <- do.call(
          units::set_units, list(as.numeric(preds[[i]]), unit_str)
        )
      }
    }
    return(do.call(c, preds))
  }

  unlist(preds)
})

# Register the S3 model_tbl class so it can be dispatched on by S4 generics.
setOldClass(c("model_tbl", "tbl_df", "tbl", "data.frame"))

#' @rdname predict-set
setMethod("predict", signature(model = "model_tbl"), function(model, ...) {
  if (!"model" %in% names(model)) {
    stop("model_tbl has no 'model' column")
  }
  predict(model$model, ...)
})
