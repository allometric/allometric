---
title: "Check equivalence of mixed effects models"
description: "Fixed effects models are considered equal if all of the following are true: The model IDs are equal (or not present) The response unit names and units are the same The covariate names and units are the same and are in the same order The specification names and values are the same The predict_fn are the same The predict_ranef are the same The fixed_only slots are the same The response definitions are the same The covariate definitions are the same"
---

Fixed effects models are considered equal if all of the following are true:

- The model IDs are equal (or not present)
- The response unit names and units are the same
- The covariate names and units are the same and are in the same order
- The specification names and values are the same
- The predict_fn are the same
- The predict_ranef are the same
- The fixed_only slots are the same
- The response definitions are the same
- The covariate definitions are the same

## Usage

```r

## S4 method for signature 'MixedEffectsModel,MixedEffectsModel':
==(e1, e2)
```

## Arguments

- **e1** — A `MixedEffectsModel` object

- **e2** — A `MixedEffectsModel` object

