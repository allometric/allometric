# Creates an internally stored (./inst) table of all models and their metadata
# this forms the dataset used in model_search
devtools::load_all('.')



get_publications_file <- function(file_path) {
  pubs <- list()
  expressions <- parse(file_path)
  for(i in seq_along(expressions)) {
    expression <- expressions[[i]]
    if(length(expression) >= 3) {
        expr_call <- expression[[3]][[1]]
        if(expr_call == 'Publication') {
            pub <- eval(expression[[2]])
            pubs[[length(pubs) + 1]] <- pub
        }
    }
  }
  print(str(pubs))
}

update_search <- function() {
  r_path <- './R'
  scan_files <- list.files(r_path)
  coded_bibkeys <- c()

  for(scan_file in scan_files) {
    coded_bibkeys_file <- get_publications_file(file.path(r_path, scan_file))
  }
}

update_search()
