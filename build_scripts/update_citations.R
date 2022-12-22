



# TODO using parse, we can get a list of assignments in an R file
# use is.call(expr), and the third argument expr[[3]] to check if the name
# contains "Allometric". This should be enough to find all declared allometric
# equations in a file.

# From here we build a list of all named allometric equations in the package,
# and these will be used to make the keys of a .bib file, which we will then
# write by calling the mod_bibtex slot of each model.

# At the end, we have a .bib file we can use in the docstrings themselves,
# and elsewhere in the documentation and package if we want...imagine being
# able to search by author or publication year! Exciting.
devtools::load_all('.') # Ensures that the model names are loaded as objects
library(stringr)
library(bibtex)
library(RefManageR)

black_list <- c(
  'AllometricModel.R',
  'ParametricModel.R',
  'AllometricFamily.R',
  'ParametricFamily.R'
)


get_coded_bibkeys_file <- function(file_path) {
  coded_bibkeys <- list()
  expressions <- parse(file_path)
  for(i in seq_along(expressions)) {
    expression <- expressions[[i]]
    expr_call <- expression[[3]][[1]]
    if(expr_call == 'ParametricModel') {
      bibcitation <- eval(expression[[2]])@citation
      coded_bibkeys[[length(coded_bibkeys) + 1]] <- bibcitation
    }
  }

  unique(coded_bibkeys)
}

get_coded_bibkeys <- function() {
  r_path <- './R'
  scan_files <- list.files(r_path)
  scan_files <- scan_files[!scan_files %in% black_list]
  coded_bibkeys <- c()

  for(scan_file in scan_files) {
    coded_bibkeys_file <- get_coded_bibkeys_file(file.path(r_path, scan_file))
    coded_bibkeys <- c(coded_bibkeys, coded_bibkeys_file)
  }

  unique(coded_bibkeys)
}



write_entries <- function(bibkeys) {
  for(key in bibkeys) {
    print('Updating citation for:')
    print(key)
    key <- as.BibEntry(key)
    RefManageR::WriteBib(key, './inst/ref.bib')
  }
}

write_entries(get_coded_bibkeys())
