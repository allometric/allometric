library(devtools)
library(tibble)
devtools::load_all('.')

source('./build_scripts/1_update_pub_list.R')
source('./build_scripts/2_update_allometric_models.R')
source('./build_scripts/3_update_references.R')
source('./build_scripts/4_update_reference_index.R')
