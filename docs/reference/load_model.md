---
title: "Load a single model by publication and model name"
description: "Returns the model identified by `pub_id` and `name`, e.g."
---

Returns the model identified by `pub_id` and `name`, e.g. `load_model("barnes_1962", "hstix50")`. The combination must identify a single model; model sets (multiple specifications sharing one functional form) are returned by `load_set()`.

## Usage

```r

load_model(pub_id, name)
```

## Arguments

- **pub_id** — A publication key, e.g. `"barnes_1962"`.

- **name** — The model name, e.g. `"hstix50"`.

## Value

The model object (e.g. a `FixedEffectsModel`).

