.Taxon <- setClass("Taxon",
  slots = c(
    family = "character",
    genus = "character",
    species = "character"
  ),
  validity = check_taxon_hierarchy
)

Taxon <- function(family = NA_character_, genus = NA_character_, species = NA_character_) {
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
  contains = "list"
)

Taxa <- function(...) {
  taxa <- .Taxa(.Data = list(...))
  taxa
}

setMethod("%in%", signature(x = "character", table = "Taxa"),
  function(x, table) {
    vals <- unlist(lapply(table, unlist))
    x %in% vals
  }
)

setMethod("%in%", signature(x = "Taxa", table = "character"),
  function(x, table) {
    vals <- unlist(lapply(x, unlist))
    vals %in% table
  }
)

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

