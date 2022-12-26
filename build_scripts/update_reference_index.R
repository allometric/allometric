# This script updates the _pkgdown.yml file, which produces the Results page.
library(yaml)


model_data <- readRDS('./inst/model_data.RDS')

yaml_header <- list(
    url = "http://brycefrank.com/allometric",
    template = list(
        bootstrap = 5.0
    ),
    reference = list(
        list(title = "Package Functions", contents = c("ParametricModel"))
    )
)

ref_sections <- list()

for(pub in model_data) {
    print(pub@id)
    for(i in seq_along(pub@response_sets)) {
        response_set <- pub@response_sets[[i]]
        response_name <- names(pub@response_sets)[[i]]
        response_def <- get_variable_def(response_name)
        section_title <- str_to_title(paste(response_def$component_name, response_def$measure_name, 'models'))



        ref_sections[[section_title]] <- c(ref_sections[[section_title]], pub@id)
    }
}

for(i in seq_along(ref_sections)) {
    n <- length(yaml_header$reference)

    yaml_header$reference[[n+1]] <- list(
        title = names(ref_sections)[[i]],
        contents = ref_sections[[i]]
    )
}

write_yaml(yaml_header, './_pkgdown.yml')

