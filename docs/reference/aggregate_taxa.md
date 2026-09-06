---
title: "Aggregate family, genus, and species columns of `tbl_df`` into taxa data structure"
description: "This function facilitates aggregating family, genus, and species columns into the taxa data structure, which is a nested list composed of multiple 'taxons'."
---

This function facilitates aggregating family, genus, and species columns into the taxa data structure, which is a nested list composed of multiple "taxons". A taxon is a list containing family, genus, and species fields.

## Usage

```r

aggregate_taxa(table, grouping_col = NULL)
```

## Arguments

- **table** — The table for which the taxa will be aggregated

- **grouping_col** — An optional column to group on when creating taxa. Rows with the same grouping_col value will be stored into the same taxa.

## Value

A tibble with family, genus, and species columns added

