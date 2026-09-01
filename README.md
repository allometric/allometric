---
output: github_document
---



# allometric <picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/allometric/allometric/master/man/figures/allo2-darkmode.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/allometric/allometric/master/man/figures/allo2.svg"><img alt="Isometric logo of a tree" height="210" width="165" align="right"></picture>

<!-- badges: start -->
[![R-CMD-check](https://github.com/allometric/allometric/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/allometric/allometric/actions/workflows/check-standard.yaml)
[![](https://img.shields.io/badge/devel%20version-4.0.0-blue.svg)](https://github.com/allometric/allometric)
[![codecov](https://codecov.io/gh/allometric/allometric/branch/master/graph/badge.svg?token=3V5KUFMO2X)](https://app.codecov.io/gh/allometric/allometric)
[![Static Badge](https://img.shields.io/badge/YouTube-red)](https://www.youtube.com/playlist?list=PLP5y0kzuWunWiUHpgoppVlTC_c2KYlrRK)
<!-- badges: end -->

`allometric` is an R package for predicting tree attributes with allometric 
models. Thousands of allometric models exist in the scientific and technical
forestry literature, and `allometric` is a platform for archiving and using this
vast array of models in a robust and structured format. Get started by going to
the [Installation](#installation) section or the [documentation website](https://allometric.org).

`allometric` models are specified as YAML files in the
[models](https://github.com/allometric/models) repository, validated and
compiled by the [orc](https://github.com/allometric/orc) tooling.

In total **`allometric` contains 2409 models across 75 publications**,
refer to the [Current Status](#current-status) for a more complete view of
available models.

## Installation

For the latest release version, please install directly from GitHub using
`devtools`:


``` r
devtools::install_github("allometric/allometric")
```

Before beginning, make sure to install the models locally by running


``` r
library(allometric)
install_models()
```

This installs the compiled v4 model distribution (three parquet tables) from
the public [models](https://github.com/allometric/models) repository.

Finally, load the models using the `load_models()` function into a variable:


``` r
allometric_models <- load_models()
head(allometric_models)
```

```
#> # A tibble: 6 × 12
#>   id      spec_index model_name model_type pub_id pub_year family_name covt_name
#>   <chr>        <int> <chr>      <chr>      <chr>     <dbl> <list>      <list>   
#> 1 1de630…          0 hstix50    site index barne…     1962 <chr [1]>   <chr [2]>
#> 2 0f54ec…          0 hstix100   site index barre…     1978 <chr [1]>   <chr [2]>
#> 3 fdc267…          0 hst        stem heig… barre…     2006 <chr [1]>   <chr [1]>
#> 4 fdc267…          1 hst        stem heig… barre…     2006 <chr [1]>   <chr [1]>
#> 5 fdc267…          2 hst        stem heig… barre…     2006 <chr [1]>   <chr [1]>
#> 6 fdc267…          3 hst        stem heig… barre…     2006 <chr [1]>   <chr [1]>
#> # ℹ 4 more variables: taxa <list>, region <list<character>>, component <chr>,
#> #   model <list>
```

An initial load models call can take some time, but is cached to the local
file system for more rapid use later.

## Browsing Model Families

Model families are one entry point into the models stored in the allometric
system. They are user-maintained collections of models that are used for a
particular purpose. For example, one might desire a set of total aboveground
biomass models using some multi-species system, or a set of site index functions
from a particular publication.

## Using the Model


``` r
tsuga_poudel <- allometric_models %>%
  dplyr::filter(pub_id == "poudel_2019") %>%
  select_model("1bc22c7e")
```

`tsuga_poudel` now represents an allometric model that can be used for 
prediction. We must next figure out how to use the model.

Using the standard output of `tsuga_poudel` we obtain a summary of the model form,
the response variable, the needed covariates and their units, a summary of
the model descriptors (i.e., what makes the model unique within the
publication), and estimates of the parameters.


``` r
tsuga_poudel
```

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
#> 1 -10.1  1.60  1.34
#> 
#> Model Descriptors: 
#> # A tibble: 1 × 1
#>   taxa  
#>   <list>
#> 1 <Taxa>
```

We can see from the `Model Call` section that `tsuga_poudel` will require
two covariates called `dsob`, which refers to diameter outside bark at
breast height, and `hst`, the height of the main stem. `allometric` uses a
variable naming system to determine the names of response variables and
covariates.

Using the `predict()` method we can easily use the function as defined
by providing values of these two covariates.


``` r
predict(tsuga_poudel, 12, 65)
```

```
#> 0.6231063 [m^3]
```

or we can use the prediction function with a data frame of values


``` r
my_trees <- data.frame(dias = c(12, 15, 20), heights = c(65, 75, 100))
predict(tsuga_poudel, my_trees$dias, my_trees$heights)
```

```
#> Units: [m^3]
#> [1] 0.6231063 1.0784983 2.5134156
```

or even using the convenience of `dplyr`


``` r
my_trees %>%
  mutate(vols = predict(tsuga_poudel, dias, heights))
```

```
#>   dias heights            vols
#> 1   12      65 0.6231063 [m^3]
#> 2   15      75 1.0784983 [m^3]
#> 3   20     100 2.5134156 [m^3]
```

The above example is a very basic use case for `allometric`.

## Current Status

In total **`allometric` contains 2409 models across 75 publications**.


|category                | Total| NA| AS| EU| SA| AF| OC|
|:-----------------------|-----:|--:|--:|--:|--:|--:|--:|
|biomass component       |   141| 16|  5|  4|  0|  0|  0|
|tree biomass            |    63|  0|  1|  1|  0|  0|  0|
|stem volume             |    37|  2|  0|  0|  0|  0|  0|
|stem height             |    28|  0|  0|  0|  0|  0|  0|
|site index              |    26|  0|  0|  0|  0|  0|  0|
|taper                   |    10|  0|  0|  0|  0|  0|  0|
|crown diameter          |     3|  0|  0|  0|  0|  0|  0|
|shrub biomass increment |     3|  0|  0|  0|  0|  0|  0|
|shrub diameter          |     2|  0|  0|  0|  0|  0|  0|
|shrub height            |     2|  0|  0|  0|  0|  0|  0|
|crown height            |     1|  0|  0|  0|  0|  0|  0|
|shrub biomass           |     1|  0|  0|  0|  0|  0|  0|
|stump volume            |     1|  0|  0|  0|  0|  0|  0|
|other                   |    24|  0|  0|  0|  0|  0|  0|

## How Can I Help?

`allometric` is a monumental undertaking, and already several people have come
forward and added hundreds of models. There are several ways to help out. The
following list is ranked from the least to most difficult tasks.

1. [Add missing publications as an Issue](https://github.com/allometric/models/issues/new?assignees=brycefrank&labels=add+publication&projects=&template=add-models-from-a-publication.md&title=%5BInsert+Author-Date+Citation%5D). 
We always need help *finding publications* to add. If you know of a publication that is missing, feel free to add it as an Issue and we will eventually add the models contained inside.
2.  [Find source material for a publication](https://github.com/allometric/models/labels/missing%20source).
Some publications are missing their original source material. Usually these are very old legacy publications. If you know where a publication might be found, or who to contact, leave a note on any of these issues.
3. [Help us digitize publications](https://github.com/allometric/models/labels/digitization%20needed). 
We always need help *digitizing legacy reports*, at this link you will find a list of reports that need manual digitization. These can be handled by anyone with Excel and a cup of coffee.
4. [Write a model YAML file](https://github.com/allometric/models).
Models are specified as YAML in the `allometric/models` repository; the
[orc documentation](https://allometric.github.io/orc/) describes the schema.
Users comfortable with git and YAML can handle this task.

Other ideas? Contact bfrank70@gmail.com to help out.

## Next Steps

Users interested in finding models for analysis will find the following
resources most useful:

- The [Models](https://allometric.org/models/) and
  [Publications](https://allometric.org/publications/) pages on the allometric
  website.

Users interested in **contributing models** to the package will find these resources the most useful:

- [Model YAML specification (orc)](https://allometric.github.io/orc/)
- The [Contributing Models guide](https://allometric.org/guides/contributing/)
