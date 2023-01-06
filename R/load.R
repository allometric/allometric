

#' @export
load_parameter_frame <- function(name) {
  csv_name <- paste(name, ".csv", sep = "")
  file_path <- system.file("parameters", csv_name, package = "allometric")
  utils::read.csv(file_path, na.strings = "")
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
#' `allometric_models`is a `tibble::tbl_df` containing every installed
#' allometric model in `allometric`. It is available globally on package load.
#' If not, run the `install_models` function which will install the models and
#' expose the `allometric_models` table in your session.
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
#' @name allometric_models
NULL