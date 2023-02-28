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

prefixes = utils::read.csv(system.file("variable_defs/prefix.csv", package = "allometric"))
suffixes = utils::read.csv(system.file("variable_defs/suffix.csv", package = "allometric"))


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

get_before_first_underscore <- function(str) {
  match <- regexpr("^[^_]+", str, perl=TRUE)
  substring(str, match, match + attr(match, "match.length") - 1)
}

get_after_last_underscore <- function(str) {
  match <- regexpr("[^_]+$", str, perl=TRUE)
  substring(str, match, match + attr(match, "match.length") - 1)
}

get_between <- function(str) {
  gsub("^[^_]*_+(.*?)_+[^_]*$", "\\1", str)
}

#' Check if the search string is valid
#'
#' Search strings can have prefixes and suffixes, but these must only be one
#' character.
#' 
#' @keywords internal
check_valid_search_str <- function(num_underscores) {
  if(num_underscores > 2) {
    stop("Invalid search string, more than two underscores are present.")
  }

}

parse_search_str <- function(search_str, num_underscores) {
  before <- get_before_first_underscore(search_str)
  after <- get_after_last_underscore(search_str)

  if(num_underscores == 2) {
    prefix <- before
    varname <- get_between(search_str)
    suffix <- after
    parsed <- list(prefix = prefix, varname = varname, suffix = suffix)
  } else if(num_underscores == 1) {
    if(nchar(before) > 1)  {
      varname <- before
      suffix <- after
      parsed <- list(varname = varname, suffix = suffix)
    } else {
      prefix <- before
      varname <- after
      parsed <- list(prefix = prefix, varname = varname)
    }
  } else {
    varname <- search_str
    parsed <- list(varname = varname)
  }

  parsed
}

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
  num_underscores <- stringr::str_count(search_str, "_")
  check_valid_search_str(num_underscores)

  parsed_search_str <- parse_search_str(search_str, num_underscores)
  varname <- parsed_search_str$varname

  measure <- substr(varname, 1, 1)

  if(!measure %in% names(var_defs)) {
    stop(paste("measure:", measure, "is not defined"))
  }

  matched_measure <- var_defs[[measure]]
  matches <- startsWith(matched_measure$search_str, varname)
  matched_measure <- matched_measure[matches,]

  if(sum(matches) == 0) {
    warning("No variable definition found for: ", varname)
  }

  ending <- "("

  if("suffix" %in% names(parsed_search_str)) {
    matched_suffix <- suffixes[suffixes$suffix==parsed_search_str$suffix,]
    matched_measure <- cbind(matched_measure, matched_suffix)
    ending <- paste(ending, matched_suffix$scale_description, "-level", sep="")
  } else {
    # No match, this means by default the suffix indicates a tree scale
    tree_prefix <- data.frame(suffix = "t", scale_description = "tree")
    matched_measure <- cbind(matched_measure, tree_prefix)
  }

  if("prefix" %in% names(parsed_search_str)) {
    matched_prefix <- prefixes[prefixes$prefix==parsed_search_str$prefix,]
    matched_measure <- cbind(matched_measure, matched_prefix)

    if(endsWith(ending, "(")) {
      ending <- paste(ending, matched_prefix$prefix_description, sep="")
    } else {
      ending <- paste(ending, matched_prefix$prefix_description)
    }
  }

  if(ending != "(") {
    ending <- paste(ending, ")", sep="")
    matched_measure$description <- paste(matched_measure$description, " ", ending, sep="")
  }


  if(return_exact_only) {
    return(matched_measure[matched_measure$search_str == varname,])
  } else {
    return(matched_measure)
  }
}