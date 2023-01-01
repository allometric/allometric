# build.R runs before each commit as a pre-commit hook. It verifies that all 
# models will compile (using 1 and 2) and updates the reference documentation
# (using 3 and 4)

library(devtools)
library(tibble)
library(dplyr)
library(RefManageR)
devtools::load_all(".")

# TODO will only work for my machine...
Sys.setenv(RSTUDIO_PANDOC="C:/Program Files/RStudio/resources/app/bin/quarto/bin/tools")

source("./inst/build_scripts/1_update_pub_list.R")
source("./inst/build_scripts/2_update_allometric_models.R")
source("./inst/build_scripts/3_update_references.R")
source("./inst/build_scripts/4_update_reference_index.R")

# FIXME this crashes with a pandoc not available warning...yet runs if called
# from the command line
devtools::build_readme()

