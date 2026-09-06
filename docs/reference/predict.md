---
title: "Predict with an allometric model"
description: "Predict with an allometric model"
---

Predict with an allometric model

## Usage

```r

predict(model, ...)

## S4 method for signature 'FixedEffectsModel':
predict(model, ..., output_units = NULL)

## S4 method for signature 'MixedEffectsModel':
predict(model, ..., newdata = NULL, output_units = NULL)
```

## Arguments

- **model** — The allometric model used for prediction

- **...** — Additional arguments passed to the `predict_fn` of the input model

- **output_units** — Optionally specify the output units of the model as a string, e.g., "ft^3". The provided string must be compatible with the `units::set_units()` function.

- **newdata** — A dataframe containing columns that match the names of the arguments given to `predict_ranef`. The values of this data represents information from a new group of observations for which predictions are desired (e.g., a new stand or plot).

## Value

A vector of allometric model predictions

## Examples

```r

predict(brackett_rubra, 10, 50)
predict(brackett_rubra, 10, 50, output_units = "m^3")
```

