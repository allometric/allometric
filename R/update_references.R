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
    sprintf("\\title{%s}", RefManageR::TextCite(pub@citation)),
    sprintf(
      "\\description{Allometric models from %s}",
      RefManageR::TextCite(pub@citation)
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

update_reference_pages <- function() {
  pub_list <- get_pub_list()

  for(pub in pub_list) {
    cat(paste("Updating reference page for:", pub@id, "\n"))
    rd_path <- file.path("./man/", paste0(pub@id, ".Rd"))
    write_lines <- rd_lines(pub)

    write(write_lines, file = rd_path, sep = "\n")
  }
}

update_reference_index <- function() {
  pub_list <- get_pub_list()
  pub_names <- names(pub_list)
  pub_rd_names <- paste(pub_names, ".Rd", sep = "")

  man_files <- list.files("./man")
  exclude_files <- c('figures')
  non_pub_rd_files <- man_files[!man_files %in% c(pub_rd_names, exclude_files)]
  non_pub_rd_obj_names <- tools::file_path_sans_ext(non_pub_rd_files)


  init_reference <- list(
    list(title = "Package Functions", contents = non_pub_rd_obj_names)
  )

  yaml_header <- list(
    url = "http://brycefrank.com/allometric",
    template = list(
      bootstrap = 5.0
    ),
    reference = init_reference
  )

  ref_sections <- list()

  for (pub in pub_list) {
    cat(paste("Updating reference index for:", pub@id, "\n"))
    for (i in seq_along(pub@response_sets)) {
      response_set <- pub@response_sets[[i]]
      response_name <- names(pub@response_sets)[[i]]
      response_def <- get_variable_def(response_name)
      section_title <- stringr::str_to_title(paste(response_def$component_name, response_def$measure_name, "models"))
      ref_sections[[section_title]] <- c(ref_sections[[section_title]], pub@id)
    }
  }

  for (i in seq_along(ref_sections)) {
    n <- length(yaml_header$reference)

    yaml_header$reference[[n + 1]] <- list(
      title = names(ref_sections)[[i]],
      contents = ref_sections[[i]]
    )
  }

  out_path <- system.file('_pkgdown.yml', package='allometric')
  yaml::write_yaml(yaml_header, out_path)
}

