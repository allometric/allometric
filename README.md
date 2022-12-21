`allometric` is an open source R platform for systematically archiving 
allometric equations for tree attributes. The over-arching objective of 
`allometric` is to establish a framework for the storage and use of allometric
equations on a global scale. This renders an easy-to-use centralized location
for allometric equations, with clear implementations that can be validatedd
using open source software techniques.

Interested users are able to add allometric models using GitHub pull requests,
provided the models are instantiated correctly. Read [Model Installation Guide]
for further instruction. Familiarity with git is helpful.

## Quick Start

### Finding an Appropriate Model

Part of the attraction of `allometric` is that allometric models are 
systematically categorized, which allows for easy searching of models by 
species (or more generally, "taxons"), geographic region, response variable, 
etc.

```{r}
library(allometric)

model_search(measure = 'volume', country = 'US', author = 'brackett')
```