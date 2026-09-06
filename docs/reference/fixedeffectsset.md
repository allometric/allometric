---
title: "Create a set of fixed effects models"
description: "A `FixedEffectsSet` represents a group of fixed-effects models that all have the same functional structure."
---

A `FixedEffectsSet` represents a group of fixed-effects models that all have the same functional structure. Fitting a large family of models (e.g., for many different species) using the same functional structure is a common pattern in allometric studies, and `FixedEffectsSet` facilitates the installation of these groups of models by allowing the user to specify the parameter estimates and descriptions in a dataframe.

## Usage

```r

FixedEffectsSet(
  response,
  covariates,
  parameter_names,
  predict_fn,
  model_specifications,
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

- **descriptors** — An optional named list of descriptors that describe the context of the allometric model

- **response_definition** — A string containing an optional custom response definition, which is used instead of the description given by the variable naming system.

- **covariate_definitions** — An optional named list of custom covariate definitions that will supersede the definitions given by the variable naming system. The names of the list must match the covariate names given in `covariates`.

## Value

A set of fixed effects models

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
- **`parameter_names`** — A character vector indicating the parameter names
- **`model_specifications`** — A `tibble::tbl_df` of model specifications, where each row reprents one model identified with descriptors and containing the parameter estimates.

## Examples

```r

fixef_set <- FixedEffectsSet(
  response = list(
    vsia = units::as_units("ft^3")
  ),
  covariates = list(
    dsob = units::as_units("in")
  ),
  predict_fn = function(dsob) {
    a * dsob^2
  },
  parameter_names = "a",
  model_specifications = tibble::tibble(mod = c(1,2), a = c(1, 2))
)
```

