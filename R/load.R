combine_taxa <- function(data, key) {
  taxon_list <- list()

  for(i in 1:nrow(data)) {
    data_i <- data[i,]
    taxon_list[[i]] <- Taxon(
      family = data_i$family, genus = data_i$genus, species = data_i$species
    )
  }

  taxa <- do.call(Taxa, taxon_list)
  distinct_cols <- colnames(data)[!colnames(data) %in% c("family", "genus", "species")]

  distinct_data <- data %>%
    dplyr::distinct_at(.vars = distinct_cols)

  if(nrow(distinct_data) != 1) {
    stop("Could not generate a distinct taxonomic row for taxa ID:", key$taxa_id)
  }

  distinct_data$taxa <- list(taxa)
  distinct_data
}

#' Aggregate family, genus, and species columns of `tbl_df`` into taxa data
#' structure
#'
#' This function facilitates aggregating family, genus, and species columns
#' into the taxa data structure, which is a nested list composed of multiple
#' "taxons". A taxon is a list containing family, genus, and species fields.
#'
#' @param table The table for which the taxa will be aggregated
#' @param grouping_col An optional column to group on when creating taxa. Rows
#'  with the same grouping_col value will be stored into the same taxa.
#' @return A tibble with family, genus, and species columns added
#' @export
aggregate_taxa <- function(table, grouping_col = NULL)
  {
  default_taxon_fields <- c("family", "genus", "species")
  taxon_fields <- colnames(table)[colnames(table) %in% default_taxon_fields]
  missing_taxon_fields <- default_taxon_fields[!default_taxon_fields %in% taxon_fields]

  if(is.null(grouping_col)) {
    taxa_fill <- 1:nrow(table)
  } else {
    taxa_fill <- tibble::deframe(table[,grouping_col])
  }

  table %>%
    dplyr::mutate(!!!stats::setNames(rep(list(NA), length(missing_taxon_fields)), missing_taxon_fields)) %>%
    dplyr::mutate(taxa_id = taxa_fill) %>%
    dplyr::group_by(.data$taxa_id) %>%
    dplyr::group_map(combine_taxa) %>%
    dplyr::bind_rows()
}

#' Load the locally installed table of allometric models
#'
#' This function loads all locally installed allometric models if they are
#' downloaded and installed, if not run the `install_models` function. The
#' result is of class `model_tbl`, which behaves very much like a
#' `tibble::tbl_df` or a `data.frame`.
#'
#' Printing the `head` of `allometric_models`, we can see the structure of the
#' data
#'
#' ```{r}
#' allometric_models <- load_models()
#' head(allometric_models)
#' ```
#'
#' The columns are:
#' * `id` - A unique ID for the model. This is the 8-character content hash
#' assigned by the v4 model compilation pipeline.
#' * `spec_index` - The index of the specification within its model set (0 for
#' single models). Together with `id` this uniquely identifies a model.
#' * `model_name` - The name of the model or model set.
#' * `model_type` - The type of model (e.g., stem volume, site index, etc.)
#' * `pub_id` - A unique ID representing the publication.
#' * `pub_year` - The publication year.
#' * `family_name` - The names of the contributing authors.
#' * `covt_name` - The names of the covariates used in the model.
#' * `taxa` - The taxonomic specification of the trees that are modeled.
#' * `region` - The region or regions (e.g., state, province, etc.) from which
#' the model data is from.
#' * `component` - The tree component modeled (e.g., stem, branch).
#' * `model` - The model object itself.
#'
#' Models can be searched by their attributes. Note that some of the columns
#' are `list` columns, which contain lists as their elements. Filtering on
#' data in these columns requires the use of `purrr::map_lgl` which is used to
#' determine truthiness of expressions for each element in a `list` column.
#' While this may seem complicated, we believe the nested data structures are
#' more descriptive and concise for storing the models, and users will quickly
#' find that searching models in this way can be very powerful.
#'
#' # Finding Contributing Authors
#'
#' Using `purr::map_lgl` to filter the `family_name` column, we are able to
#' find publications that contain specific authors of interst. For example, we
#' may want models only authored by `"Hann"`. This is elementary to do in
#' `allometric`:
#'
#' ```{r}
#' hann_models <- dplyr::filter(
#'  allometric_models,
#'  purrr::map_lgl(family_name, ~ 'Hann' %in% .)
#' )
#'
#' head(hann_models)
#' nrow(hann_models)
#' ```
#'
#' Picking apart the above code block, we see that we are using the standard
#' `dplyr::filter` function on the `allometric_models` dataframe. The second
#' argument is a call using `purrr:map_lgl`, which will map over each list
#' (contained as elements in the `family_names` column). The second argument to
#' this function, `~ 'Hann' %in% .` is itself a function that checks if `'Hann'`
#' is in the current list. Imagine we are marching down each row of
#' `allometric_models`, `.` represents the element of `family_names` we are
#' considering, which is itself a list of author names.
#'
#' # Finding First Authors
#'
#' Maybe we are only interested in models where `'Hann'` is the first author.
#' Using a simple modification we can easily do this.
#'
#' ```{r}
#' hann_first_author_models <- dplyr::filter(
#'   allometric_models,
#'   purrr::map_lgl(family_name, ~ 'Hann' == .[[1]])
#' )
#'
#' head(hann_first_author_models)
#' nrow(hann_first_author_models)
#' ```
#'
#' We can see that `'Hann'` is the first author for
#' `r nrow(hann_first_author_models)` models in this package.
#'
#' # Finding Models for a Given Species
#'
#' One of the most common things people need is a model for a particular
#' species. For this, we must interact with the `taxa` column. For example,
#' to find models for the Pinus genus we can use
#'
#' ```{r}
#' pinus_models <- dplyr::filter(
#'  allometric_models,
#'  purrr::map_lgl(taxa, ~ "Pinus" %in% .)
#' )
#'
#' head(pinus_models)
#' nrow(pinus_models)
#' ```
#'
#' Users can also search with a specific taxon, which allows a full
#' specification from family to species. For example, if we want models that
#' apply to Ponderosa pine, first declare the necessary taxon, then use it to
#' filter as before
#'
#' ```{r}
#' ponderosa_taxon <- Taxon(
#'  family = "Pinaceae", genus = "Pinus", species = "ponderosa"
#' )
#'
#' ponderosa_models <- dplyr::filter(
#'  allometric_models,
#'  purrr::map_lgl(taxa, ~ ponderosa_taxon %in% .)
#' )
#' 
#' nrow(ponderosa_models)
#' ````
#'
#' # Finding a Model with Specific Data Requirements
#'
#' We can even check for models that contain certain types of data requirements.
#' For example, the following block finds diameter-height models, specifically
#' models that use diameter outside bark at breast height as the *only*
#' covariate. The utility here is obvious, since many inventories are vastly
#' limited by their available tree measurements.
#'
#' ```{r}
#' dia_ht_models <- dplyr::filter(
#'     allometric_models,
#'     model_type == 'stem height',
#'     purrr::map_lgl(covt_name, ~ length(.)==1 & .[[1]] == 'dsob'),
#' )
#'
#' nrow(dia_ht_models)
#' ```
#'
#' Breaking this down, we have the first condition `model_type=='stem_height'`
#' selecting only models concerned with stem heights as a response variable. The
#' second line maps over each element of the `covt_name` column, which is a
#' character vector. The `.` represents a given character vector for that row.
#' First, we ensure that the vector is only one element in size using
#' `length(.)==1`, then we ensure that the first (and only) element of this
#' vector is equal to `'dsob'`, (diameter outside bark at breast height). In
#' this case, `r nrow(dia_ht_models)` are available in the package.
#'
#' # Finding a Model for a Region
#'
#' By now the user should be sensing a pattern. We can apply the exact same
#' logic as the *Finding Contributing Authors* section to find all models
#' developed using data from `US-CO`
#'
#' ```{r}
#' us_co_models <- dplyr::filter(
#'     allometric_models,
#'     purrr::map_lgl(region, ~ "US-CO" %in% .),
#' )
#'
#' nrow(us_co_models)
#' ```
#'
#' # Loading a Subset of Models
#'
#' Loading every model reconstructs the full ~2400-model table, which is slow
#' and memory-heavy. Pass `model_type`, `country`, or `region` to load only the
#' models you need. The filters are applied before the model objects are
#' constructed, so a filtered load never materializes the models it excludes.
#' All three filters are optional and may be combined.
#'
#' For example, to load only stem-height models:
#'
#' ```{r}
#' ht_models <- load_models(model_type = "stem height")
#'
#' nrow(ht_models)
#' ```
#'
#' Or only models from the state of Colorado, US:
#'
#' ```{r}
#' us_co_models <- load_models(region = "US-CO")
#'
#' nrow(us_co_models)
#' ```
#'
#' Or only models from Canada:
#'
#' ```{r}
#' canada_models <- load_models(country = "CA")
#'
#' nrow(canada_models)
#' ```
#'
#' @param model_type An optional character vector of model types to load (e.g.
#'   `"stem height"`, `"stem volume"`). Only models whose type appears in this
#'   vector are loaded.
#' @param country An optional character vector of ISO 3166-1 alpha-2 country
#'   codes (e.g. `"US"`, `"CA"`, `"ES"`). Only models whose regions fall within
#'   the given countries are loaded. Region codes embed the country as a
#'   prefix (e.g. `"US-CO"`).
#' @param region An optional character vector of region codes (e.g. `"US-CO"`).
#'   Only models whose regions match are loaded.
#' @return A model_tbl containing the locally installed models that match the
#'   given filters (or all models if no filters are supplied).
#' @export
load_models <- function(model_type = NULL, country = NULL, region = NULL) {
  dist_path <- system.file(
    "models-main/dist",
    package = "allometric"
  )

  if (dist_path == "") {
    stop("No allometric models are installed. Use install_models()")
  }

  model_type <- as_character_or_null(model_type)
  country <- as_character_or_null(country)
  region <- as_character_or_null(region)

  # Reconstructing the ~2400 S4 models takes ~15 s, so cache the result keyed
  # on the parquet content, the package version, and the loader version. Each
  # distinct filter combination is cached separately, so filtered loads are
  # fast on repeat calls too.
  cache_path <- file.path(
    tools::R_user_dir("allometric", "cache"), "model_tbl.rds"
  )
  dist_key <- model_dist_key(dist_path)
  filter_key <- filter_cache_key(model_type, country, region)

  variants <- read_model_cache(cache_path, dist_key)
  if (!is.null(variants) && filter_key %in% names(variants)) {
    return(variants[[filter_key]])
  }

  tables <- read_dist_tables(dist_path)
  joined <- join_model_tables(tables)
  joined <- filter_joined_models(
    joined, model_type = model_type, country = country, region = region
  )
  if (nrow(joined) == 0) {
    warning("No models match the given filters.", call. = FALSE)
  }
  models <- build_model_tbl(joined)

  # Empty results are not cached: they cost nothing to rebuild and it keeps the
  # "no models match" warning informative on every call.
  if (nrow(models) > 0) {
    write_model_cache(cache_path, dist_key, filter_key, models, variants)
  }

  models
}

#' Coerce a filter argument to a character vector, or NULL if empty
#'
#' @keywords internal
as_character_or_null <- function(x) {
  if (is.null(x) || length(x) == 0) {
    return(NULL)
  }
  as.character(x)
}

#' Canonical cache key for a filter combination
#'
#' @keywords internal
filter_cache_key <- function(model_type, country, region) {
  if (is.null(model_type) && is.null(country) && is.null(region)) {
    return("full")
  }
  paste(
    if (is.null(model_type)) "" else paste(sort(model_type), collapse = ","),
    if (is.null(country)) "" else paste(sort(country), collapse = ","),
    if (is.null(region)) "" else paste(sort(region), collapse = ","),
    sep = "|"
  )
}

#' Validate a filter argument against the values present in the data
#'
#' @keywords internal
check_filter_values <- function(value, arg, available) {
  missing <- value[!value %in% available]
  if (length(missing) > 0) {
    opts <- available
    if (length(opts) > 20) {
      opts <- c(utils::head(opts, 20), "...")
    }
    stop(
      arg, " value(s) not found: ", paste(missing, collapse = ", "),
      ". Available: ", paste(opts, collapse = ", "),
      call. = FALSE
    )
  }
  value
}

#' Filter a joined v4 table before model reconstruction
#'
#' Filters are applied on the joined table (before `build_model_tbl`), so only
#' the requested models are ever constructed. `model_type` is derived from the
#' response name via `get_model_type()`; `country` and `region` are matched
#' against the spec-level `spec_region` list column (region codes embed the
#' country as a dash-prefixed code, e.g. `"US-CO"`).
#'
#' @param joined The tibble returned by `join_model_tables()`
#' @return The filtered joined tibble
filter_joined_models <- function(
  joined, model_type = NULL, country = NULL, region = NULL
) {
  # Validate every argument against the full table first, so an earlier filter
  # cannot shrink the candidate set and cause a false "not found" error (e.g.
  # filtering by model_type may leave no rows with a region at all).
  if (!is.null(model_type)) {
    available <- unique(vapply(
      joined$response$name, get_model_type, character(1)
    ))
    model_type <- check_filter_values(model_type, "model_type", available)
  }
  if (!is.null(region)) {
    available <- unique(unlist(joined$spec_region))
    region <- check_filter_values(region, "region", available)
  }
  if (!is.null(country)) {
    available <- unique(sub("-.*", "", unlist(joined$spec_region)))
    country <- check_filter_values(country, "country", available)
  }

  if (!is.null(model_type)) {
    mt <- vapply(joined$response$name, get_model_type, character(1))
    joined <- joined[mt %in% model_type, ]
  }

  if (!is.null(region)) {
    keep <- vapply(joined$spec_region, function(rg) {
      !is.null(rg) && any(rg %in% region)
    }, logical(1))
    joined <- joined[keep, ]
  }

  if (!is.null(country)) {
    keep <- vapply(joined$spec_region, function(rg) {
      if (is.null(rg)) {
        return(FALSE)
      }
      any(sub("-.*", "", rg) %in% country)
    }, logical(1))
    joined <- joined[keep, ]
  }

  joined
}

#' Read the cached model variants for a distribution key
#'
#' The cache file stores a named list of filter keys to `model_tbl`s for one
#' distribution. Legacy files store a single `list(key, models)` for the
#' unfiltered load and are migrated on read.
#'
#' @return A named list of filter key to `model_tbl`, or NULL when no valid
#'   cache exists.
#' @keywords internal
read_model_cache <- function(cache_path, dist_key) {
  if (!file.exists(cache_path)) {
    return(NULL)
  }
  cached <- tryCatch(readRDS(cache_path), error = function(e) NULL)
  if (is.null(cached) || is.null(cached$key) ||
      !identical(cached$key, dist_key)) {
    return(NULL)
  }
  variants <- cached$variants
  if (is.null(variants) && !is.null(cached$models)) {
    variants <- list(full = cached$models)
  }
  variants
}

#' Write one filter variant into the model cache
#'
#' @keywords internal
write_model_cache <- function(
  cache_path, dist_key, filter_key, models, variants
) {
  tryCatch(
    {
      dir.create(dirname(cache_path), recursive = TRUE, showWarnings = FALSE)
      new_variants <- variants
      if (is.null(new_variants)) {
        new_variants <- list()
      }
      new_variants[[filter_key]] <- models
      tmp <- tempfile(tmpdir = dirname(cache_path))
      saveRDS(list(key = dist_key, variants = new_variants), tmp)
      file.rename(tmp, cache_path)
    },
    error = function(e) NULL
  )
}
