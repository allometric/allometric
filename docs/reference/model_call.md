---
title: "Get the function call for a model"
description: "The function call is the allometric model expressed as a function of its covariates."
---

The function call is the allometric model expressed as a function of its covariates. Accessing the function call is important when determining the order of the covariates given to the prediction function.

## Usage

```r

model_call(object)
```

## Arguments

- **object** — The allometric model or set for which a function call will be retrieved

## Value

A string of the function call

## Examples

```r

model_call(brackett_rubra)
```

