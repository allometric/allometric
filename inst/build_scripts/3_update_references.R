library(RefManageR)
library(stringr)

pub_list <- readRDS(system.file('extdata/pub_list.RDS', package = "allometric"))

response_section_lines <- function(response_set) {
  response_lines <- c()
  for (model_set in response_set) {
    lines_vec <- c(
      rd_model_equation(model_set),
      rd_variable_defs(model_set),
      "\\bold{Model Parameters}",
      rd_parameter_table(model_set),
      "\\out{<hr>}"
    )

    response_lines <- c(response_lines, lines_vec)
  }

  paste(response_lines, collapse = "\n")
}

rd_lines <- function(pub) {
  header <- c(
    sprintf("\\name{%s}", pub@id),
    sprintf("\\alias{%s}", pub@id),
    sprintf("\\title{%s}", TextCite(pub@citation)),
    sprintf(
      "\\description{Allometric models from %s}",
      TextCite(pub@citation)
    )
  )

  # The response variables form the sections
  n_response_vars <- length(pub@response_sets)

  body <- c()

  for (i in 1:n_response_vars) {
    response_name <- names(pub@response_sets)[[i]]
    response_def <- get_variable_def(response_name)
    section_title <- stringr::str_to_title(
      paste(
        response_def$component_name,
        response_def$measure_name,
        "models"
      )
    )

    section_lines <- response_section_lines(pub@response_sets[[i]])
    body <- c(body, sprintf("\\section{%s}{%s}", section_title, section_lines))
  }

  # TODO for each model set pick the first model and construct the example
  # code programatically. It could be useful to have a little data set with
  # some default values for each unit/variable pair.

  c(header, body)
}

for (pub in pub_list) {
  cat(paste("Updating reference page for:", pub@id, "\n"))
  rd_path <- file.path("./man/", paste0(pub@id, ".Rd"))
  write_lines <- rd_lines(pub)

  write(write_lines, file = rd_path, sep = "\n")
}
