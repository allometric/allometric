---
title: "Add a set of models to a publication"
description: "This function adds objects of class `FixedEffectsSet` or `MixedEffectsSet` to a publication."
---

This function adds objects of class `FixedEffectsSet` or `MixedEffectsSet` to a publication. This operation is not done in-place.

## Usage

```r

add_set(publication, model_set)

## S4 method for signature 'Publication':
add_set(publication, model_set)
```

## Arguments

- **publication** — The publication for which a set will be added

- **model_set** — The set of models to add to the publication

## Value

A publication with the added set

