---
title: "Create a set of mixed effects models"
description: "A `MixedEffectsSet` represents a group of mixed-effects models that all have the same functional structure."
---

A `MixedEffectsSet` represents a group of mixed-effects models that all have the same functional structure. Fitting a large family of models (e.g., for many different species) using the same functional structure is a common pattern in allometric studies, and `MixedEffectsSet` facilitates the installation of these groups of models by allowing the user to specify the parameter estimates and descriptions in a dataframe or spreadsheet.

## Usage

```r

MixedEffectsSet(
  response,
  covariates,
  parameter_names,
  predict_fn,
  model_specifications,
  predict_ranef,
  fixed_only = FALSE,
  descriptors = list(),
  response_definition = NA_character_,
  covariate_definitions = list()
)
```

## Arguments

- **response** — A named list containing one element, with a name representing the response variable and a value representing the units of the response variable using the `units::as_units` function.

- **covariates** — A named list containing the covariate specifications, with names representing the covariate name and the values representing the units of the coavariate using the `units::as_units` function

- **parameter_names** — A character vector naming the columns in `model_specifications` that represent the parameters

- **predict_fn** — A function that takes the covariate names as arguments and returns a prediction of the response variable. This function should be vectorized.

- **model_specifications** — A dataframe such that each row of the dataframe provides model-level descriptors and parameter estimates for that model. Models must be uniquely identifiable using the descriptors. This is usually established using the `load_parameter_frame()` function.

- **predict_ranef** — A function that predicts the random effects, takes any named covariates in `covariates` as arguments

- **fixed_only** — A boolean value indicating if the model produces predictions using only fixed effects. This is useful when publications do not provide sufficient information to predict the random effects.

- **descriptors** — An optional named list of descriptors that describe the context of the allometric model

- **response_definition** — A string containing an optional custom response definition, which is used instead of the description given by the variable naming system.

- **covariate_definitions** — An optional named list of custom covariate definitions that will supersede the definitions given by the variable naming system. The names of the list must match the covariate names given in `covariates`.

## Value

An instance of MixedEffectsSet

## Details

Because mixed-effects models already accommodate a grouping structure, `MixedEffectsSet` tends to be a much rarer occurrence than `FixedEffectsSet`

and `MixedEffectsModel`.

## Slots

- **`parameters`** — A named list of parameters and their values
- **`predict_fn_populated`** — The prediction function populated with the parameter values
- **`specification`** — A tibble::tbl_df of the model specification, which are the parameters and the descriptors together
- **`predict_ranef`** — The function that predicts the random effects
- **`predict_ranef_populated`** — The function that predicts the random effects populated with the fixed effect parameter estimates
- **`fixed_only`** — A boolean value indicating if the model produces predictions using only fixed effects
- **`model_specifications`** — A `tibble::tbl_df` of model specifications, where each row reprents one model identified with descriptors and containing the parameter estimates.

## Examples

```r

mixed_effects_set <- MixedEffectsSet(
  response = list(
    vsia = units::as_units("ft^3")
  ),
  covariates = list(
    dsob = units::as_units("in")
  ),
  parameter_names = "a",
  predict_ranef = function(dsob, hst) {
    list(a_i = 1)
  },
  predict_fn = function(dsob) {
    (a + a_i) * dsob^2
  },
  model_specifications = tibble::tibble(a = c(1, 2))
)
```

