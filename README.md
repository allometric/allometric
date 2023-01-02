allometric
================

[![R-CMD-check](https://github.com/brycefrank/allometric/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/brycefrank/allometric/actions/workflows/check-standard.yaml)

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

Currently, `allometric` contains 85 allometric models across 6
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

    ## # A tibble: 6 × 13
    ##   id       component measure  country   region    family       genus      species model      pub_id        family_names covt_names pub_year
    ##   <chr>    <chr>     <chr>    <list>    <list>    <chr>        <chr>      <chr>   <list>     <chr>         <list>       <list>        <dbl>
    ## 1 39cb24c9 stem      volume   <chr [1]> <chr [1]> Aceraceae    Acer       <NA>    <FxdEffcM> brackett_1977 <chr [1]>    <chr [2]>      1977
    ## 2 07d06ce8 stem      volume   <chr [1]> <chr [1]> Betulaceae   Alnus      rubra   <FxdEffcM> brackett_1977 <chr [1]>    <chr [2]>      1977
    ## 3 32ec2493 stem      volume   <chr [1]> <chr [1]> Betulaceae   Betula     <NA>    <FxdEffcM> brackett_1977 <chr [1]>    <chr [2]>      1977
    ## 4 4767f5f6 stem      diameter <chr [1]> <chr [1]> Cupressaceae Calocedrus <NA>    <FxdEffcM> hann_2011     <chr [1]>    <chr [2]>      2011
    ## 5 a52441df stump     diameter <chr [1]> <chr [1]> Cupressaceae Calocedrus <NA>    <FxdEffcM> hann_2011     <chr [1]>    <chr [2]>      2011
    ## 6 4c82f4fc stem      volume   <chr [1]> <chr [1]> Cupressaceae Calocedrus <NA>    <FxdEffcM> hann_2011     <chr [1]>    <chr [3]>      2011

**Finding and Selecting a Model**

`allometric_models` is a `tibble::tbl_df` dataframe. Each row represents
one allometric model with various attributes. Some columns are `list`
columns, which are columns that contain lists with multiple values as
their elements. One example of this is the `family_names` column, which
contains the names of all authors for the publication that contains the
model.

`list` columns enable rigorous searching of models covered in the
[Advanced Model
Searching](https://brycefrank.com/allometric/articles/advanced_model_searching.html)
vignette, but to get started we will use a helper function called
`unnest_models` that will give us a clearer picture of the available
data.

``` r
unnested_models <- unnest_models(allometric_models)
unnested_models
```

    ## # A tibble: 372 × 13
    ##    id       component measure  country region family       genus      species model      pub_id        family_names covt_names pub_year
    ##    <chr>    <chr>     <chr>    <chr>   <chr>  <chr>        <chr>      <chr>   <list>     <chr>         <chr>        <chr>         <dbl>
    ##  1 39cb24c9 stem      volume   US      US-WA  Aceraceae    Acer       <NA>    <FxdEffcM> brackett_1977 Brackett     dsob           1977
    ##  2 39cb24c9 stem      volume   US      US-WA  Aceraceae    Acer       <NA>    <FxdEffcM> brackett_1977 Brackett     hst            1977
    ##  3 07d06ce8 stem      volume   US      US-WA  Betulaceae   Alnus      rubra   <FxdEffcM> brackett_1977 Brackett     dsob           1977
    ##  4 07d06ce8 stem      volume   US      US-WA  Betulaceae   Alnus      rubra   <FxdEffcM> brackett_1977 Brackett     hst            1977
    ##  5 32ec2493 stem      volume   US      US-WA  Betulaceae   Betula     <NA>    <FxdEffcM> brackett_1977 Brackett     dsob           1977
    ##  6 32ec2493 stem      volume   US      US-WA  Betulaceae   Betula     <NA>    <FxdEffcM> brackett_1977 Brackett     hst            1977
    ##  7 4767f5f6 stem      diameter US      US-OR  Cupressaceae Calocedrus <NA>    <FxdEffcM> hann_2011     Hann         dsob           2011
    ##  8 4767f5f6 stem      diameter US      US-OR  Cupressaceae Calocedrus <NA>    <FxdEffcM> hann_2011     Hann         rc             2011
    ##  9 a52441df stump     diameter US      US-OR  Cupressaceae Calocedrus <NA>    <FxdEffcM> hann_2011     Hann         dsob           2011
    ## 10 a52441df stump     diameter US      US-OR  Cupressaceae Calocedrus <NA>    <FxdEffcM> hann_2011     Hann         rc             2011
    ## # … with 362 more rows

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

    ## # A tibble: 2 × 13
    ##   id       component measure country region family     genus species model      pub_id        family_names covt_names pub_year
    ##   <chr>    <chr>     <chr>   <chr>   <chr>  <chr>      <chr> <chr>   <list>     <chr>         <chr>        <chr>         <dbl>
    ## 1 07d06ce8 stem      volume  US      US-WA  Betulaceae Alnus rubra   <FxdEffcM> brackett_1977 Brackett     dsob           1977
    ## 2 07d06ce8 stem      volume  US      US-WA  Betulaceae Alnus rubra   <FxdEffcM> brackett_1977 Brackett     hst            1977

we can see that model `07d06ce8` is a volume model written by Brackett
for *Alnus rubra*. The model can be selected using the `id` field:

``` r
brackett_alnus_mod <- brackett_alnus_vol %>% select_model("07d06ce8")
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

    ## Model Form: 
    ## vsa = 10^a * dsob^b * hst^c 
    ##  
    ## vsa [ft3]: volume of the entire stem, including top and stump
    ## dsob [in]: diameter of the stem, outside bark at breast height
    ## hst [ft]: total height of the stem
    ## 
    ## Parameter Estimates: 
    ##           a        b        c
    ## 1 -2.672775 1.920617 1.074024
    ## 
    ## Model Descriptors: 
    ##   country region     family genus species geographic_region age_class
    ## 1      US  US-WA Betulaceae Alnus   rubra              <NA>      <NA>

We can see here that `brackett_alnus_mod` will require two covariates
called `dsob`, which refers to diameter outside bark at breast height,
and `hst`, the height of the main stem.

**Predict Using the Selected Model**

Using the `predict` method we can easily use the function as defined by
providing values of these two covariates.

``` r
predict(brackett_alnus_mod, 12, 65)
```

    ## [1] 22.2347

or we can use the prediction function with a data frame of values

``` r
my_trees <- data.frame(dias = c(12, 15, 20), heights = c(65, 75, 100))
predict(brackett_alnus_mod, my_trees$dias, my_trees$heights)
```

    ## [1] 22.23470 39.80216 94.20053

or even using the convenience of `dplyr`

``` r
my_trees %>%
  mutate(vols = predict(brackett_alnus_mod, dias, heights))
```

    ##   dias heights     vols
    ## 1   12      65 22.23470
    ## 2   15      75 39.80216
    ## 3   20     100 94.20053

This is all that is needed to make predictions using the models stored
in `allometric`. Please refer to the following vignettes for further
possibilities with this package.
