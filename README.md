allometric
================

`allometric` is an open source R package for predicting tree attributes
using allometric models. Thousands of allometric models exist in the
scientific and technical forestry literature. `allometric` is a platform
for archiving and using this vast array of models in a robust and
structured format.

`allometric` not only enables the use of allometric models for analysis,
it also provides a structured language for adding models to the package.
If you are interested in helping the developer in this process please
refer to the \[Installing a Model\] vignette.

Currently, `allometric` contains 59 allometric models across 5
publications.

## Installation

Currently `allometric` is only available on GitHub, and can be installed
using `devtools`.

``` r
devtools::install_github('brycefrank/allometric')
```

## Getting Started

Most users will only be interested in finding and using allometric
equations in their analysis. Three basic steps are needed, 1) find the
model you want to use 2) determine what information is needed to use the
model and 3) use the model to make predictions.

**Finding an Appropriate Model**

Models can be searched by a variety of attributes including species (or
more generally, “taxons”), geographic region, response variable, first
author’s last name, or any combination therein.

Say we are interested in stem volume models for *Pseudotsuga menziesii*
that were developed in the United States. Using `model_search` we can
quickly find all stem volume models for this species.

``` r
df_vol_models <- filter(
    allometric_models,
    genus == 'Pseudotsuga',
    species == 'menziesii',
    measure == "volume"
)

df_vol_models
```

    ## # A tibble: 3 × 12
    ##   compo…¹ country covt_…² family famil…³ genus measure model      pub_id pub_y…⁴
    ##   <chr>   <list>  <list>  <chr>  <list>  <chr> <chr>   <list>     <chr>    <dbl>
    ## 1 stem    <chr>   <chr>   Pinac… <chr>   Pseu… volume  <FxdEffcM> brack…    1977
    ## 2 stem    <chr>   <chr>   Pinac… <chr>   Pseu… volume  <FxdEffcM> brack…    1977
    ## 3 stem    <chr>   <chr>   Pinac… <chr>   Pseu… volume  <FxdEffcM> brack…    1977
    ## # … with 2 more variables: region <list>, species <chr>, and abbreviated
    ## #   variable names ¹​component, ²​covt_names, ³​family_names, ⁴​pub_year

Here we see that three models are available from the Brackett (1977)
report. We will select the third model using `select_model`.

``` r
df_mod <- df_vol_models %>% select_model(3)
```

**Determine Needed Information**

Using the standard output of `df_mod` we obtain a summary of the model
form, the response variable, the needed covariates and their units, a
summary of the model specification (i.e., what makes the model unique
within the publication), and estimates of the parameters.

``` r
df_mod
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
    ## 1 -2.734532 1.739418 1.166033
    ## 
    ## Model Specification: 
    ##   country region   family       genus   species region.1 age_class         a
    ## 1      US  US-WA Pinaceae Pseudotsuga menziesii interior      <NA> -2.734532
    ##          b        c
    ## 1 1.739418 1.166033

We can see here that `df_mod` will require two covariates called `dsob`,
which refers to diameter outside bark at breast height, and `hst`, the
height of the main stem.

**Predict Using the Selected Model**

Using the `predict` method we can easily use the function as defined by
providing values of these two covariates.

``` r
predict(df_mod, 12, 65)
```

    ## [1] 18.05228

or we can use the prediction function with a data frame of values

``` r
my_trees <- data.frame(dias = c(12, 15, 20), heights = c(65, 75, 100))
predict(df_mod, my_trees$dias, my_trees$heights)
```

    ## [1] 18.05228 31.44601 72.53857

or even using the convenience of `dplyr`

``` r
my_trees %>%
    mutate(vols = predict(df_mod, dias, heights))
```

    ##   dias heights     vols
    ## 1   12      65 18.05228
    ## 2   15      75 31.44601
    ## 3   20     100 72.53857

This is all that is needed to make predictions using the models stored
in `allometric`. Please refer to the following vignettes for further
possibilities with this package.
