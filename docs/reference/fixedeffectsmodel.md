---
title: "Create a fixed effects model"
description: "`FixedEffectsModel` represents an allometric model that only uses fixed effects."
---

`FixedEffectsModel` represents an allometric model that only uses fixed effects.

## Usage

```r

FixedEffectsModel(
  response,
  covariates,
  predict_fn,
  parameters,
  descriptors = list(),
  response_definition = NA_character_,
  covariate_definitions = list()
)
```

## Arguments

- **response** — A named list containing one element, with a name representing the response variable and a value representing the units of the response variable using the `units::as_units` function.

- **covariates** — A named list containing the covariate specifications, with names representing the covariate name and the values representing the units of the coavariate using the `units::as_units` function

- **predict_fn** — A function that takes the covariate names as arguments and returns a prediction of the response variable. This function should be vectorized.

- **parameters** — A named list of parameters and their values

- **descriptors** — An optional named list of descriptors that describe the context of the allometric model

- **response_definition** — A string containing an optional custom response definition, which is used instead of the description given by the variable naming system.

- **covariate_definitions** — An optional named list of custom covariate definitions that will supersede the definitions given by the variable naming system. The names of the list must match the covariate names given in `covariates`.

## Value

An object of class `FixedEffectsModel`

## Slots

- **`response_unit`** — A one-element list with the name indicating the response variable and the value as the response variable units obtained using `units::as_units()`
- **`covariate_units`** — A list containing the covariate names as names and values as the values of the covariate units obtained using `units::as_units()`
- **`predict_fn`** — The prediction function, which takes covariates as arguments and returns model predictions
- **`descriptors`** — A `tibble::tbl_df` containing the model descriptors
- **`set_descriptors`** — A `tibble::tbl_df` containing the set descriptors
- **`pub_descriptors`** — A `tibble::tbl_df` containing the publication descriptors
- **`citation`** — A `RefManageR::BibEntry` object containing the reference publication
- **`covariate_definitions`** — User-provided covariate definitions
- **`model_type`** — The model type, which is parsed from the `response_unit` name
- **`parameters`** — A named list of parameters and their values
- **`predict_fn_populated`** — The prediction function populated with the parameter values
- **`specification`** — A tibble::tbl_df of the model specification, which are the parameters and the descriptors together

## Examples

```r

FixedEffectsModel(
  response = list(
    hst = units::as_units("m")
  ),
  covariates = list(
    dsob = units::as_units("cm")
  ),
  parameters = list(
    beta_0 = 51.9954,
    beta_1 = -0.0208,
    beta_2 = 1.0182
  ),
  predict_fn = function(dsob) {
    1.37 + beta_0 * (1 - exp(beta_1 * dsob)^beta_2)
  }
)
```

