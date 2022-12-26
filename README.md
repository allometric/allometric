`allometric` is an open source R package for predicting tree attributes using
allometric models. Thousands of allometric models exist in the
scientific and technical forestry literature. `allometric` is a platform for
archiving and using this vast array of models in a robust and structured format.

`allometric` not only enables the use of allometric models for analysis, it 
also provides a structured language for adding models to the package. If you
are interested in helping the developer in this process please refer to the 
[Installing a Model] vignette.

## Installation

Currently `allometric` is only available on GitHub, and can be installed using
`devtools`.

```{r}
devtools::install_github('brycefrank/allometric')
```

## Getting Started

Most users will only be interested in finding and using allometric equations in
their analysis. Three basic steps are needed, 1) find the model you want
to use 2) determine what information is needed to use the model and 3) use the
model to make predictions.

### 1. Finding an Appropriate Model

Models can be searched by a variety of attributes including species 
(or more generally, "taxons"), geographic region, response variable, first
author's last name, or any combination therein.

Say we are interested in stem volume models for _Pseudotsuga menziesii_ that 
were developed in the United States. Using `model_search` we can quickly find 
all stem volume models for this species.

```{r}
library(allometric)

model_search(measure = 'volume', component = 'stem', country = 'US',
    genus = 'Pseudotsuga', species = 'menziesii')
```

```
```

### 2. Determing what Information is Needed

Allometric models require covariates given in the correct units.

