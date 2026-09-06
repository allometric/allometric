---
title: "Add a model to a publication"
description: "This function adds objects of class `FixedEffectsModel` or `MixedEffectsModel` to a publication."
---

This function adds objects of class `FixedEffectsModel` or `MixedEffectsModel` to a publication. Models added in this way are added as a set containing only one model. This operation is not done in-place.

## Usage

```r

add_model(publication, model)
```

## Arguments

- **publication** — The publication for which a set will be added

- **model** — The model to add to the publication

## Value

A publication with the added model

