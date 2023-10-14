.Taxon <- setClass("Taxon",
  slots = c(
    family = "character",
    genus = "character",
    species = "character"
  ),
  validity = check_taxon_hierarchy
)

Taxon <- function(family = NA_character_, genus = NA_character_, species = NA_character_) {
  if(is.na(family)) {
    family <- NA_character_
  }

  if(is.na(genus)) {
    genus <- NA_character_
  }

  if(is.na(species)) {
    species <- NA_character_
  }

  taxon <- .Taxon(family = family, genus = genus, species = species)
  taxon
}

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

setMethod("==", signature(e1 = "Taxon", e2 = "Taxon"),
  function(e1, e2) {
    # All fields in e1 e2 are NA_character_
    e1_vals <- c(e1@family, e1@genus, e1@species)
    e2_vals <- c(e2@family, e2@genus, e2@species)

    all(compareNA(e1_vals, e2_vals))
})

setMethod("%in%", signature(x = "Taxon", table = "list"),
  function(x, table) {
    for(taxon in table) {
      if(x == taxon) {
        return(TRUE)
      }
    }

    return(FALSE)
  }
)

setMethod("%in%", signature(x = "list", table = "Taxon"),
  function(x, table) {
    out <- c()
    for(taxon in x) {
      if(taxon == x) {
        out <- c(out, TRUE)
      } else {
        out <- c(out, FALSE)
      }
    }

    out
  }
)

setMethod("%in%", signature(x = "character", table = "Taxon"),
  function(x, table) {
    vals <- unlist(table)
    x %in% vals
  }
)

setMethod("%in%", signature(x = "Taxon", table = "character"),
  function(x, table) {
    vals <- unlist(x)
    vals %in% table
  }
)