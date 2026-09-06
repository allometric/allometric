---
title: "Load the locally installed table of allometric models"
description: "This function loads all locally installed allometric models if they are downloaded and installed, if not run the `install_models` function."
---

This function loads all locally installed allometric models if they are downloaded and installed, if not run the `install_models` function. The result is of class `model_tbl`, which behaves very much like a `tibble::tbl_df` or a `data.frame`.

## Usage

```r

load_models(model_type = NULL, country = NULL, region = NULL)
```

## Arguments

- **model_type** — An optional character vector of model types to load (e.g. `"stem height"`, `"stem volume"`). Only models whose type appears in this vector are loaded.

- **country** — An optional character vector of ISO 3166-1 alpha-2 country codes (e.g. `"US"`, `"CA"`, `"ES"`). Only models whose regions fall within the given countries are loaded. Region codes embed the country as a prefix (e.g. `"US-CO"`).

- **region** — An optional character vector of region codes (e.g. `"US-CO"`). Only models whose regions match are loaded.

## Value

A model_tbl containing the locally installed models that match the given filters (or all models if no filters are supplied).

## Details

Printing the `head` of `allometric_models`, we can see the structure of the data

```r
allometric_models <- load_models()
head(allometric_models)
```

The columns are:

- `id` - A unique ID for the model. This is the 8-character content hash assigned by the v4 model compilation pipeline.
- `spec_index` - The index of the specification within its model set (0 for single models). Together with `id` this uniquely identifies a model.
- `model_name` - The name of the model or model set.
- `model_type` - The type of model (e.g., stem volume, site index, etc.)
- `pub_id` - A unique ID representing the publication.
- `pub_year` - The publication year.
- `family_name` - The names of the contributing authors.
- `covt_name` - The names of the covariates used in the model.
- `taxa` - The taxonomic specification of the trees that are modeled.
- `region` - The region or regions (e.g., state, province, etc.) from which the model data is from.
- `component` - The tree component modeled (e.g., stem, branch).
- `model` - The model object itself.

Models can be searched by their attributes. Note that some of the columns are `list` columns, which contain lists as their elements. Filtering on data in these columns requires the use of `purrr::map_lgl` which is used to determine truthiness of expressions for each element in a `list` column. While this may seem complicated, we believe the nested data structures are more descriptive and concise for storing the models, and users will quickly find that searching models in this way can be very powerful.

## Finding Contributing Authors

Using `purr::map_lgl` to filter the `family_name` column, we are able to find publications that contain specific authors of interst. For example, we may want models only authored by `"Hann"`. This is elementary to do in `allometric`:

```r
hann_models <- dplyr::filter(
 allometric_models,
 purrr::map_lgl(family_name, ~ 'Hann' %in% .)
)

head(hann_models)
nrow(hann_models)
```

Picking apart the above code block, we see that we are using the standard `dplyr::filter` function on the `allometric_models` dataframe. The second argument is a call using `purrr:map_lgl`, which will map over each list (contained as elements in the `family_names` column). The second argument to this function, `~ 'Hann' %in%.` is itself a function that checks if `'Hann'`

is in the current list. Imagine we are marching down each row of `allometric_models`, `.` represents the element of `family_names` we are considering, which is itself a list of author names.

## Finding First Authors

Maybe we are only interested in models where `'Hann'` is the first author. Using a simple modification we can easily do this.

```r
hann_first_author_models <- dplyr::filter(
  allometric_models,
  purrr::map_lgl(family_name, ~ 'Hann' == .[[1]])
)

head(hann_first_author_models)
nrow(hann_first_author_models)
```

We can see that `'Hann'` is the first author for `r nrow(hann_first_author_models)` models in this package.

## Finding Models for a Given Species

One of the most common things people need is a model for a particular species. For this, we must interact with the `taxa` column. For example, to find models for the Pinus genus we can use

```r
pinus_models <- dplyr::filter(
 allometric_models,
 purrr::map_lgl(taxa, ~ "Pinus" %in% .)
)

head(pinus_models)
nrow(pinus_models)
```

Users can also search with a specific taxon, which allows a full specification from family to species. For example, if we want models that apply to Ponderosa pine, first declare the necessary taxon, then use it to filter as before

```r
ponderosa_taxon <- Taxon(
 family = "Pinaceae", genus = "Pinus", species = "ponderosa"
)

ponderosa_models <- dplyr::filter(
 allometric_models,
 purrr::map_lgl(taxa, ~ ponderosa_taxon %in% .)
)

nrow(ponderosa_models)
```

## Finding a Model with Specific Data Requirements

We can even check for models that contain certain types of data requirements. For example, the following block finds diameter-height models, specifically models that use diameter outside bark at breast height as the *only*

covariate. The utility here is obvious, since many inventories are vastly limited by their available tree measurements.

```r
dia_ht_models <- dplyr::filter(
    allometric_models,
    model_type == 'stem height',
    purrr::map_lgl(covt_name, ~ length(.)==1 & .[[1]] == 'dsob'),
)

nrow(dia_ht_models)
```

Breaking this down, we have the first condition `model_type=='stem_height'`

selecting only models concerned with stem heights as a response variable. The second line maps over each element of the `covt_name` column, which is a character vector. The `.` represents a given character vector for that row. First, we ensure that the vector is only one element in size using `length(.)==1`, then we ensure that the first (and only) element of this vector is equal to `'dsob'`, (diameter outside bark at breast height). In this case, `r nrow(dia_ht_models)` are available in the package.

## Finding a Model for a Region

By now the user should be sensing a pattern. We can apply the exact same logic as the *Finding Contributing Authors* section to find all models developed using data from `US-CO`

```r
us_co_models <- dplyr::filter(
    allometric_models,
    purrr::map_lgl(region, ~ "US-CO" %in% .),
)

nrow(us_co_models)
```

## Loading a Subset of Models

Loading every model reconstructs the full ~2400-model table, which is slow and memory-heavy. Pass `model_type`, `country`, or `region` to load only the models you need. The filters are applied before the model objects are constructed, so a filtered load never materializes the models it excludes. All three filters are optional and may be combined.

For example, to load only stem-height models:

```r
ht_models <- load_models(model_type = "stem height")

nrow(ht_models)
```

Or only models from the state of Colorado, US:

```r
us_co_models <- load_models(region = "US-CO")

nrow(us_co_models)
```

Or only models from Canada:

```r
canada_models <- load_models(country = "CA")

nrow(canada_models)
```

