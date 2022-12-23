`allometric` is an open source R platform for systematically archiving published 
allometric equations for tree attributes. This renders an easy-to-use
centralized location for allometric equations, with clear metadata attached to
each model that guides their use. `allometric` supports volume, taper, biomass,
and many other allometric models.

Users are able to add allometric models using GitHub pull requests,
provided the models are installed correctly. Read [Model Installation Guide]
for further instruction. Familiarity with `git` is helpful.

## Getting Started

Most users will only be interested in finding and using allometric equations in
their R package. This is a simple process thanks to the structure of the 
`allometric` package. Three basic steps are needed, 1) find the model you want
to use 2) determine what information is needed to use the model and 3) use the
model to make predictions.

### 1. Finding an Appropriate Model

Part of the attraction of `allometric` is that allometric models are 
systematically categorized, which allows for easy searching of models by 
species (or more generally, "taxons"), geographic region, response variable, 
first author's last name, or any combination therein.

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

