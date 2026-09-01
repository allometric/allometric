#' Check for equivalence of ID slots in two models
#'
#' Two models are considered to have equal IDs if both IDs are unset (NA), or
#' both IDs are set and equal. They are not equal if one is set and the other
#' is not, or if both are set and differ.
#'
#' @param mod1 A model object
#' @param mod2 A model object
#' @return TRUE if equal, FALSE if not
#' @keywords internal
check_ids_equal <- function(mod1, mod2) {
  id1 <- mod1@id
  id2 <- mod2@id

  if (is.na(id1) && is.na(id2)) {
    return(TRUE)
  }
  if (is.na(id1) || is.na(id2)) {
    return(FALSE)
  }
  id1 == id2
}

#' Check for equivalence of response slots in two models
#'
#' The response slots are considered equal if the names match and the units
#' match. Units are first parsed to strings and then checked for equivalence
#'
#' @inheritParams check_ids_equal
#' @keywords internal
check_response_equal <- function(mod1, mod2) {
  res_name_1 <- names(mod1@response)[[1]]
  res_name_2 <- names(mod2@response)[[1]]

  units_1 <- parse_unit_str(mod1@response)
  units_2 <- parse_unit_str(mod2@response)

  names_equal <- res_name_1 == res_name_2
  units_equal <- units_1 == units_2

  return(all(names_equal, units_equal))
}

#' Check for equivalence of covariate slots in two models
#'
#' The covariate slots are considered equal if they contain the same number of
#' covariates, the names match, the units match, and the covariates are in the
#' same order.
#'
#' @inheritParams check_ids_equal
#' @keywords internal
check_covariates_equal <- function(mod1, mod2) {
  if (length(mod1@covariates) != length(mod2@covariates)) {
    return(FALSE)
  }

  # Names, order, and units must all match. Units are compared as strings so
  # the check does not depend on object identity or attribute leakage.
  if (!identical(names(mod1@covariates), names(mod2@covariates))) {
    return(FALSE)
  }

  identical(covariate_unit_strs(mod1@covariates), covariate_unit_strs(mod2@covariates))
}

#' Units of a covariate list, as strings ("" for unitless)
#'
#' @keywords internal
covariate_unit_strs <- function(covariates) {
  vapply(covariates, function(u) {
    if (inherits(u, "symbolic_units")) "" else units::deparse_unit(u)
  }, character(1))
}

#' Check for equivalence of two lists
#'
#' Two lists are considered equal if all values are the same and all names are
#' the same. Order is not considered.
#'
#' @inheritParams check_ids_equal
#' @keywords internal
check_list_equal <- function(list1, list2) {
  # Names must match as a set (order ignored), but each value is matched by
  # name: setequal on values alone would treat list(a = 1, b = 2) as equal to
  # list(a = 2, b = 1), decoupling names from values.
  if (!setequal(names(list1), names(list2))) {
    return(FALSE)
  }

  all(vapply(
    names(list1),
    function(n) identical(list1[[n]], list2[[n]]),
    logical(1)
  ))
}

#' Check for equivalence of two prediction functions
#'
#' The prediction functions are considered equal if the arguments and body are
#' identical using `all.equal()`
#'
#' @param predict_fn_1 A prediction function
#' @param predict_fn_2 A prediction function to compare to
#' @keywords internal
check_predict_fn_equal <- function(predict_fn_1, predict_fn_2) {
  args_same <- isTRUE(all.equal(args(predict_fn_1), args(predict_fn_2)))
  body_same <- isTRUE(all.equal(body(predict_fn_1), body(predict_fn_2)))

  args_same && body_same
}

#' Check for equivalence of the response definition
#'
#' The response definitions are strings or NA. If both are NA, they are
#' considered equal, otherwise the strings are checked for equivalence.
#'
#' @inheritParams check_ids_equal
#' @keywords internal
check_res_def_equal <- function(mod1, mod2) {
  rd1 <- mod1@response_definition
  rd2 <- mod2@response_definition

  if (is.na(rd1) && is.na(rd2)) {
    return(TRUE)
  }
  if (is.na(rd1) || is.na(rd2)) {
    return(FALSE)
  }
  rd1 == rd2
}