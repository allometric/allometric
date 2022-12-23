library(devtools)
library(dplyr)
devtools::load_all('.')

pub_r_files <- list.files('./inst/publications')
pub_r_paths <- file.path('./inst/publications', pub_r_files)

mod_rows <- list()
for(k in seq_along(pub_r_paths)) {
    pub_r_path <- pub_r_paths[[k]]
    pub_r_file <- pub_r_files[[k]]
    print(paste('Processing file:', pub_r_path))
    source(pub_r_path)
    pub_name <- tools::file_path_sans_ext(pub_r_file)

    pub <- eval(str2expression(pub_name))

    pub@model_sets
    for(i in 1:length(pub@model_sets)) {
        for(j in 1:length(pub@model_sets[[i]]@models)) {
            mod <- pub@model_sets[[i]]@models[[j]]
            print(pub@id)

            mod_rows[[length(mod_rows) + 1]] <- tibble(
                pub_id = pub@id,
                component = get_component_label(mod),
                measure = get_measure_label(mod),
                family = mod@model_description$family,
                genus = mod@model_description$genus,
                country = mod@model_description$country,
                region = mod@model_description$region,
                species = mod@model_description$species,
                mod = c(pub@model_sets[[i]]@models[[j]])
            )

        }
    }
}

model_data <- bind_rows(mod_rows)