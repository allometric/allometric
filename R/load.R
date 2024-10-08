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

#' Load a locally installed table of allometric models
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
#' * `id` - A unique ID for the model.
#' * `model_type` - The type of model (e.g., stem volume, site index, etc.)
#' * `country` - The country or countries from which the model data is from.
#' * `region` - The region or regions (e.g., state, province, etc.) from which
#' the model data is from.
#' * `taxa` - The taxonomic specification of the trees that are modeled.
#' * `model` - The model object itself.
#' * `pub_id` - A unique ID representing the publication.
#' * `family_name` - The names of the contributing authors.
#' * `covt_name` - The names of the covariates used in the model.
#' * `pub_year` - The publication year.
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
#' developed using data from `US-OR`
#'
#' ```{r}
#' us_or_models <- dplyr::filter(
#'     allometric_models,
#'     purrr::map_lgl(region, ~ "US-OR" %in% .),
#' )
#'
#' nrow(us_or_models)
#' ```
#'
#' We can see that `r nrow(us_or_models)` allometric models are defined for the
#' state of Oregon, US.
#'
#' @return A model_tbl containing the locally installed models.
#' @export
load_models <- function() {
  rds_path <- system.file(
    "models-main/models.RDS",
    package = "allometric"
  )

  if (!rds_path == "") {
    allometric_models <- readRDS(rds_path)
    allometric_models <- tibble::tibble(allometric_models) %>%
      new_model_tbl()

    return(allometric_models)
  } else {
    stop("No allometric models are installed. Use install_models()")
  }
}