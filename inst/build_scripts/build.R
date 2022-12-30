library(devtools)
library(tibble)
devtools::load_all(".")

source("./inst/build_scripts/1_update_pub_list.R")
source("./inst/build_scripts/2_update_allometric_models.R")
source("./inst/build_scripts/3_update_references.R")
source("./inst/build_scripts/4_update_reference_index.R")

# FIXME this crashes with a pandoc not available warning...yet runs if called
# from the command line
#devtools::build_readme()