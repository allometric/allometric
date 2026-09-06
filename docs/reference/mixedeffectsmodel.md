---
title: "Create a mixed effects model"
description: "`MixedEffectsModel` represents an allometric model that uses fixed and random effects."
---

`MixedEffectsModel` represents an allometric model that uses fixed and random effects.

## Usage

```r

MixedEffectsModel(
  response,
  covariates,
  predict_ranef,
  predict_fn,
  parameters,
  fixed_only = FALSE,
  descriptors = list(),
  response_definition = NA_character_,
  covariate_definitions = list()
)
```

## Arguments

- **response** — A named list containing one element, with a name representing the response variable and a value representing the units of the response variable using the `units::as_units` function.

- **covariates** — A named list containing the covariate specifications, with names representing the covariate name and the values representing the units of the coavariate using the `units::as_units` function

- **predict_ranef** — A function that predicts the random effects, takes any named covariates in `covariates` as arguments

- **predict_fn** — A function that takes the covariate names as arguments and returns a prediction of the response variable. This function should be vectorized.

- **parameters** — A named list of parameters and their values

- **fixed_only** — A boolean value indicating if the model produces predictions using only fixed effects. This is useful when publications do not provide sufficient information to predict the random effects.

- **descriptors** — An optional named list of descriptors that describe the context of the allometric model

- **response_definition** — A string containing an optional custom response definition, which is used instead of the description given by the variable naming system.

- **covariate_definitions** — An optional named list of custom covariate definitions that will supersede the definitions given by the variable naming system. The names of the list must match the covariate names given in `covariates`.

## Value

An instance of MixedEffectsModel

## Slots

- **`parameters`** — A named list of parameters and their values
- **`predict_fn_populated`** — The prediction function populated with the parameter values
- **`specification`** — A tibble::tbl_df of the model specification, which are the parameters and the descriptors together
- **`predict_ranef`** — The function that predicts the random effects
- **`predict_ranef_populated`** — The function that predicts the random effects populated with the fixed effect parameter estimates
- **`fixed_only`** — A boolean value indicating if the model produces predictions using only fixed effects

## Examples

```r

MixedEffectsModel(
  response = list(
    hst = units::as_units("m")
  ),
  covariates = list(
    dsob = units::as_units("cm")
  ),
  parameters = list(
    beta_0 = 40.4218,
    beta_1 = -0.0276,
    beta_2 = 0.936
  ),
  predict_ranef = function() {
    list(b_0_i = 0, b_2_i = 0)
  },
  predict_fn = function(dsob) {
    1.37 + (beta_0 + b_0_i) * (1 - exp(beta_1 * dsob)^(beta_2 + b_2_i))
  },
  fixed_only = TRUE
)
```

