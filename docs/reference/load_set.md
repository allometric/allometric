---
title: "Load a model set by publication and set name"
description: "Returns every specification of the model set identified by `pub_id` and `name`, e.g."
---

Returns every specification of the model set identified by `pub_id` and `name`, e.g. `load_set("barrett_2006", "hst")`, as a `model_tbl` with one row per specification. A single model is returned as a one-row `model_tbl`; use `load_model()` to get the model object directly.

## Usage

```r

load_set(pub_id, name)
```

## Arguments

- **pub_id** — A publication key, e.g. `"barrett_2006"`.

- **name** — The set name, e.g. `"hst"`.

## Value

A `model_tbl` with one row per specification.

