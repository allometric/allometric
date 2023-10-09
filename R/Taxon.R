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