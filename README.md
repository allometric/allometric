
# allometric <picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/allometric/allometric/4765cf71c0227b48e036e02f3ed87945a3e9ad91/man/figures/allo2-darkmode.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/allometric/allometric/4765cf71c0227b48e036e02f3ed87945a3e9ad91/man/figures/allo2.svg"><img alt="Isometric logo of a tree" height="210" width="165" align="right"></picture>

<!-- badges: start -->

[![R-CMD-check](https://github.com/allometric/allometric/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/allometric/allometric/actions/workflows/check-standard.yaml)
[![codecov](https://codecov.io/gh/allometric/allometric/branch/main/graph/badge.svg?token=3V5KUFMO2X)](https://app.codecov.io/gh/allometric/allometric)
<!-- badges: end -->

`allometric` provides structured allometric models for predicting tree
attributes. The [documentation website](https://allometric.org) contains
model browsing tools, guides, and additional examples.

## Installation

Install the package from GitHub with `devtools`:

``` r
devtools::install_github("allometric/allometric")
```

Install the compiled model distribution locally:

``` r
library(allometric)
install_models()
```

The models are downloaded from the public
[models](https://github.com/allometric/models) repository. Load them
with:

``` r
allometric_models <- load_models()
```

## Example

Select a model and use it to predict stem volume from diameter outside
bark at breast height (`dsob`, in cm) and total stem height (`hst`, in
m):

``` r
poudel_model <- allometric_models |>
  dplyr::filter(pub_id == "poudel_2019") |>
  select_model("1bc22c7e")

predict(poudel_model, 12, 65)
#> 0.6231063 [m^3]
```

See the [documentation website](https://allometric.org) for more
examples, model discovery, variable naming, and advanced prediction
workflows.
