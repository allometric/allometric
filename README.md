
# allometric <picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/allometric/allometric/master/man/figures/allo2-darkmode.svg"><source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/allometric/allometric/master/man/figures/allo2.svg"><img alt="Isometric logo of a tree" height="210" width="165" align="right"></picture>

<!-- badges: start -->

[![R-CMD-check](https://github.com/allometric/allometric/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/allometric/allometric/actions/workflows/check-standard.yaml)
[![](https://img.shields.io/badge/devel%20version-3.0.0-blue.svg)](https://github.com/allometric/allometric)
[![codecov](https://codecov.io/gh/allometric/allometric/branch/master/graph/badge.svg?token=3V5KUFMO2X)](https://app.codecov.io/gh/allometric/allometric)
[![Static
Badge](https://img.shields.io/badge/YouTube-red)](https://www.youtube.com/playlist?list=PLP5y0kzuWunWiUHpgoppVlTC_c2KYlrRK)
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

In total **`allometric` contains 2392 models across 74 publications**,
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

This installs the compiled v4 model distribution (three parquet tables)
from the public [models](https://github.com/allometric/models)
repository.

Finally, load the models using the `load_models()` function into a
variable:

``` r
allometric_models <- load_models()
```

    #> Warning: 74 publication(s) lack required BibTeX fields for their declared
    #> bibtype; citations were built with bibtype 'misc': barnes_1962, barrett_1978,
    #> barrett_2006, bell_1981, bluhm_2007, ...

``` r
head(allometric_models)
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

## Finding a Model

`allometric_models` is a `tibble` dataframe. Each row represents one
allometric model with various attributes. Users interact with this table
the way they would with any other `tibble`.

For example, we can use `dplyr` to filter this table to find models for
analysis. Let’s say I am interested in finding stem volume models for
*Tsuga heterophylla*. First, let us filter the `model_type` to include
only stem volume models

``` r
stemvol_models <- allometric_models %>%
  filter(model_type == "stem volume")

stemvol_models
```

    #> # A tibble: 314 × 12
    #>    id     spec_index model_name model_type pub_id pub_year family_name covt_name
    #>    <chr>       <int> <chr>      <chr>      <chr>     <dbl> <list>      <list>   
    #>  1 db912…          0 vsia       stem volu… bell_…     1981 <chr [3]>   <chr [2]>
    #>  2 7f1ba…          0 vsia       stem volu… brack…     1977 <chr [1]>   <chr [2]>
    #>  3 7f1ba…          1 vsia       stem volu… brack…     1977 <chr [1]>   <chr [2]>
    #>  4 7f1ba…          2 vsia       stem volu… brack…     1977 <chr [1]>   <chr [2]>
    #>  5 7f1ba…          3 vsia       stem volu… brack…     1977 <chr [1]>   <chr [2]>
    #>  6 7f1ba…          4 vsia       stem volu… brack…     1977 <chr [1]>   <chr [2]>
    #>  7 7f1ba…          5 vsia       stem volu… brack…     1977 <chr [1]>   <chr [2]>
    #>  8 7f1ba…          6 vsia       stem volu… brack…     1977 <chr [1]>   <chr [2]>
    #>  9 7f1ba…          7 vsia       stem volu… brack…     1977 <chr [1]>   <chr [2]>
    #> 10 7f1ba…          8 vsia       stem volu… brack…     1977 <chr [1]>   <chr [2]>
    #> # ℹ 304 more rows
    #> # ℹ 4 more variables: taxa <list>, region <list<character>>, component <chr>,
    #> #   model <list>

Next, we can filter to include only *Tsuga heterophylla* using a special
specifier called `Taxon` that enables rigorous searching of species:

``` r
tsuga_het_taxon <- Taxon(
  family = "Pinaceae", genus = "Tsuga", species = "heterophylla"
)

tsuga_vol_models <- stemvol_models %>%
  filter(purrr::map_lgl(taxa, ~ tsuga_het_taxon %in% .))

tsuga_vol_models
```

    #> # A tibble: 4 × 12
    #>   id      spec_index model_name model_type pub_id pub_year family_name covt_name
    #>   <chr>        <int> <chr>      <chr>      <chr>     <dbl> <list>      <list>   
    #> 1 7f1ba0…          3 vsia       stem volu… brack…     1977 <chr [1]>   <chr [2]>
    #> 2 7f1ba0…          4 vsia       stem volu… brack…     1977 <chr [1]>   <chr [2]>
    #> 3 7f1ba0…          5 vsia       stem volu… brack…     1977 <chr [1]>   <chr [2]>
    #> 4 a136ec…         21 vsia       stem volu… poude…     2019 <chr [4]>   <chr [2]>
    #> # ℹ 4 more variables: taxa <list>, region <list<character>>, component <chr>,
    #> #   model <list>

We can see that we have 4 models to choose from. Let’s select the model
from the publication `poudel_2019`

``` r
tsuga_poudel <- tsuga_vol_models %>% select_model("a136ecc8")
```

This example is very basic, and more complex search examples can be
found in the
[`load_models()`](https://allometric.org/reference/load_models.html)
documentation. Models can be searched not only by their taxonomic
information, but also the types of measurements the models require,
their geographic region, and other attributes. We highly encourage users
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
    #> # A tibble: 1 × 1
    #>   taxa  
    #>   <list>
    #> 1 <Taxa>

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

In total **`allometric` contains 2392 models across 74 publications**.

| category                | Total |  NA |  AS |  EU |  SA |  AF |  OC |
|:------------------------|------:|----:|----:|----:|----:|----:|----:|
| biomass component       |   141 |  16 |   5 |   4 |   0 |   0 |   0 |
| tree biomass            |    63 |   0 |   1 |   1 |   0 |   0 |   0 |
| stem volume             |    37 |   2 |   0 |   0 |   0 |   0 |   0 |
| stem height             |    28 |   0 |   0 |   0 |   0 |   0 |   0 |
| site index              |    26 |   0 |   0 |   0 |   0 |   0 |   0 |
| taper                   |    10 |   0 |   0 |   0 |   0 |   0 |   0 |
| crown diameter          |     3 |   0 |   0 |   0 |   0 |   0 |   0 |
| shrub biomass increment |     3 |   0 |   0 |   0 |   0 |   0 |   0 |
| shrub diameter          |     2 |   0 |   0 |   0 |   0 |   0 |   0 |
| shrub height            |     2 |   0 |   0 |   0 |   0 |   0 |   0 |
| crown height            |     1 |   0 |   0 |   0 |   0 |   0 |   0 |
| shrub biomass           |     1 |   0 |   0 |   0 |   0 |   0 |   0 |
| stump volume            |     1 |   0 |   0 |   0 |   0 |   0 |   0 |
| other                   |    24 |   0 |   0 |   0 |   0 |   0 |   0 |

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
