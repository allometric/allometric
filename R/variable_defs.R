#' @export
component_defs <- utils::read.csv(system.file("variable_defs/components.csv", package = "allometric"))

#' @export
measure_defs <- utils::read.csv(system.file("variable_defs/measures.csv", package = "allometric"))

var_defs.pre <- list(
  d = utils::read.csv(system.file("variable_defs/d.csv", package = "allometric")),
  v = utils::read.csv(system.file("variable_defs/v.csv", package = "allometric")),
  h = utils::read.csv(system.file("variable_defs/h.csv", package = "allometric")),
  b = utils::read.csv(system.file("variable_defs/b.csv", package = "allometric")),
  e = utils::read.csv(system.file("variable_defs/e.csv", package = "allometric")),
  r = utils::read.csv(system.file("variable_defs/r.csv", package = "allometric")),
  a = utils::read.csv(system.file("variable_defs/a.csv", package = "allometric")),
  g = utils::read.csv(system.file("variable_defs/g.csv", package = "allometric"))
)


# TODO best to move this to .onLoad?
prepare_var_defs <- function(var_defs) {
  for(i in seq_along(var_defs)) {
    def <- var_defs[[i]]
    name <- names(var_defs)[[i]]
    cols <- colnames(def)
    paste_cols <- cols[cols != "description"]

    prepped_def <- tidyr::unite(def, "search_str", !!!paste_cols, sep="",
      remove=F) %>%
      merge(measure_defs, by="measure") %>%
      merge(component_defs, by="component")

    var_defs[[name]] <- prepped_def
  }
  var_defs
}

var_defs <- prepare_var_defs(var_defs.pre)

#' Get the definition of a variable in the variable naming system.
#'
#' When possible, variables are given standard names using the variable naming
#' system. The definitions for a variable can be found using this function.
#' The `search_str` argument works using partial matching of the beginning of
#' each variable name. For example input `"d"` will return all diameter
#' definitions but input `"dsob"` will only return the definition for diameter
#' outside bark at breast height.
#'
#' @param search_str The string to search with.
#' @param return_exact_only Some variables are completely defined but will
#' return "addditional" matches. For example, "hst" refers to the total height
#' of a tree, but "hstix" refers to a site index. If this argument is false, all
#' strings starting with "hst" will be returned. If true, then only "hst" will
#' be returned.
#' @export
#' @keywords internal
get_variable_def <- function(search_str, return_exact_only=FALSE) {
  measure <- substr(search_str, 1, 1)

  if(!measure %in% names(var_defs)) {
    stop(paste("measure:", measure, "is not defined"))
  }

  matched_measure <- var_defs[[measure]]
  matches <- startsWith(matched_measure$search_str, search_str)
  matched_measure <- matched_measure[matches,]

  if(sum(matches) == 0) {
    warning("No variable definition found for: ", search_str)
  }

  if(return_exact_only) {
    return(matched_measure[matched_measure$search_str == search_str,])
  } else {
    return(matched_measure)
  }
}