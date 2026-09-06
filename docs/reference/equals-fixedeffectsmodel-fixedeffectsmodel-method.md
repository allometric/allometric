---
title: "Check equivalence of fixed effects models"
description: "Fixed effects models are considered equal if all of the following are true: The model IDs are equal (or not present) The response unit names and units are the same The covariate names and units are the same and are in the same order The specification names and values are the same The predict_fn is the same The response definitions are the same The covariate definitions are the same"
---

Fixed effects models are considered equal if all of the following are true:

- The model IDs are equal (or not present)
- The response unit names and units are the same
- The covariate names and units are the same and are in the same order
- The specification names and values are the same
- The predict_fn is the same
- The response definitions are the same
- The covariate definitions are the same

## Usage

```r

## S4 method for signature 'FixedEffectsModel,FixedEffectsModel':
==(e1, e2)
```

## Arguments

- **e1** — A `FixedEffectsModel` object

- **e2** — A `FixedEffectsModel` object

