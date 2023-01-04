
# allometric <a href="https://brycefrank.com/allometric/"><img src='man/figures/logo.png' align="right" height="139" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/brycefrank/allometric/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/brycefrank/allometric/actions/workflows/check-standard.yaml)
<!-- badges: end -->

`allometric` is an open source R package for predicting tree attributes
using allometric models. Thousands of allometric models exist in the
scientific and technical forestry literature. `allometric` is a platform
for archiving and using this vast array of models in a robust and
structured format.

`allometric` not only enables the use of allometric models for analysis,
it also provides a structured language for adding models to the package.
If you are interested in helping the developer in this process please
refer to the [Installing a
Model](https://brycefrank.com/allometric/articles/installing_a_model.html)
vignette.

Currently, `allometric` contains 103 allometric models across 10
publications.

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
`install_models` only needs to be ran at installation, or following any
package updates. After running this function, the models are available
in the variable `allometric_models`.

``` r
head(allometric_models)
```

    #> # A tibble: 6 × 13
    #>   id       component measure  country   region    family       genus      species model      pub_id        family_names covt_names pub_year
    #>   <chr>    <chr>     <chr>    <list>    <list>    <chr>        <chr>      <chr>   <list>     <chr>         <list>       <list>        <dbl>
    #> 1 b946c15c stem      volume   <chr [1]> <chr [1]> Aceraceae    Acer       <NA>    <FxdEffcM> brackett_1977 <chr [1]>    <chr [2]>      1977
    #> 2 0d046a1d stem      volume   <chr [1]> <chr [1]> Betulaceae   Alnus      rubra   <FxdEffcM> brackett_1977 <chr [1]>    <chr [2]>      1977
    #> 3 0ce6aca9 stem      diameter <chr [2]> <chr [3]> Betulaceae   Alnus      rubra   <FxdEffcM> hibbs_2007    <chr [3]>    <chr [3]>      2007
    #> 4 095a3821 stem      volume   <chr [1]> <chr [1]> Betulaceae   Betula     <NA>    <FxdEffcM> brackett_1977 <chr [1]>    <chr [2]>      1977
    #> 5 adeaf86e stem      diameter <chr [1]> <chr [1]> Cupressaceae Calocedrus <NA>    <FxdEffcM> hann_2011     <chr [1]>    <chr [2]>      2011
    #> 6 f85c0bd6 stump     diameter <chr [1]> <chr [1]> Cupressaceae Calocedrus <NA>    <FxdEffcM> hann_2011     <chr [1]>    <chr [2]>      2011

**Finding and Selecting a Model**

`allometric_models` is a `tibble::tbl_df` dataframe. Each row represents
one allometric model with various attributes. Some columns are `list`
columns, which are columns that contain lists with multiple values as
their elements. One example of this is the `family_names` column, which
contains the names of all authors for the publication that contains the
model.

`list` columns enable rigorous searching of models covered in the
[Advanced Model
Searching](https://brycefrank.com/allometric/articles/advanced_searching.html)
vignette, but to get started we will use a helper function called
`unnest_models` that will give us a clearer picture of the available
data.

``` r
unnested_models <- unnest_models(allometric_models)
unnested_models
```

    #> # A tibble: 714 × 13
    #>    id       component measure  country region family     genus species model      pub_id        family_names covt_names pub_year
    #>    <chr>    <chr>     <chr>    <chr>   <chr>  <chr>      <chr> <chr>   <list>     <chr>         <chr>        <chr>         <dbl>
    #>  1 b946c15c stem      volume   US      US-WA  Aceraceae  Acer  <NA>    <FxdEffcM> brackett_1977 Brackett     dsob           1977
    #>  2 b946c15c stem      volume   US      US-WA  Aceraceae  Acer  <NA>    <FxdEffcM> brackett_1977 Brackett     hst            1977
    #>  3 0d046a1d stem      volume   US      US-WA  Betulaceae Alnus rubra   <FxdEffcM> brackett_1977 Brackett     dsob           1977
    #>  4 0d046a1d stem      volume   US      US-WA  Betulaceae Alnus rubra   <FxdEffcM> brackett_1977 Brackett     hst            1977
    #>  5 0ce6aca9 stem      diameter US      US-OR  Betulaceae Alnus rubra   <FxdEffcM> hibbs_2007    Hibbs        dsob           2007
    #>  6 0ce6aca9 stem      diameter US      US-OR  Betulaceae Alnus rubra   <FxdEffcM> hibbs_2007    Hibbs        hst            2007
    #>  7 0ce6aca9 stem      diameter US      US-OR  Betulaceae Alnus rubra   <FxdEffcM> hibbs_2007    Hibbs        hsd            2007
    #>  8 0ce6aca9 stem      diameter US      US-OR  Betulaceae Alnus rubra   <FxdEffcM> hibbs_2007    Bluhm        dsob           2007
    #>  9 0ce6aca9 stem      diameter US      US-OR  Betulaceae Alnus rubra   <FxdEffcM> hibbs_2007    Bluhm        hst            2007
    #> 10 0ce6aca9 stem      diameter US      US-OR  Betulaceae Alnus rubra   <FxdEffcM> hibbs_2007    Bluhm        hsd            2007
    #> # … with 704 more rows

Now, each row represents unique data combinations for each model, which
can be quickly filtered by most users using `dplyr::filter`. For
example, to find a volume model for the genus Alnus that had
`"Brackett"` as an author or co-author we can use

``` r
brackett_alnus_vol <- unnested_models %>%
  dplyr::filter(family_names == "Brackett", measure=="volume",
    genus=="Alnus")

brackett_alnus_vol
```

    #> # A tibble: 2 × 13
    #>   id       component measure country region family     genus species model      pub_id        family_names covt_names pub_year
    #>   <chr>    <chr>     <chr>   <chr>   <chr>  <chr>      <chr> <chr>   <list>     <chr>         <chr>        <chr>         <dbl>
    #> 1 0d046a1d stem      volume  US      US-WA  Betulaceae Alnus rubra   <FxdEffcM> brackett_1977 Brackett     dsob           1977
    #> 2 0d046a1d stem      volume  US      US-WA  Betulaceae Alnus rubra   <FxdEffcM> brackett_1977 Brackett     hst            1977

we can see that model `0d046a1d` is a volume model written by Brackett
for *Alnus rubra*. The model can be selected using the `id` field:

``` r
brackett_alnus_mod <- brackett_alnus_vol %>% select_model("0d046a1d")
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

    #> Model Form: 
    #> vsa = 10^a * dsob^b * hst^c 
    #>  
    #> vsa [ft3]: volume of the entire stem, including top and stump
    #> dsob [in]: diameter of the stem, outside bark at breast height
    #> hst [ft]: total height of the stem
    #> 
    #> Parameter Estimates: 
    #>           a        b        c
    #> 1 -2.672775 1.920617 1.074024
    #> 
    #> Model Descriptors: 
    #>   country region     family genus species geographic_region age_class
    #> 1      US  US-WA Betulaceae Alnus   rubra              <NA>      <NA>

We can see here that `brackett_alnus_mod` will require two covariates
called `dsob`, which refers to diameter outside bark at breast height,
and `hst`, the height of the main stem.

**Predict Using the Selected Model**

Using the `predict` method we can easily use the function as defined by
providing values of these two covariates.

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

This is all that is needed to make predictions using the models stored
in `allometric`. Please refer to the following vignettes for further
possibilities with this package.
