

#' @export
load_parameter_frame <- function(name) {
  csv_name <- paste(name, ".csv", sep = "")
  file_path <- system.file("parameters", csv_name, package = "allometric")
  table <- utils::read.csv(file_path, na.strings = "")
  tibble::as_tibble(table)
}


#' @export
load_publication <- function(pub_id) {
  # Ensure publication list is up-to-date, for most users this wont matter, but
  # during model installation it will be helpful to regenerate this if changes
  # occurred during the session
  get_pub_list()
  pub_list <- readRDS(system.file('extdata/pub_list.RDS', package = 'allometric'))
  pub_list[[pub_id]]
}

#' A table of installed allometric models
#'
#' `allometric_models`is a `model_tbl` containing every installed
#' allometric model in `allometric`. It is available globally on package load.
#' If not, run the `install_models` function which will install the models and
#' expose the `allometric_models` table in your session. This table behaves
#' very much like a `tibble::tbl_df` or a `data.frame``, and most functions that
#' work on these will work on `allometric_models` as well.
#'
#' Printing the `head` of `allometric_models`, we can see the structure of the
#' data
#'
#' ```{r include=FALSE}
#' ```
#'
#' ```{r}
#' options(width=10000)
#' head(allometric_models)
#' ```
#'
#' The columns are:
#' * `id` - A unique ID for the model.
#' * `component` - The component of the tree that is modeled.
#' * `measure` - The measure of the component that is modeled.
#' * `country` - The country or countries from which the model data is from.
#' * `region` - The region (e.g., state, province, etc.) from which the model
#'   data is from.
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
#' `family_name`
#'
#' # Advanced Searching for Models
#' 
#' This table is composed primarily of
#' [nested data](https://tidyr.tidyverse.org/articles/nest.html), referred to
#' as `list` columns. Nested data, while somewhat cumbersome for users that are
#' not experienced with it, is necessary for accommodating the flexible nature
#' of published allometric models. An obvious motivation is that a given model
#' contains multiple authors, covariates, even multiple regions or countries.
#' Nested data allows for the storage of these highly variable structures for
#' each model.
#' 
#'
#' @name allometric_models
NULL