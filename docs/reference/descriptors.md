---
title: "Get the descriptors of a model"
description: "The model descriptors describe the context of an allometric model as it is situated within a publication, and contain information like family, genus, species, geographic region, etc."
---

The model descriptors describe the context of an allometric model as it is situated within a publication, and contain information like family, genus, species, geographic region, etc. This function returns this information for a given model.

## Usage

```r

descriptors(object)

## S4 method for signature 'ParametricSet':
descriptors(object)

## S4 method for signature 'ParametricModel':
descriptors(object)
```

## Arguments

- **object** — The allometric model or model set object

## Value

A tibble:tbl_df of descriptors

