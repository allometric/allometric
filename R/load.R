#' Load a parameter frame from the models/parameters directory
#'
#' This is a convenience that allows a user to easily load parameter files from
#' the models/parameters directory. It is typically used when constructing
#' the `model_specifications` argument for `ModelSet`.
#'
#' @param name The name of the file, excluding the extension
#' @return A tibble::tbl_df of the parameter data.
#' @export
load_parameter_frame <- function(name) {
  csv_name <- paste(name, ".csv", sep = "")

  file_path <- system.file(
    "models/parameters", csv_name,
    package = "allometric"
  )

  table <- utils::read.csv(file_path, na.strings = "")
  tibble::as_tibble(table)
}

#' A table of installed allometric models
#'
#' `allometric_models` is a `model_tbl` containing every installed
#' allometric model in `allometric`. It is available globally on package load.
#' If not, run the `install_models` function which will install the models and
#' expose the `allometric_models` table in your session. This table behaves
#' very much like a `tibble::tbl_df` or a `data.frame`, and most functions that
#' work on these will work on `allometric_models` as well.
#'
#' Printing the `head` of `allometric_models`, we can see the structure of the
#' data
#'
#' ```{r}
#' head(allometric_models)
#' ```
#'
#' The columns are:
#' * `id` - A unique ID for the model.
#' * `model_type` - The type of model (e.g., stem volume, site index, etc.)
#' * `country` - The country or countries from which the model data is from.
#' * `region` - The region or regions (e.g., state, province, etc.) from which
#' the model data is from.
#' * `family`, `genus`, `species` - The taxonomic specification of the trees
#'   that are modeled.
#' * `model` - The model object itself.
#' * `pub_id` - A unique ID representing the publication.
#' * `family_name` - The names of the contributing authors.
#' * `covt_name` - The names of the covariates used in the model.
#' * `pub_year` - The publication year.
#'
#' # Basic Searching for Models
#'
#' Filtering out nested data from a table is slightly more involved than
#' strictly tabular data. Fortunately the `unnest_models` function allows the
#' user to unnest any set of columns. For example, let's say we wanted to find
#' a model from the author `"Hann"`. To do this, we will unnest the
#' `family_name` column using `unnest_models`, then filter the resulting
#' dataframe using `dplyr::filter`.
#'
#' ```{r}
#' unnest_family <- allometric_models %>% unnest_models('family_name')
#'
#' unnest_family %>% dplyr::filter(family_name == "Hann")
#' ```
#'
#' Any column or any combination of columns can be unnested, which allows for
#' basic filtering of models using `dplyr::filter`.
#'
#' # Advanced Searching for Models
#'
#' Nested data can be searched directly without the use of `unnest_models`.
#' This requires the use of `purrr::map_lgl` which is used to determine
#' truthiness of expressions for each element in a `list` column.
#' Before beginning, it is helpful to know that `purrr::map_lgl` returns a list
#' of TRUE/FALSE values as it "maps" over a list of input.
#'
#' ## Finding Contributing Authors
#'
#' Using this function, we can recreate the previous example, finding models
#' that had `'Hann'` as a contributing author.
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
#' ## Finding First Authors
#'
#' Maybe we are only interested in models where `'Hann'` is the first author. Using
#' a simple modification we can easily do this.
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
#' ## Finding a Model with Specific Data Requirements
#'
#' We can even check for models that contain certain types of data requirements.
#' For example, the following block finds diameter-height models, specifically
#' models that use diameter outside bark at breast height as the *only* covariate.
#' The utility here is obvious, since many inventories are vastly limited by their
#' available tree measurements.
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
#' Breaking this down, we have the first condition `model_type=='stem_height'` selecting
#' only models concerned with stem heights as a response variable. The second line
#' maps over each element of the `covt_name` column, which is a character vector.
#' The `.` represents a given character vector for that row. First, we ensure that
#' the vector is only one element in size using `length(.)==1`, then we ensure that
#' the first (and only) element of this vector is equal to `'dsob'`, (diameter
#' outside bark at breast height). In this case, `r nrow(dia_ht_models)` are
#' available in the package.
#'
#' ## Finding a Model for a Region
#'
#' By now the user should be sensing a pattern. We can apply the exact same logic
#' as the *Finding Contributing Authors* section to find all models developed using
#' data from `US-OR`
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
#' @name allometric_models
NULL
