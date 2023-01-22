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
    response_def <- get_variable_def(response_name, return_exact_only = T)
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

  c(header, body)
}

update_reference_pages <- function(verbose) {
  pub_list <- get_pub_list(verbose = F, ignore_cache = F)

  for (pub in pub_list) {
    if(verbose) {
      cat(paste("Updating reference page for:", pub@id, "\n"))
    }
    rd_path <- file.path("./man/", paste0(pub@id, ".Rd"))
    write_lines <- rd_lines(pub)

    write(write_lines, file = rd_path, sep = "\n")
  }
}

check_internal <- function(rd_path) {
  parsed_rd <- tools::parse_Rd(rd_path)

  for (el in parsed_rd) {
    if (attr(el, "Rd_tag") == "\\keyword") {
      if (el[[1]][[1]] == "internal") {
        return(TRUE)
      }
    }
  }

  return(FALSE)
}

update_reference_index <- function() {
  pub_list <- get_pub_list(verbose = F, ignore_cache = F)
  pub_names <- names(pub_list)
  pub_rd_names <- paste(pub_names, ".Rd", sep = "")

  analysis_funcs <- c("predict", "allometric_models")
  man_dir <- system.file("man", package="allometric")

  man_files <- list.files(man_dir)
  exclude_files <- c("figures")
  man_files <- man_files[!man_files %in% exclude_files]

  non_pub_rd_files <- c()
  for (man_file in man_files) {
    man_path <- file.path(system.file("man", package = "allometric"), man_file)
    internal <- check_internal(man_path)

    # Remove keyword: internal and publications from this section
    if (!internal & !(man_file %in% pub_rd_names)) {
      non_pub_rd_files <- c(non_pub_rd_files, man_file)
    }
  }

  non_pub_rd_obj_names <- tools::file_path_sans_ext(non_pub_rd_files)


  init_reference <- list(
    list(
      title = "Analysis Functions",
      desc = "These functions are used to conduct inventory analysis with allometric models.",
      contents = non_pub_rd_obj_names[non_pub_rd_obj_names %in% analysis_funcs]
    ),
    list(
      title = "Contributor Functions",
      desc = "These functiosn are used to contribute and install models in `allometric`",
      contents = non_pub_rd_obj_names[!non_pub_rd_obj_names %in% analysis_funcs]
    ),
    list(
      title = "Allometric Models",
      desc = "Models are contained in publications, which are listed below."
    )
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
      response_def <- get_variable_def(response_name, return_exact_only = T)
      section_title <- stringr::str_to_title(paste(response_def$component_name, response_def$measure_name, "models"))
      ref_sections[[section_title]] <- c(ref_sections[[section_title]], pub@id)
    }
  }

  for (i in seq_along(ref_sections)) {
    n <- length(yaml_header$reference)

    yaml_header$reference[[n + 1]] <- list(
      subtitle = names(ref_sections)[[i]],
      contents = ref_sections[[i]]
    )
  }

  yml_path <- system.file("_pkgdown.yml", package="allometric")
  yaml::write_yaml(yaml_header, yml_path)
}
