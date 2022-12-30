library(yaml)

pub_list <- readRDS("./inst/pub_list.RDS")

pub_names <- names(pub_list)
pub_rd_names <- paste(pub_names, ".Rd", sep = "")

man_files <- list.files("./man")
non_pub_rd_files <- man_files[!man_files %in% pub_rd_names]
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
    section_title <- str_to_title(paste(response_def$component_name, response_def$measure_name, "models"))
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

write_yaml(yaml_header, "./_pkgdown.yml")
