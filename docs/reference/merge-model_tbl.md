---
title: "Merge a `model_tbl` with another data frame."
description: "This merge function ensures that, when `model_tbl` is used in a merge that the resultant dataframe is still a `model_tbl`."
---

This merge function ensures that, when `model_tbl` is used in a merge that the resultant dataframe is still a `model_tbl`.

## Usage

```r

## S3 method for class 'model_tbl':
merge(x, y, ...)
```

## Arguments

- **x** — A data frame or `model_tbl`

- **y** — A data frame or `model_tbl`

- **...** — Additional arguments passed to `merge`

## Value

A `model_tbl` merged with the inputs

