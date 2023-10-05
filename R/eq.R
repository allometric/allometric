#' Check for equivalence of ID slots in two models
#'
#' Two models are considered to have equal IDs if (1) they both do not have ID
#' slots, which can occur especially in testing, or (2) both models have ID
#' slots and the value of the slots are equal. They are not equal otherwise.
#'
#' @param mod1 A model object
#' @param mod2 A model object
#' @return TRUE if equal, FALSE if not
#' @keywords internal
check_ids_equal <- function(mod1, mod2) {
  slot_names_1 <- methods::slotNames(mod1)
  slot_names_2 <- methods::slotNames(mod2)

  if(!("id" %in% slot_names_1 && "id" %in% slot_names_2)) {
    # Neither contain an id slot
    return(TRUE)
  } else if ("id" %in% slot_names_1 && "id" %in% slot_names_2) {
    # Both contain id slot
    if(mod1@id == mod2@id) {
      return(TRUE)
    } else {
      return(FALSE)
    }
  } else {
    # One contains id slot but the other does not
    return(FALSE)
  }
}

#' Check for equivalence of response slots in two models
#'
#' The response slots are considered equal if the names match and the units
#' match. Units are first parsed to strings and then checked for equivalence
#'
#' @inheritParams check_ids_equal
#' @keywords internal
check_response_equal <- function(mod1, mod2) {
  res_name_1 <- names(mod1@response_unit)[[1]]
  res_name_2 <- names(mod2@response_unit)[[1]]

  units_1 <- parse_unit_str(mod1@response_unit)
  units_2 <- parse_unit_str(mod2@response_unit)

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
  p1 <- length(mod1@covariate_units)
  p2 <- length(mod2@covariate_units)

  if(p1 != p2) {return (FALSE)}
  if(!identical(mod1@covariate_units, mod1@covariate_units)) {return (FALSE)}

  units_1 <- c()
  units_2 <- c()
  for(i in 1:p1) {units_1 <- c(units_1, mod1@covariate_units[i])}
  for(i in 1:p2) {units_2 <- c(units_2, mod2@covariate_units[i])}

  if(!identical(units_1, units_2)) {
    return (FALSE)
  } else {
    return (TRUE)
  }
}

#' Check for equivalence of two lists
#'
#' Two lists are considered equal if all values are the same and all names are
#' the same. Order is not considered.
#'
#' @inheritParams check_ids_equal
#' @keywords internal
check_list_equal <- function(list1, list2) {
  names_1 <- names(list1)
  names_2 <- names(list2)

  if (!setequal(names_1, names_2)) {return(FALSE)}
  if (!setequal(list1, list2)) {
    return(FALSE)
  } else{
    return(TRUE)
  }
}

#' Check for equivalence of two rediction functions
#'
#' The prediction functions are considered equal if the arguments and body are
#' identical using `all.equal()`
#'
#' @param predict_fn_1 A prediction function
#' @param predict_fn_1 A prediction function to compare to
#' @keywords internal
check_predict_fn_equal <- function(predict_fn_1, predict_fn_2) {
  args_same <- all.equal(args(predict_fn_1), args(predict_fn_2))
  body_same <- all.equal(body(predict_fn_1), body(predict_fn_2))

  if(all(args_same, body_same)) {
    return(TRUE)
  } else {
    return(FALSE)
  }
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

  if(is.na(rd1) && is.na(rd2)) {
    return(TRUE)
  } else if(is.na(rd1) || is.na(rd2)) {
    return(FALSE)
  } else {
    return(mod1@response_definition != mod2@response_definition)
  }
}