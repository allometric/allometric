
# allometric <picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/allometric/allometric/master/man/figures/allo2-darkmode.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/allometric/allometric/master/man/figures/allo2.svg"><img alt="Isometric logo of a tree" height="210" width="165" align="right"></picture>

<!-- badges: start -->

[![R-CMD-check](https://github.com/allometric/allometric/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/allometric/allometric/actions/workflows/check-standard.yaml)
[![](https://img.shields.io/badge/devel%20version-1.4.1-blue.svg)](https://github.com/allometric/allometric)
[![codecov](https://codecov.io/gh/allometric/allometric/branch/master/graph/badge.svg?token=3V5KUFMO2X)](https://app.codecov.io/gh/allometric/allometric)
<!-- badges: end -->

`allometric` is an R package for predicting tree attributes with
allometric models. Thousands of allometric models exist in the
scientific and technical forestry literature, and `allometric` is a
platform for archiving and using this vast array of models in a robust
and structured format. Get started by going to the
[Installation](#installation) section or the [documentation
website](https://allometric.org).

`allometric` also provides a structured language for adding models to
the package. If you are interested in helping the developer in this
process please refer to the [Contributing a
Model](https://allometric.org/articles/installing_a_model.html)
vignette.

In total **`allometric` contains 2100 models across 61 publications**,
refer to the [Current Status](#current-status) for a more complete view
of available models.

## Installation

Currently `allometric` can be installed via CRAN:

``` r
install.packages("allometric")
```

For the latest release version, please install directly from GitHub
using `devtools`:

``` r
devtools::install_github("allometric/allometric")
```

Before beginning, make sure to install the models locally by running

``` r
library(allometric)
install_models()
```

This installs all available models from the public
[models](https://github.com/allometric/models) repository.

Finally, load the models using the `load_models()` function into a
variable:

``` r
allometric_models <- load_models()
head(allometric_models)
```

    #> # A tibble: 6 × 12
    #>   id       model_type   country   region family  genus species model      pub_id
    #>   <chr>    <chr>        <list>    <list> <chr>   <chr> <chr>   <list>     <chr> 
    #> 1 d6a8836f stem height  <chr [1]> <chr>  Accipi… Circ… canade… <FxdEffcM> hahn_…
    #> 2 7bc0e06a stem volume  <chr [1]> <chr>  Accipi… Circ… canade… <FxdEffcM> hahn_…
    #> 3 1fa4219a stem volume  <chr [1]> <chr>  Accipi… Circ… canade… <FxdEffcM> hahn_…
    #> 4 b359d3ce stump volume <chr [1]> <chr>  Accipi… Circ… canade… <FxdEffcM> hahn_…
    #> 5 fb5c4575 stem ratio   <chr [1]> <chr>  Accipi… Circ… canade… <FxdEffcM> hahn_…
    #> 6 733186a1 stem height  <chr [1]> <chr>  Acerac… Acer  macrop… <FxdEffcM> fvs_2…
    #> # ℹ 3 more variables: family_name <list>, covt_name <list>, pub_year <dbl>

## Finding a Model

`allometric_models` is a `tibble` dataframe. Each row represents one
allometric model with various attributes. Users interact with this table
the way they would with any other `tibble`.

For example, we can use `dplyr` to filter this table to find models for
analysis. Let’s say I am interested in finding stem volume models for
*Tsuga heterophylla*. We can filter the `model_type`, `genus`, and
`species` columns to find these models:

``` r
tsuga_vol_models <- allometric_models %>%
  filter(model_type == "stem volume", genus == "Tsuga", species == "heterophylla")

tsuga_vol_models
```

    #> # A tibble: 4 × 12
    #>   id       model_type  country   region family   genus species model      pub_id
    #>   <chr>    <chr>       <list>    <list> <chr>    <chr> <chr>   <list>     <chr> 
    #> 1 970312f8 stem volume <chr [1]> <chr>  Pinaceae Tsuga hetero… <FxdEffcM> brack…
    #> 2 78845be6 stem volume <chr [1]> <chr>  Pinaceae Tsuga hetero… <FxdEffcM> brack…
    #> 3 739810a1 stem volume <chr [1]> <chr>  Pinaceae Tsuga hetero… <FxdEffcM> brack…
    #> 4 3e8447f2 stem volume <chr [2]> <chr>  Pinaceae Tsuga hetero… <FxdEffcM> poude…
    #> # ℹ 3 more variables: family_name <list>, covt_name <list>, pub_year <dbl>

We can see that we have 4 models to choose from. Let’s select the model
from the publication `poudel_2019`

``` r
tsuga_poudel <- tsuga_vol_models %>% select_model("3e8447f2")
```

This example is very basic, and more complex search examples can be
found in the
[`load_models()`](https://allometric.org/reference/load_models.html)
documentation. Models can be searched not only by their genus and
species, but also the types of measurements the models require, their
geographic region, and other attributes. We highly encourage users
review the linked examples for production use of `allometric`.

## Using the Model

`tsuga_poudel` now represents an allometric model that can be used for
prediction. We must next figure out how to use the model.

Using the standard output of `tsuga_poudel` we obtain a summary of the
model form, the response variable, the needed covariates and their
units, a summary of the model descriptors (i.e., what makes the model
unique within the publication), and estimates of the parameters.

``` r
tsuga_poudel
```

    #> Model Call: 
    #> vsia = f(dsob, hst) 
    #>  
    #> vsia [m3]: volume of the entire stem inside bark, including top and stump
    #> dsob [cm]: diameter of the stem, outside bark at breast height
    #> hst [m]: total height of the stem 
    #> 
    #> Parameter Estimates: 
    #> # A tibble: 1 × 3
    #>       a     b     c
    #>   <dbl> <dbl> <dbl>
    #> 1 -9.98  1.96 0.925
    #> 
    #> Model Descriptors: 
    #> # A tibble: 1 × 5
    #>   country   region     family   genus species     
    #>   <list>    <list>     <chr>    <chr> <chr>       
    #> 1 <chr [2]> <chr [10]> Pinaceae Tsuga heterophylla

We can see from the `Model Call` section that `tsuga_poudel` will
require two covariates called `dsob`, which refers to diameter outside
bark at breast height, and `hst`, the height of the main stem.
`allometric` uses a variable naming system to determine the names of
response variables and covariates (refer to the [Variable Naming System
vignette](https://allometric.org/articles/variable_naming_system.html)).

Using the `predict()` method we can easily use the function as defined
by providing values of these two covariates.

``` r
predict(tsuga_poudel, 12, 65)
```

    #> 0.2868491 [m^3]

or we can use the prediction function with a data frame of values

``` r
my_trees <- data.frame(dias = c(12, 15, 20), heights = c(65, 75, 100))
predict(tsuga_poudel, my_trees$dias, my_trees$heights)
```

    #> Units: [m^3]
    #> [1] 0.2868491 0.5068963 1.1618632

or even using the convenience of `dplyr`

``` r
my_trees %>%
  mutate(vols = predict(tsuga_poudel, dias, heights))
```

    #>   dias heights            vols
    #> 1   12      65 0.2868491 [m^3]
    #> 2   15      75 0.5068963 [m^3]
    #> 3   20     100 1.1618632 [m^3]

The above example is a very basic use case for `allometric`. Please
refer to the [Common Inventory Use Cases
vignette](https://allometric.org/articles/inventory_example.html) for
more complex examples.

## Current Status

In total **`allometric` contains 2100 models across 61 publications**.

| category                |  AS |  EU |  NA |  AF |  OC |  SA |
|:------------------------|----:|----:|----:|----:|----:|----:|
| biomass component       |  26 | 136 | 435 |   0 |   0 |   0 |
| crown diameter          |   0 |  12 |  36 |   0 |   0 |   0 |
| crown height            |   0 |  12 |   0 |   0 |   0 |   0 |
| shrub biomass           |   0 |  19 |   0 |   0 |   0 |   0 |
| shrub biomass increment |   0 |  28 |   0 |   0 |   0 |   0 |
| shrub diameter          |   0 |  39 |   0 |   0 |   0 |   0 |
| shrub height            |   0 |  28 |   0 |   0 |   0 |   0 |
| site index              |   0 |   0 |  52 |   0 |   0 |   0 |
| stem height             |   7 |   0 | 346 |  12 |   2 |  17 |
| stem volume             |   4 |   0 | 575 |   0 |   0 |  20 |
| stump volume            |   0 |   0 |  64 |   0 |   0 |   0 |
| taper                   |   2 |   0 |  18 |   0 |   0 |   0 |
| tree biomass            |   2 |  36 |  90 |   0 |  21 |  16 |
| other                   |   0 |   0 | 168 |   0 |   0 |   0 |

## How Can I Help?

`allometric` is a monumental undertaking, and already several people
have come forward and added hundreds of models. There are several ways
to help out. The following list is ranked from the least to most
difficult tasks.

1.  [Add missing publications as an
    Issue](https://github.com/allometric/models/issues/new?assignees=brycefrank&labels=add+publication&projects=&template=add-models-from-a-publication.md&title=%5BInsert+Author-Date+Citation%5D).
    We always need help *finding publications* to add. If you know of a
    publication that is missing, feel free to add it as an Issue and we
    will eventually install the models contained inside.
2.  [Find source material for a
    publication](https://github.com/allometric/models/labels/missing%20source).
    Some publications are missing their original source material.
    Usually these are very old legacy publications. If you know where a
    publication might be found, or who to contact, leave a note on any
    of these issues.
3.  [Help us digitize
    publications](https://github.com/allometric/models/labels/digitization%20needed).
    We always need help *digitizing legacy reports*, at this link you
    will find a list of reports that need manual digitization. These can
    be handled by anyone with Excel and a cup of coffee.
4.  [Learn how to install and write
    models](https://allometric.org/articles/installing_a_model.html).
    Motivated users can learn how to install models directly using the
    package functions and git pull requests. Users comfortable with R
    and git can handle this task.

Other ideas? Contact <bfrank70@gmail.com> to help out.

## Next Steps

The following vignettes available on the [package
website](https://allometric.org/index.html) provide information to two
primary audiences.

Users interested in finding models for analysis will find the following
documentation most useful:

- [Common Inventory Use
  Cases](https://allometric.org/articles/inventory_example.html)

Users interested in **contributing models** to the package will find
these vignettes the most useful:

- [Contributing a
  Model](https://allometric.org/articles/installing_a_model.html)
- [Describing a Model with
  Descriptors](https://allometric.org/articles/descriptors.html)
- [Variable Naming
  System](https://allometric.org/articles/variable_naming_system.html)
