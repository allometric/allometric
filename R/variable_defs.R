


prepare_var_defs <- function(var_defs, measure_defs, component_defs) {
  for(i in seq_along(var_defs)) {
    def <- var_defs[[i]]
    name <- names(var_defs)[[i]]
    cols <- colnames(def)
    paste_cols <- cols[cols != "description"]

    prepped_def <- tidyr::unite(def, "search_str", !!!paste_cols, sep="",
      remove=F) %>%
      merge(measure_defs, by = "measure") %>%
      merge(component_defs, by = "component")

    var_defs[[name]] <- prepped_def
  }
  var_defs
}


#' Load the measure definitions
#'
#' Loads the measure definitions from a locally stored csv file
#'
#' @return A tibble::tbl_df containing the measure definitions
#' @examples 
#' get_measure_defs()
#' @export
get_measure_defs <- function() {
  utils::read.csv(
    system.file("variable_defs/measures.csv", package = "allometric")
  )
}

#' Load the component definitions
#'
#' Loads the component definitions from a locally stored csv file
#'
#' @return A tibble::tbl_df containing the component definitions
#' @examples 
#' get_component_defs()
#' @export
get_component_defs <- function() {
  utils::read.csv(
    system.file("variable_defs/components.csv", package = "allometric")
  )
}

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
#' @return A data.frame containing the matched variable definitions.
#' @export
get_variable_def <- function(search_str, return_exact_only = FALSE) {
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
    matched_suffix <- suffixes[suffixes$suffix == parsed_search_str$suffix,]
    matched_measure <- cbind(matched_measure, matched_suffix)
    ending <- paste(ending, matched_suffix$scale_description, "-level", sep = "")
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

  matched_measure <- tibble::tibble(matched_measure) %>%
    dplyr::relocate(description)


  if(return_exact_only) {
    return(matched_measure[matched_measure$search_str == varname,])
  } else {
    return(matched_measure)
  }
}

#' Gets the model type for a response name.
#'
#' From the variable naming system, return the model type. Model types are
#' custom names that are easier to understand than the usual component-measure
#' pairing. For example, site index models would be called "stem height models"
#' hecause the component is the stem and the measure is the height. However,
#' site index models need a special name. Model types are these names. If a
#' model type is not defined, the component-measure pairing is used instead.
#'
#' @param response_name The response_name from the variable naming system.
#' @keywords internal
get_model_type <- function(response_name) {
  # Check if increment model
  # TODO this is not generic to any given prefix, but i_ is the only possible
  # prefix at the moment
  if(startsWith(response_name, "i_")) {
    add <- "increment"
    response_name <- substr(response_name, 3, nchar(response_name))
  } else {
    add <- ""
  }

  # the defined model types are meant to be starting strings only, in some
  # cases they will be exact matches
  matches <- startsWith(response_name, model_types_defined$response_name_start)

  if(all(!matches)) { # no matches
    measure <- substr(response_name, 1, 1)
    component <- substr(response_name, 2, 2)

    measure_name <- measure_defs[measure_defs$measure == measure, "measure_name"]
    component_name <- component_defs[component_defs$component == component, "component_name"]
    model_type <- paste(component_name, measure_name)

  } else { # at least one match, return the exact match if more than one row
    matched <- model_types_defined[matches,]
    if(nrow(matched) == 1) {
      model_type <- matched$model_type
    } else {
      model_type <- matched[matched$response_name_start == response_name, 'model_type']
    }
  }

  model_type <- trimws(paste(model_type, " ", add, sep = ""))
  model_type
}