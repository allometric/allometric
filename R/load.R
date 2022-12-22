

#' @export
load_parameter_frame <- function(name) {
    csv_name <- paste(name, '.csv', sep='')
    file_path <- system.file('parameters', csv_name, package = 'allometric')
    read.csv(file_path)
}