.Taxon <- setClass("Taxon",
  slots = c(
    family = "character",
    genus = "character",
    species = "character"
  ),
  validity = check_taxon_hierarchy
)

#' Create a taxonomic hierarchy
#'
#' `Taxon` represents a taxonomic hierarchy (from family through species). This
#' class represents a number of validity checks to ensure the taxon is correctly
#' structured. A taxon must have at least a family specified, and neither genus
#' nor species can be specified without the "shallower" layers of the hierarchy
#' specified first. Group `Taxon`s together with `Taxa()`.
#'
#' @param family The taxonomic family
#' @param genus The taxonomic genus
#' @param species The taxonomic species
#' @return An instance of class `Taxon`
#' @examples
#' Taxon(
#'   family = "Pinaceae",
#'   genus = "Pinus",
#'   species = "ponderosa"
#' )
#'
#' Taxon(
#'   family = "Betulaceae"
#' )
#' @export
Taxon <- function(family = NA_character_, genus = NA_character_,
    species = NA_character_) {
  if(is.na(genus)) {
    genus <- NA_character_
  }

  if(is.na(species)) {
    species <- NA_character_
  }

  taxon <- .Taxon(family = family, genus = genus, species = species)
  taxon
}

.Taxa <- setClass("Taxa",
  contains = "list",
  validity = check_taxa_unique
)

#' Group taxons together
#'
#' `Taxa` represents a set of taxons. See `Taxon()`. These are typically used
#' to specify species and other taxonomic groups that belong to a model.
#'
#' @param ... A set of `Taxon` objects.
#' @return An instance of class `Taxa`
#' @examples
#' Taxa(
#'    Taxon(
#'       family = "Pinaceae",
#'       genus = "Pinus",
#'       species = "ponderosa"
#'    ),
#'    Taxon(
#'      family = "Betulaceae"
#'    )
#' )
#' @export
Taxa <- function(...) {
  taxa <- .Taxa(.Data = list(...))
  taxa
}

#' Check if a character is in a Taxa
#'
#' @param x A character vector
#' @param table A `Taxa` object
#' @return TRUE or FALSE indicating if the character appears in the Taxa fields
#' @export
#' @keywords internal
setMethod("%in%", signature(x = "character", table = "Taxa"),
  function(x, table) {
    vals <- unlist(lapply(table, unlist))
    x %in% vals
  }
)

#' Check if a Taxa contains a character
#'
#' @param x A `Taxa` object
#' @param table A character vector
#' @return TRUE or FALSE indicating if any of the Taxa fields appear in the
#' character.
#' @export
#' @keywords internal
setMethod("%in%", signature(x = "Taxa", table = "character"),
  function(x, table) {
    vals <- lapply(x, unlist)
    sapply(vals, function(val) table %in% val)
  }
)

#' Check if a Taxa is in Taxon
#'
#' @param x A `Taxa` object
#' @param table A `Taxon` object
#' @return A logical vector indicating which elements of `Taxa` are equal to
#' the `Taxon`
#' @export
#' @keywords internal
setMethod("%in%", signature(x = "Taxa", table = "Taxon"),
  function(x, table) {
    out <- c()
    for (taxon in x) {
      if (taxon == table) {
        out <- c(out, TRUE)
      } else {
        out <- c(out, FALSE)
      }
    }

    out
  }
)
