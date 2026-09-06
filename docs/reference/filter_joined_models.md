---
title: "Filter a joined v4 table before model reconstruction"
description: "Filters are applied on the joined table (before `build_model_tbl`), so only the requested models are ever constructed."
---

Filters are applied on the joined table (before `build_model_tbl`), so only the requested models are ever constructed. `model_type` is derived from the response name via `get_model_type()`; `country` and `region` are matched against the spec-level `spec_region` list column (region codes embed the country as a dash-prefixed code, e.g. `"US-CO"`).

## Usage

```r

filter_joined_models(joined, model_type = NULL, country = NULL, region = NULL)
```

## Arguments

- **joined** — The tibble returned by `join_model_tables()`

- **model_type** — An optional character vector of model types (e.g. `"stem volume"`). Only models whose response matches one of the given types are kept.

- **country** — An optional character vector of ISO country codes (e.g. `"CA"`). Region codes embed the country as a prefix (e.g. `"US-CO"`).

- **region** — An optional character vector of region codes (e.g. `"US-CO"`).

## Value

The filtered joined tibble

