---
title: "Group taxons together"
description: "`Taxa` represents a set of taxons."
---

`Taxa` represents a set of taxons. See `Taxon()`. These are typically used to specify species and other taxonomic groups that belong to a model.

## Usage

```r

Taxa(...)
```

## Arguments

- **...** — A set of `Taxon` objects.

## Value

An instance of class `Taxa`

## Examples

```r

Taxa(
   Taxon(
      family = "Pinaceae",
      genus = "Pinus",
      species = "ponderosa"
   ),
   Taxon(
     family = "Betulaceae"
   )
)
```

