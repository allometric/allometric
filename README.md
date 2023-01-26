
# allometric <a href="https://brycefrank.com/allometric/"><img src='man/figures/logo.png' align="right" height="139"/></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/brycefrank/allometric/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/brycefrank/allometric/actions/workflows/check-standard.yaml)
[![](https://img.shields.io/badge/devel%20version-1.0.0.9001-blue.svg)](https://github.com/brycefrank/allometric)
[![codecov](https://codecov.io/gh/brycefrank/allometric/branch/master/graph/badge.svg?token=3V5KUFMO2X)](https://codecov.io/gh/brycefrank/allometric)
<!-- badges: end -->

`allometric` is an R package for predicting tree attributes with
allometric models. Thousands of allometric models exist in the
scientific and technical forestry literature, and `allometric` is a
platform for archiving and using this vast array of models in a robust
and structured format.

`allometric` not only enables the use of allometric models for analysis,
it also provides a structured language for adding models to the package.
If you are interested in helping the developer in this process please
refer to the [Installing a
Model](https://brycefrank.com/allometric/articles/installing_a_model.html)
vignette.

In total **`allometric` contains 677 models across 25 publications**,
the following table displays the number of models by continent and
category:

| category          |  AS |  EU |  NA |  AF |  OC |  SA |
|:------------------|----:|----:|----:|----:|----:|----:|
| biomass component |  16 | 126 |  15 |   0 |   0 |   0 |
| site index        |   0 |   0 |   2 |   0 |   0 |   0 |
| stem height       |   7 |   0 |  26 |  12 |   2 |  18 |
| stem volume       |   0 |   0 | 315 |   0 |   0 |  20 |
| taper             |   0 |   0 |  18 |   0 |   0 |   0 |
| tree biomass      |   0 |  34 |  90 |   0 |   0 |  16 |
| other             |   0 |   0 |  40 |   0 |   0 |   0 |

Refer to the
[Reference](https://brycefrank.com/allometric/reference/index.html) for
a full list of publications disaggregated by allometric model type.

If you are interested in collaboration (adding models or working on the
package functions) please email me at <bfrank70@gmail.com>

## Installation

Currently `allometric` is only available on GitHub, and can be installed
using `devtools`.

``` r
devtools::install_github("brycefrank/allometric")
```

## Getting Started

Most users will only be interested in finding and using allometric
equations in their analysis. `allometric` allows rapid searching of
currently installed models.

Before beginning, make sure to install the models locally by running

``` r
library(allometric)
install_models()
```

This compiles the allometric models, and enables their use.
`install_models()` only needs to be ran at installation or following any
package updates. After running this function, the models are available
in the variable `allometric_models`. Refer to the `?allometric_models`
help for more information.

``` r
head(allometric_models)
```

    #> # A tibble: 6 × 12
    #>   id       model_type   country   region     family        genus       species     model      pub_id        family_name covt_name pub_year
    #>   <chr>    <chr>        <list>    <list>     <chr>         <chr>       <chr>       <list>     <chr>         <list>      <list>       <dbl>
    #> 1 218a0299 stem volume  <chr [1]> <chr [1]>  Aceraceae     Acer        <NA>        <FxdEffcM> brackett_1977 <chr [1]>   <chr [2]>     1977
    #> 2 19b459f0 stem volume  <chr [1]> <chr [4]>  Altingiaceae  Liquidambar styraciflua <FxdEffcM> hahn_1991     <chr [2]>   <chr [2]>     1991
    #> 3 18c333d1 stem volume  <chr [1]> <chr [4]>  Altingiaceae  Liquidambar styraciflua <FxdEffcM> hahn_1991     <chr [2]>   <chr [2]>     1991
    #> 4 6113bb8e stem volume  <chr [1]> <chr [14]> Altingiaceae  Liquidambar styraciflua <FxdEffcM> scott_1981    <chr [1]>   <chr [2]>     1981
    #> 5 67ec8735 stem volume  <chr [1]> <chr [1]>  Anacardiaceae Tapirira    guianensis  <FxdEffcM> vibrans_2015  <chr [4]>   <chr [2]>     2015
    #> 6 49ce7317 tree biomass <chr [1]> <chr [1]>  Aquifoliaceae Ilex        canariensis <FxdEffcM> montero_2005  <chr [3]>   <chr [1]>     2005

**Finding and Selecting a Model**

`allometric_models` is a `tibble::tbl_df` dataframe. Each row represents
one allometric model with various attributes. Some columns are `list`
columns, which are columns that contain lists with multiple values as
their elements. One example of this is the `family_name` column, which
contains the names of all authors for the publication that contains the
model.

`list` columns enable rigorous searching of models covered in the
`?allometric_models` help page, but to get started we will use a helper
function called `unnest_models()` that will give us a clearer picture of
the available data. Using the `cols` argument we can specify which
columns we want to unnest. In this case we will unnest the `family_name`
column.

``` r
unnested_models <- unnest_models(allometric_models, cols = "family_name")
unnested_models
```

    #> # A tibble: 1,831 × 12
    #>    id       model_type  country   region     family        genus       species     model      pub_id        family_name                 covt_name pub_year
    #>    <chr>    <chr>       <list>    <list>     <chr>         <chr>       <chr>       <list>     <chr>         <chr>                       <list>       <dbl>
    #>  1 218a0299 stem volume <chr [1]> <chr [1]>  Aceraceae     Acer        <NA>        <FxdEffcM> brackett_1977 "Brackett"                  <chr [2]>     1977
    #>  2 19b459f0 stem volume <chr [1]> <chr [4]>  Altingiaceae  Liquidambar styraciflua <FxdEffcM> hahn_1991     "Hahn"                      <chr [2]>     1991
    #>  3 19b459f0 stem volume <chr [1]> <chr [4]>  Altingiaceae  Liquidambar styraciflua <FxdEffcM> hahn_1991     "Hansen"                    <chr [2]>     1991
    #>  4 18c333d1 stem volume <chr [1]> <chr [4]>  Altingiaceae  Liquidambar styraciflua <FxdEffcM> hahn_1991     "Hahn"                      <chr [2]>     1991
    #>  5 18c333d1 stem volume <chr [1]> <chr [4]>  Altingiaceae  Liquidambar styraciflua <FxdEffcM> hahn_1991     "Hansen"                    <chr [2]>     1991
    #>  6 6113bb8e stem volume <chr [1]> <chr [14]> Altingiaceae  Liquidambar styraciflua <FxdEffcM> scott_1981    "Scott"                     <chr [2]>     1981
    #>  7 67ec8735 stem volume <chr [1]> <chr [1]>  Anacardiaceae Tapirira    guianensis  <FxdEffcM> vibrans_2015  "Vibrans"                   <chr [2]>     2015
    #>  8 67ec8735 stem volume <chr [1]> <chr [1]>  Anacardiaceae Tapirira    guianensis  <FxdEffcM> vibrans_2015  "Moser"                     <chr [2]>     2015
    #>  9 67ec8735 stem volume <chr [1]> <chr [1]>  Anacardiaceae Tapirira    guianensis  <FxdEffcM> vibrans_2015  "Oliveira"                  <chr [2]>     2015
    #> 10 67ec8735 stem volume <chr [1]> <chr [1]>  Anacardiaceae Tapirira    guianensis  <FxdEffcM> vibrans_2015  "c(\"de\", \"MaÃ§aneiro\")" <chr [2]>     2015
    #> # … with 1,821 more rows

Now, each row represents unique data combinations for each model, which
can be quickly filtered by most users using `dplyr::filter`. For
example, to find a volume model for the genus Alnus that had
`"Brackett"` as an author or co-author we can use

``` r
brackett_alnus_vol <- unnested_models %>%
  dplyr::filter(
    family_name == "Brackett", model_type == "stem volume",
    genus == "Alnus"
  )

brackett_alnus_vol
```

    #> # A tibble: 1 × 12
    #>   id       model_type  country   region    family     genus species model      pub_id        family_name covt_name pub_year
    #>   <chr>    <chr>       <list>    <list>    <chr>      <chr> <chr>   <list>     <chr>         <chr>       <list>       <dbl>
    #> 1 f21028ef stem volume <chr [1]> <chr [1]> Betulaceae Alnus rubra   <FxdEffcM> brackett_1977 Brackett    <chr [2]>     1977

we can see that model `f21028ef` is a volume model written by Brackett
for *Alnus rubra*. The model can be selected using the `id` field:

``` r
brackett_alnus_mod <- brackett_alnus_vol %>% select_model("f21028ef")
```

or by using the row index

``` r
brackett_alnus_mod <- brackett_alnus_vol %>% select_model(1)
```

**Determine Needed Information**

`brackett_alnus_mod` now represents an allometric model that can be used
for prediction.

Using the standard output of `brackett_alnus_mod` we obtain a summary of
the model form, the response variable, the needed covariates and their
units, a summary of the model descriptors (i.e., what makes the model
unique within the publication), and estimates of the parameters.

``` r
brackett_alnus_mod
```

    #> Model Call: 
    #> vsa = f(dsob, hst) 
    #>  
    #> Model Form: 
    #> vsa = 10^a * dsob^b * hst^c 
    #>  
    #> vsa [ft3]: volume of the entire stem, including top and stump
    #> dsob [in]: diameter of the stem, outside bark at breast height
    #> hst [ft]: total height of the stem
    #> 
    #> Parameter Estimates: 
    #> # A tibble: 1 × 3
    #>       a     b     c
    #>   <dbl> <dbl> <dbl>
    #> 1 -2.67  1.92  1.07
    #> 
    #> Model Descriptors: 
    #> # A tibble: 1 × 7
    #>   country region family     genus species geographic_region age_class
    #>   <chr>   <chr>  <chr>      <chr> <chr>   <chr>             <chr>    
    #> 1 US      US-WA  Betulaceae Alnus rubra   <NA>              <NA>

We can see from the `Model Call` section that `brackett_alnus_mod` will
require two covariates called `dsob`, which refers to diameter outside
bark at breast height, and `hst`, the height of the main stem.

**Predict Using the Selected Model**

Using the `predict()` method we can easily use the function as defined
by providing values of these two covariates.

``` r
predict(brackett_alnus_mod, 12, 65)
```

    #> [1] 22.2347

or we can use the prediction function with a data frame of values

``` r
my_trees <- data.frame(dias = c(12, 15, 20), heights = c(65, 75, 100))
predict(brackett_alnus_mod, my_trees$dias, my_trees$heights)
```

    #> [1] 22.23470 39.80216 94.20053

or even using the convenience of `dplyr`

``` r
my_trees %>%
  mutate(vols = predict(brackett_alnus_mod, dias, heights))
```

    #>   dias heights     vols
    #> 1   12      65 22.23470
    #> 2   15      75 39.80216
    #> 3   20     100 94.20053

## Next Steps

The following vignettes available on the [package
website](https://brycefrank.com/allometric/index.html) provide
information to two primary audiences.

Users interested in finding models for analysis will find the following
documentation most useful:

- [Common Inventory Use
  Cases](https://brycefrank.com/allometric/articles/inventory_example.html)
- `?allometric_models`

Users interested in **contributing models** to the package will find
these vignettes the most useful:

- [Installing a
  Model](https://brycefrank.com/allometric/articles/installing_a_model.html)
- [Describing a Model with
  Descriptors](https://brycefrank.com/allometric/articles/descriptors.html)
- [Variable Naming
  System](https://brycefrank.com/allometric/articles/variable_naming_system.html)
