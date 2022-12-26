library(devtools)
devtools::load_all('.')

source('./build_scripts/update_local_models.R')
source('./build_scripts/update_references.R')
source('./build_scripts/update_reference_index.R')