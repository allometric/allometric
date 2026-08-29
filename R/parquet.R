# Load allometric models from the compiled v4 parquet distribution.
#
# The models repository publishes three parquet tables in `dist/`:
#
#   publications.parquet  — one row per publication (BibTeX metadata)
#   models.parquet        — one row per model set or single model
#   model_specs.parquet   — one row per specification (the queryable unit)
#
# Each spec row carries its own content-hash id; model_specs.set_id joins to
# models.id (the id of the parent set, equal to the spec id for single models)
# and models.pub_id joins to publications.pub_id. A single model has one spec
# row (spec_index 0); a set has one row per specification, each carrying its
# own parameters and scope (fallback-resolved to the set level by the writer).
#
# Loading constructs one `FixedEffectsModel` per spec row directly from these
# tables, bypassing the old publication-ingest pipeline entirely.

# Bump when the reconstruction logic changes so cached model_tbls are rebuilt.
PARQUET_LOADER_VERSION <- "3"

# Parsing unit strings through units::as_units is slow (~0.25 ms per call);
# the corpus uses only a handful of distinct unit strings, so memoize them.
.unit_cache <- new.env(parent = emptyenv())

as_unit_cached <- function(unit) {
  if (is.na(unit) || unit == "" || unit == "unitless") {
    return(units::unitless)
  }
  if (exists(unit, envir = .unit_cache, inherits = FALSE)) {
    return(get(unit, envir = .unit_cache))
  }
  u <- units::as_units(unit)
  assign(unit, u, envir = .unit_cache)
  u
}

#' Read the three v4 parquet tables of a models distribution
#'
#' @param dir The directory containing the three `*.parquet` files
#' @return A list with elements `publications`, `models`, and `model_specs`,
#'   each a tibble.
#' @keywords internal
read_dist_tables <- function(dir) {
  path <- function(file) file.path(dir, file)
  list(
    publications = arrow::read_parquet(path("publications.parquet")),
    models = arrow::read_parquet(path("models.parquet")),
    model_specs = arrow::read_parquet(path("model_specs.parquet"))
  )
}

#' Key identifying the compiled model distribution and the loader that
#' reconstructs it, used to validate cached model tables.
#'
#' @keywords internal
model_dist_key <- function(dist_path) {
  files <- file.path(
    dist_path,
    c("models.parquet", "model_specs.parquet", "publications.parquet")
  )
  hashes <- vapply(
    files,
    function(file) unname(tools::md5sum(file)),
    character(1)
  )
  paste(
    paste(hashes, collapse = ""),
    as.character(utils::packageVersion("allometric")),
    PARQUET_LOADER_VERSION,
    sep = ":"
  )
}

#' Join the three v4 tables to one row per specification with full context
#'
#' Both `models` and `model_specs` carry `taxa`/`region`/`component`/
#' `descriptors` columns; the spec-level scope is the fallback-resolved scope
#' that applies to the individual model, so it is retained as `spec_*` and the
#' model-level scope is dropped. Publication columns are carried through as-is.
#'
#' @param tables A list as returned by `read_dist_tables()`
#' @return A tibble with one row per model spec.
#' @keywords internal
join_model_tables <- function(tables) {
  # The writer falls back spec -> model scope only; a publication-level
  # `region` (which applies to every model of the publication) is carried in
  # the publication descriptors. Apply that fallback here so the effective
  # region, used by filters and the model_tbl, includes it.
  joined <- tables$model_specs |>
    dplyr::left_join(tables$models, by = c(set_id = "id")) |>
    dplyr::rename(
      spec_taxa = .data$taxa.x,
      spec_region = .data$region.x,
      spec_component = .data$component.x,
      spec_descriptors = .data$descriptors.x
    ) |>
    dplyr::select(-.data$taxa.y, -.data$region.y, -.data$component.y,
                  -.data$descriptors.y) |>
    dplyr::left_join(tables$publications, by = "pub_id") |>
    dplyr::rename(pub_descriptors = .data$descriptors)

  joined$spec_region <- Map(
    function(rg, pub) {
      if (!is.null(rg)) {
        return(rg)
      }
      pub_region <- descriptors_json_to_list(pub)$region
      if (is.null(pub_region)) NULL else pub_region
    },
    joined$spec_region,
    joined$pub_descriptors
  )

  joined
}

# --- per-row builders (fresh v4 code, not the legacy JSON converters) ---

#' Build the response slot from a joined spec row
#'
#' @keywords internal
response_from_row <- function(row) {
  r <- as.list(row$response)
  stats::setNames(list(as_unit_cached(r$units)), r$name)
}

#' Build the covariates slot from a joined spec row
#'
#' Covariate order is significant: it defines the argument order of the
#' prediction function. A missing or empty unit string means unitless.
#'
#' @keywords internal
covariates_from_row <- function(row) {
  cc <- row$covariates[[1]]
  out <- lapply(cc$name, function(name) units::unitless)
  names(out) <- cc$name
  for (i in seq_len(nrow(cc))) {
    out[[i]] <- as_unit_cached(cc$units[i])
  }
  out
}

#' Build the prediction function from a `prediction_function` string
#'
#' The function takes the covariate names as arguments and its body is the
#' prediction expression, with parameters as free symbols (substituted later by
#' `ParametricModel`).
#'
#' @keywords internal
predict_fn_from_string <- function(fn_str, covt_names) {
  fn <- eval(parse(text = paste0(
    "function(", paste(covt_names, collapse = ", "), ") NULL"
  )))
  body(fn) <- parse(text = paste0("{", fn_str, "}"))
  fn
}

#' Build the parameters list from a joined spec row
#'
#' @keywords internal
parameters_from_row <- function(row) {
  pp <- row$parameters[[1]]
  stats::setNames(as.list(pp$value), pp$name)
}

#' Build a `Taxa` object from a parquet struct array (list of tibbles)
#'
#' A struct array is returned by arrow as one tibble with one row per struct;
#' it must be iterated row-wise (a tibble iterates columns by default).
#'
#' @keywords internal
taxa_from_row <- function(tt) {
  if (is.null(tt) || nrow(tt) == 0) {
    return(Taxa())
  }
  taxons <- lapply(seq_len(nrow(tt)), function(i) {
    vals <- as.list(tt[i, ])
    Taxon(family = vals$family, genus = vals$genus, species = vals$species)
  })
  do.call(Taxa, taxons)
}

#' Parse a JSON descriptor column to a named list
#'
#' @keywords internal
descriptors_json_to_list <- function(json) {
  if (is.null(json) || is.na(json)) {
    return(list())
  }
  jsonlite::fromJSON(json, simplifyVector = FALSE)
}

#' Build the descriptors tibble (single merged row) from a joined spec row
#'
#' Combines the spec-level scope (taxa, region, component), the free-form spec
#' descriptors, and any publication-level descriptors. Multi-valued entries
#' become list columns.
#'
#' @keywords internal
descriptors_tibble_from_row <- function(row) {
  taxa <- taxa_from_row(row$spec_taxa[[1]])
  region <- row$spec_region[[1]]
  component <- row$spec_component

  free <- descriptors_json_to_list(row$spec_descriptors[[1]])
  pub <- descriptors_json_to_list(row$pub_descriptors[[1]])
  merged <- c(free, pub[!names(pub) %in% names(free)])

  cols <- list()
  if (length(taxa) > 0) {
    cols$taxa <- list(taxa)
  }
  if (!is.null(region)) {
    cols$region <- list(region)
  }
  if (!is.na(component)) {
    cols$component <- component
  }
  for (name in names(merged)) {
    if (name %in% c("taxa", "region", "component")) {
      next
    }
    value <- merged[[name]]
    # The corpus encodes "not specified" as false/null in descriptor JSON;
    # booleans are not descriptors, so drop them rather than emit a value the
    # model validity checks would reject (e.g. country: false).
    if (is.null(value) || (is.logical(value) && length(value) == 1)) {
      next
    }
    cols[[name]] <- if (length(value) > 1) list(value) else value
  }

  if (length(cols) == 0) {
    return(tibble::tibble(.rows = 0))
  }
  tibble::as_tibble(cols)
}

#' Build the covariate definitions from the model-level `covt_defs` JSON
#'
#' @keywords internal
covt_defs_from_row <- function(row) {
  descriptors_json_to_list(row$covt_defs[[1]])
}

#' Build a `BibEntry` citation from a publication row
#'
#' The v4 YAML currently drops most optional BibTeX fields, so the declared
#' bibtype frequently lacks its required fields (e.g. a techreport without
#' `institution`). In that case the citation falls back to `misc` with all
#' present fields retained. Returns a list with `citation` and `fallback`.
#'
#' @keywords internal
citation_from_row <- function(pub_row) {
  args <- list(
    bibtype = pub_row$bibtype,
    key = pub_row$pub_id,
    title = pub_row$title,
    author = pub_row$author,
    year = as.numeric(pub_row$year)
  )
  optional <- c(
    "number", "institution", "journal", "volume", "pages", "doi", "url",
    "publisher", "address", "month", "note", "school", "organization",
    "series", "booktitle", "editor", "howpublished", "edition"
  )
  for (field in optional) {
    if (!is.na(pub_row[[field]])) {
      args[[field]] <- as.character(pub_row[[field]])
    }
  }

  citation <- tryCatch(
    do.call(RefManageR::BibEntry, args),
    error = function(e) NULL
  )
  if (is.null(citation)) {
    args$bibtype <- "misc"
    citation <- do.call(RefManageR::BibEntry, args)
    return(list(citation = citation, fallback = TRUE))
  }

  list(citation = citation, fallback = FALSE)
}

#' Extract author family names from a BibTeX author string
#'
#' @keywords internal
family_names_from_author <- function(author) {
  parts <- trimws(strsplit(author, " and ", fixed = TRUE)[[1]])
  vapply(parts, function(part) {
    if (grepl(",", part, fixed = TRUE)) {
      trimws(sub(",.*", "", part))
    } else {
      utils::tail(strsplit(trimws(part), " ")[[1]], 1)
    }
  }, character(1))
}

#' Construct a `FixedEffectsModel` from a joined spec row
#'
#' @param row One row of the tibble returned by `join_model_tables()`
#' @param citation The `BibEntry` for the row's publication
#' @return An object of class `FixedEffectsModel`
#' @keywords internal
spec_to_model <- function(row, citation) {
  if (!row$model_type %in% c("fixed_effects", "fixed_effects_set")) {
    stop(
      "Unsupported model type '", row$model_type, "' for model ",
      row$id, " (", row$pub_id, " / ", row$model_name, ")"
    )
  }

  response_definition <- row$response_definition
  if (is.na(response_definition)) {
    response_definition <- NA_character_
  }

  model <- FixedEffectsModel(
    response = response_from_row(row),
    covariates = covariates_from_row(row),
    parameters = parameters_from_row(row),
    predict_fn = predict_fn_from_string(
      row$prediction_function, row$covariates[[1]]$name
    ),
    descriptors = descriptors_tibble_from_row(row),
    response_definition = response_definition,
    covariate_definitions = covt_defs_from_row(row)
  )

  model@id <- row$id
  model@pub_id <- row$pub_id
  model@citation <- citation

  model
}

#' Build a `model_tbl` from joined v4 tables
#'
#' One row per specification, mirroring the historical per-model layout. The
#' `id` column carries the 8-character content hash; `spec_index` disambiguates
#' rows within a set and is the join key for future model-family memberships.
#'
#' @param joined The tibble returned by `join_model_tables()`
#' @return A `model_tbl`
#' @keywords internal
build_model_tbl <- function(joined) {
  pubs <- dplyr::distinct(joined, .data$pub_id, .keep_all = TRUE)
  citation_results <- lapply(
    seq_len(nrow(pubs)),
    function(i) citation_from_row(pubs[i, ])
  )
  names(citation_results) <- pubs$pub_id
  citations <- lapply(citation_results, function(x) x$citation)
  fallback_pubs <- pubs$pub_id[
    vapply(citation_results, function(x) x$fallback, logical(1))
  ]
  if (length(fallback_pubs) > 0) {
    warning(
      length(fallback_pubs), " publication(s) lack required BibTeX fields for ",
      "their declared bibtype; citations were built with bibtype 'misc': ",
      paste(utils::head(fallback_pubs, 5), collapse = ", "),
      if (length(fallback_pubs) > 5) ", ..." else "",
      call. = FALSE
    )
  }

  models <- vector("list", nrow(joined))
  for (i in seq_len(nrow(joined))) {
    row <- joined[i, ]
    models[[i]] <- spec_to_model(row, citations[[row$pub_id]])
  }

  family_name <- lapply(
    joined$author,
    function(author) family_names_from_author(author)
  )

  tbl <- tibble::tibble(
    id = joined$id,
    spec_index = joined$spec_index,
    model_name = joined$model_name,
    model_type = vapply(models, function(m) m@model_type, character(1)),
    pub_id = joined$pub_id,
    pub_year = as.numeric(joined$year),
    family_name = family_name,
    covt_name = lapply(models, function(m) names(m@covariates)),
    taxa = lapply(models, function(m) {
      if ("taxa" %in% names(m@descriptors)) {
        m@descriptors$taxa[[1]]
      } else {
        Taxa()
      }
    }),
    region = joined$spec_region,
    component = joined$spec_component,
    model = models
  )

  new_model_tbl(tbl)
}
