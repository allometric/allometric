---
title: "Create a taxonomic hierarchy"
description: "`Taxon` represents a taxonomic hierarchy (from family through species)."
---

`Taxon` represents a taxonomic hierarchy (from family through species). This class represents a number of validity checks to ensure the taxon is correctly structured. A taxon must have at least a family specified, and neither genus nor species can be specified without the "shallower" layers of the hierarchy specified first. Group `Taxon` s together with `Taxa()`.

## Usage

```r

Taxon(family = NA_character_, genus = NA_character_, species = NA_character_)
```

## Arguments

- **family** — The taxonomic family

- **genus** — The taxonomic genus

- **species** — The taxonomic species

## Value

An instance of class `Taxon`

## Examples

```r

Taxon(
  family = "Pinaceae",
  genus = "Pinus",
  species = "ponderosa"
)

Taxon(
  family = "Betulaceae"
)
```

