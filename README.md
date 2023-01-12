
# allometric <a href="https://brycefrank.com/allometric/"><img src='man/figures/logo.png' align="right" height="139" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/brycefrank/allometric/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/brycefrank/allometric/actions/workflows/check-standard.yaml)
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

Currently, `allometric` contains 383 allometric models across 18
publications. Refer to the
[Reference](https://brycefrank.com/allometric/reference/index.html) for
a full list of publications disaggregated by allometric model type.

**`allometric` is currently in a pre-release state. If you are
interested in collaboration (adding models or working on the package
functions) please email me at <bfrank70@gmail.com>**

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

    #> # A tibble: 6 × 13
    #>   id       component measure country   region    family        genus    species     model      pub_id        family_name covt_name pub_year
    #>   <chr>    <chr>     <chr>   <list>    <list>    <chr>         <chr>    <chr>       <list>     <chr>         <list>      <list>       <dbl>
    #> 1 3aff0a28 stem      volume  <chr [1]> <chr [1]> Aceraceae     Acer     <NA>        <FxdEffcM> brackett_1977 <chr [1]>   <chr [2]>     1977
    #> 2 2963f44d stem      volume  <chr [1]> <chr [1]> Anacardiaceae Tapirira guianensis  <FxdEffcM> vibrans_2015  <chr [4]>   <chr [2]>     2015
    #> 3 fc847c75 tree      biomass <chr [1]> <chr [1]> Aquifoliaceae Ilex     canariensis <FxdEffcM> montero_2005  <chr [3]>   <chr [1]>     2005
    #> 4 1460a26f stem      biomass <chr [1]> <chr [1]> Aquifoliaceae Ilex     canariensis <FxdEffcM> montero_2005  <chr [3]>   <chr [1]>     2005
    #> 5 49464def branch    biomass <chr [1]> <chr [1]> Aquifoliaceae Ilex     canariensis <FxdEffcM> montero_2005  <chr [3]>   <chr [1]>     2005
    #> 6 4ddc8d53 branch    biomass <chr [1]> <chr [1]> Aquifoliaceae Ilex     canariensis <FxdEffcM> montero_2005  <chr [3]>   <chr [1]>     2005

**Finding and Selecting a Model**

`allometric_models` is a `tibble::tbl_df` dataframe. Each row represents
one allometric model with various attributes. Some columns are `list`
columns, which are columns that contain lists with multiple values as
their elements. One example of this is the `family_name` column, which
contains the names of all authors for the publication that contains the
model.

`list` columns enable rigorous searching of models covered in the
[Advanced Model
Searching](https://brycefrank.com/allometric/articles/advanced_searching.html)
vignette, but to get started we will use a helper function called
`unnest_models()` that will give us a clearer picture of the available
data. Using the `cols` argument we can specify which columns we want to
unnest. In this case we will unnest the `family_name` column.

``` r
unnested_models <- unnest_models(allometric_models, cols = 'family_name')
unnested_models
```

    #> # A tibble: 1,171 × 13
    #>    id       component measure country   region    family        genus    species     model      pub_id        family_name                 covt_name pub_year
    #>    <chr>    <chr>     <chr>   <list>    <list>    <chr>         <chr>    <chr>       <list>     <chr>         <chr>                       <list>       <dbl>
    #>  1 3aff0a28 stem      volume  <chr [1]> <chr [1]> Aceraceae     Acer     <NA>        <FxdEffcM> brackett_1977 "Brackett"                  <chr [2]>     1977
    #>  2 2963f44d stem      volume  <chr [1]> <chr [1]> Anacardiaceae Tapirira guianensis  <FxdEffcM> vibrans_2015  "Vibrans"                   <chr [2]>     2015
    #>  3 2963f44d stem      volume  <chr [1]> <chr [1]> Anacardiaceae Tapirira guianensis  <FxdEffcM> vibrans_2015  "Moser"                     <chr [2]>     2015
    #>  4 2963f44d stem      volume  <chr [1]> <chr [1]> Anacardiaceae Tapirira guianensis  <FxdEffcM> vibrans_2015  "Oliveira"                  <chr [2]>     2015
    #>  5 2963f44d stem      volume  <chr [1]> <chr [1]> Anacardiaceae Tapirira guianensis  <FxdEffcM> vibrans_2015  "c(\"de\", \"MaÃ§aneiro\")" <chr [2]>     2015
    #>  6 fc847c75 tree      biomass <chr [1]> <chr [1]> Aquifoliaceae Ilex     canariensis <FxdEffcM> montero_2005  "Montero"                   <chr [1]>     2005
    #>  7 fc847c75 tree      biomass <chr [1]> <chr [1]> Aquifoliaceae Ilex     canariensis <FxdEffcM> montero_2005  "Ruiz-Peinado"              <chr [1]>     2005
    #>  8 fc847c75 tree      biomass <chr [1]> <chr [1]> Aquifoliaceae Ilex     canariensis <FxdEffcM> montero_2005  "Munoz"                     <chr [1]>     2005
    #>  9 1460a26f stem      biomass <chr [1]> <chr [1]> Aquifoliaceae Ilex     canariensis <FxdEffcM> montero_2005  "Montero"                   <chr [1]>     2005
    #> 10 1460a26f stem      biomass <chr [1]> <chr [1]> Aquifoliaceae Ilex     canariensis <FxdEffcM> montero_2005  "Ruiz-Peinado"              <chr [1]>     2005
    #> # … with 1,161 more rows

Now, each row represents unique data combinations for each model, which
can be quickly filtered by most users using `dplyr::filter`. For
example, to find a volume model for the genus Alnus that had
`"Brackett"` as an author or co-author we can use

``` r
brackett_alnus_vol <- unnested_models %>%
  dplyr::filter(family_name == "Brackett", measure == "volume",
    genus == "Alnus")

brackett_alnus_vol
```

    #> # A tibble: 1 × 13
    #>   id       component measure country   region    family     genus species model      pub_id        family_name covt_name pub_year
    #>   <chr>    <chr>     <chr>   <list>    <list>    <chr>      <chr> <chr>   <list>     <chr>         <chr>       <list>       <dbl>
    #> 1 6de9245e stem      volume  <chr [1]> <chr [1]> Betulaceae Alnus rubra   <FxdEffcM> brackett_1977 Brackett    <chr [2]>     1977

we can see that model `6de9245e` is a volume model written by Brackett
for *Alnus rubra*. The model can be selected using the `id` field:

``` r
brackett_alnus_mod <- brackett_alnus_vol %>% select_model("6de9245e")
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

We can see here that `brackett_alnus_mod` will require two covariates
called `dsob`, which refers to diameter outside bark at breast height,
and `hst`, the height of the main stem.

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

Users interested in conducting analysis will find this vignette most
useful:

- [Advanced Model
  Searching](https://brycefrank.com/allometric/articles/advanced_searching.html)

Users interested in **contributing models** to the package will find
these vignettes the most useful:

- [Installing a
  Model](https://brycefrank.com/allometric/articles/installing_a_model.html)
- [Describing a Model with
  Descriptors](https://brycefrank.com/allometric/articles/descriptors.html)
- [Variable Naming
  System](https://brycefrank.com/allometric/articles/variable_naming_system.html)
