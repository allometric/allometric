model_data <- system.file('model_data', package='allometric')


new_dplyr_quosure <- function(quo, ...) {
  attr(quo, "dplyr:::data") <- list2(...)
  quo
}

dplyr_quosures <- function(...) {
  # We're using quos() instead of enquos() here for speed, because we're not defusing named arguments --
  # only the ellipsis is converted to quosures, there are no further arguments.
  quosures <- quos(..., .ignore_empty = "all")
  names_given <- names2(quosures)

  for (i in seq_along(quosures)) {
    quosure <- quosures[[i]]
    name_given <- names_given[[i]]
    is_named <- (name_given != "")
    if (is_named) {
      name_auto <- name_given
    } else {
      name_auto <- rlang::as_label(quosure)
    }

    quosures[[i]] <- new_dplyr_quosure(quosure,
      name_given = name_given,
      name_auto = name_auto,
      is_named = is_named,
      index = i
    )
  }
  quosures
}

#' @export
model_search <- function(...) {

}

#model_search(genus == 'Pseudotsuga', species == 'menziesii')

#rlang::quosur

#dplyr::quo