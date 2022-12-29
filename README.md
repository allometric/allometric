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

Currently, `allometric` contains 59 across 7 taxonomic families and 15
taxonomic genera.

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
df_wa_models <- filter_models(
    model_data,
    genus == 'Pseudotsuga',
    species == 'menziesii',
    country == 'US',
    region == "US-WA"
)

df_wa_models
```

Here we see that three models are available from the Brackett (1977)
report. We will select the third model using `select_model`.

``` r
df_mod <- df_wa_models %>% select_model(3)
```

**Determine Needed Information**

Using the standard output of `df_mod` we obtain a summary of the model
form, the response variable, the needed covariates and their units, a
summary of the model specification (i.e., what makes the model unique
within the publication), and estimates of the parameters.

``` r
df_mod
```

We can see here that `df_mod` will require two covariates called `dsob`,
which refers to diameter outside bark at breast height, and `hst`, the
height of the main stem.

**Predict Using the Selected Model**

Using the `predict` method we can easily use the function as defined by
providing values of these two covariates.

``` r
predict(df_mod, 12, 65)
```

or we can use the prediction function with a data frame of values

``` r
my_trees <- data.frame(dias = c(12, 15, 20), heights = c(65, 75, 100))
predict(df_mod, my_trees$dias, my_trees$heights)
```

or even using the convenience of `dplyr`

``` r
my_trees %>%
    mutate(vols = predict(df_mod, dias, heights))
```

This is all that is needed to make predictions using the models stored
in `allometric`. Please refer to the following vignettes for further
possibilities with this package.
