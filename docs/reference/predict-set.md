---
title: "Predict with a set of allometric models"
description: "`predict` accepts a list of models (for example, a list-column in a data frame) and applies each model to the covariate values for its row."
---

`predict` accepts a list of models (for example, a list-column in a data frame) and applies each model to the covariate values for its row. This makes it straightforward to predict with many models in a single `dplyr::mutate()` call:

## Usage

```r

## S4 method for signature 'list':
predict(model, ..., output_units = NULL)

## S4 method for signature 'model_tbl':
predict(model, ...)
```

## Arguments

- **model** — A list of allometric models, or a `model_tbl` with one model per row

- **...** — Covariate values passed to each model's `predict_fn`. Named arguments are matched to models by covariate name; unnamed arguments are matched positionally

- **output_units** — Optionally specify the output units of the predictions as a string, e.g., `"ft^3"`

## Value

A vector of predictions. When models have units, the result carries the response units of the first model (converting the others as needed); pass `output_units` to convert explicitly.

## Details

```r
data |>
  dplyr::left_join(my_models, by = "SPCD") |>
  dplyr::mutate(vol = predict(model, dsob = DIA * 2.54, hst = HT * 0.3048))
```

Covariate arguments may be unnamed, in which case they are matched positionally to each model's covariates and all models must share the same functional form. Alternatively, arguments may be named by covariate, in which case each model is matched by name and only the covariates it requires are used; models whose covariates are not all supplied produce `NA` with a warning. This allows sets of models with different functional forms and covariate orders to be predicted in a single call.

Each covariate argument must be length 1 or the number of models, and is recycled as necessary. Rows where the model is `NA` (e.g., unmatched rows after a `dplyr::left_join()`) produce `NA`.

