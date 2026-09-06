---
title: "Unnest the taxa column of a `model_tbl`"
description: "In some cases it is convenient to expand the taxonomic specifications for each model contained in the `taxa` column."
---

In some cases it is convenient to expand the taxonomic specifications for each model contained in the `taxa` column. This function achieves this, and adds `family`, `genus`, and `species` character columns. Models with more than one taxon are replicated as new rows.

## Usage

```r

unnest_taxa(data)
```

## Arguments

- **data** — A `model_tbl`

## Value

A `model_tbl` with family, genus and species columns attached

