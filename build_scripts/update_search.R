# Creates an internally stored (./inst) table of all models and their metadata
# this forms the dataset used in model_search
devtools::load_all(".")

get_publications_file <- function(file_path) {
  pubs <- list()
  expressions <- parse(file_path)
  for (i in seq_along(expressions)) {
    expression <- expressions[[i]]
    if (length(expression) >= 3) {
      expr_call <- expression[[3]][[1]]
      if (expr_call == "Publication") {
        pub <- eval(expression[[2]])
        pubs[[length(pubs) + 1]] <- pub
      }
    }
  }
  pubs
}

# Search fields:
# - title
# - first author last name
# - country
# - region
# - family
# - genus
# - species
# - measure
# - component
# - journal

# The basic idea is to make a big table of the above data (pre commit hook or
# as part of build process...), and a function that allows the user to filter
# or search the data. For now this is a model-level table, and I think that is
# fine. It could get quite large but then again that is the point of the package
# Anticipate having ~10,000 records or something in that magnitude.





get_model_search_fields <- function(pub) {
}

get_model_search_fields(huy_2019)

update_search <- function() {
  r_path <- "./R"
  scan_files <- list.files(r_path)
  coded_bibkeys <- c()

  for (scan_file in scan_files) {
    pubs_file <- get_publications_file(file.path(r_path, scan_file))
    browser()
  }
}

update_search()
