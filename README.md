`allometric` is an open source R platform for systematically archiving 
allometric equations for tree attributes. The over-arching objective of 
`allometric` is to establish a framework for the storage and use of allometric
equations on a global scale. This renders an easy-to-use centralized location
for allometric equations, with clear implementations that can be validatedd
using open source software techniques.

Interested users are able to add allometric models using GitHub pull requests,
provided the models are instantiated correctly. Read [Model Installation Guide]
for further instruction. Familiarity with git is helpful.

## Systematic Naming Convention

Archiving existing allometric models requires a unified approach to refer to
each model in a clear and concise way. This motivates a naming convention for
allometric models. This naming convention should communicate:

1. What is being modeled, i.e., the response variable,
2. Who published the model,
3. When the model was published,
4. What model is being referred to within a given publication

In support of this, `allometric` uses the following naming convention:

`[response_name]_[publication_name]_[publication_year][[publication_modifer]]_[model_id]`

where `response_name` refers to the name of the response variable (see 
"Composing Response Names" below) and `publication_name` refers to the name of
the publication. By convention, the last name of the first author should be 
used unless one is not available (for example, a government report without
listed authors).

The first three components form the response_name-publication pairing, which
is used to name and organize files in the `R` directory. The 
`model_id` allows the user to specify a model within a publication.
See the "Composing Publication Modifiers" section for further information.

For example, Temesgen, Monleon, and Hann (2008) fit several diameter-height
models for Douglas-fir. The response_name-publication pairing is then

`ht_temesgen_2008`

which corresponds to the `R/ht_temesgen_2008.R` file, which stores the models. 
Inside this file are several implementations of the models fit in the study. 
Models within this paper are referred to by a unique `model_id`, 
which is an integer that is sequentially assigned to models as they appear in
the publication. `model_id` is not holy, and is primarily used to
uniquely identify models within a publication. Ultimately it is up to the end
user to verify that they are using the correct model. Finally, an optional 
`publication_modifier` is allowable to differentiate papers with the same 
first author published in the same year. Users should use lower-case alphabetic
modifiers, e.g., `ht_doe_2008a` and `ht_doe_2008b`.

## Composing Variable Names

This standard set of names is used either for the response name or for covariate
names.

Variable names are themselves composed of multiple components, but are not 
delineated by periods. A variable name is composed as

`[measure][location][[modifier]]`

For example, the diameter inside bark at breast height is composed of the 
measure "d", the location "ib" for inside bark and the modifer "bh" representing
breast height.

## Measures

- d: diameter
- v: volume
- h: height
    - t: total
- db: dry biomass (weight)
- gb: green biomass (weight)
- ba: basal area

## Locations & Modifiers

- ht: at a given height
- ib: inside bark
    - bh: at breast height
- ob: outside bark
    - bh: at breast height
- s:  main stem
    - g: gross
    - m: merchantable
    - n: net
    - s: including stump
    - t: including top
- br: branches
- fo: foliage (leaves)
- st: stand-level variable
- pl: plot-level variable

## Examples

- dibbh: diameter inside bark at breast height
- dibht: diameter inside bark at arbitrary height (taper) 
- dobbh: diameter outside bark at breast height
- dobht: diameter outside bark at arbitrary height (taper) 
- ht: height total
- vsg: gross volume of the main stem
- vsm: merchantable volume of the main stem
- dbbr: dry biomass of branches
- dbfo: dry biomass of foliage
- bast: basal area of stand
