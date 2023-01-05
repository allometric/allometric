

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