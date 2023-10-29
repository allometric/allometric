# For class definition of Taxon see Taxa.R (did this to resolve a collating
# issue)

# This function returns TRUE wherever elements are the same, including NA's,
# and FALSE everywhere else.
compareNA <- function(v1, v2) {
    same <- (v1 == v2) | (is.na(v1) & is.na(v2))
    same[is.na(same)] <- FALSE
    return(same)
}

setMethod("unlist", signature(x = "Taxon"),
  function(x) {
    c(x@family, x@genus, x@species)
  }
)

#' Check equivalence of two `Taxon` objects
#'
#' Two Taxons are equal if all values are the same (including NA values)
#'
#' @param e1 A `Taxon` object
#' @param e1 A `Taxon` object
#' @return TRUE or FALSE
#' @export
#' @keywords internal
setMethod("==", signature(e1 = "Taxon", e2 = "Taxon"),
  function(e1, e2) {
    # All fields in e1 e2 are NA_character_
    e1_vals <- c(e1@family, e1@genus, e1@species)
    e2_vals <- c(e2@family, e2@genus, e2@species)

    all(compareNA(e1_vals, e2_vals))
})

#' Check if a Taxon is in a Taxa
#'
#' @param x A `Taxon` object
#' @param table A `Taxa` object
#' @return TRUE or FALSE indicating if the Taxon is in the Taxa
#' @export
#' @keywords internal
setMethod("%in%", signature(x = "Taxon", table = "Taxa"),
  function(x, table) {
    for(taxon in table) {
      if(x == taxon) {
        return(TRUE)
      }
    }

    return(FALSE)
  }
)

#' Check if a character is in a Taxon
#'
#' @param x A character vector
#' @param table A `Taxon` object
#' @return TRUE or FALSE indicating if the character appears in the Taxon fields
#' @export
#' @keywords internal
setMethod("%in%", signature(x = "character", table = "Taxon"),
  function(x, table) {
    vals <- unlist(table)
    x %in% vals
  }
)

#' Check if a Taxon contains a character
#'
#' @param x A `Taxon` object
#' @param table A character vector
#' @return TRUE or FALSE indicating if any of the Taxa fields appear in the
#' character.
#' @export
setMethod("%in%", signature(x = "Taxon", table = "character"),
  function(x, table) {
    vals <- unlist(x)
    vals %in% table
  }
)