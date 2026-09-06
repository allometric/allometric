---
title: "Create a publication that contains allometric models"
description: "`Publication` represents a technical or scientific document that contains allometric models."
---

`Publication` represents a technical or scientific document that contains allometric models. Initially, publications do not contain models, and models are added using the `add_model` or `add_set` methods.

## Usage

```r

Publication(citation, descriptors = list())
```

## Arguments

- **citation** — The citation of the paper declared using the `RefManageR::BibEntry` class

- **descriptors** — A named list of descriptors that are defined for all models contained in the publication.

## Value

An instance of class Publication

## Slots

- **`citation`** — A `RefManageR::BibEntry` of the reference publication
- **`response_sets`** — A list containing the model sets indexed by the response variable names
- **`descriptors`** — A named list containing descriptors that are defined for all models in the publication.

## Examples

```r

pub <- Publication(
  citation = RefManageR::BibEntry(
    key = "test_2000",
    bibtype = "article",
    author = "test",
    title = "test",
    journal = "test",
    year = 2000,
    volume = 0
  ),
  descriptors = list(
    region = "US-WA"
  )
)
```

