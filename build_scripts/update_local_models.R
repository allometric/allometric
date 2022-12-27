pub_r_files <- list.files("./inst/publications")
pub_r_paths <- file.path("./inst/publications", pub_r_files)

model_data <- list()

for(i in seq_along(pub_r_paths)) {
  pub_r_path <- pub_r_paths[[i]]
  pub_r_file <- pub_r_files[[i]]
  print(paste("Processing file:", pub_r_path))
  source(pub_r_path)
  pub_name <- tools::file_path_sans_ext(pub_r_file)

  pub <- eval(str2expression(pub_name))

  model_data[[pub@id]] <- pub
}

saveRDS(model_data, file='./inst/model_data.RDS')

#mod_rows <- list()
#for (k in seq_along(pub_r_paths)) {
#  pub_r_path <- pub_r_paths[[k]]
#  pub_r_file <- pub_r_files[[k]]
#  print(paste("Processing file:", pub_r_path))
#  source(pub_r_path)
#  pub_name <- tools::file_path_sans_ext(pub_r_file)
#
#  pub <- eval(str2expression(pub_name))
#
#  pub@model_sets
#  for (i in 1:length(pub@model_sets)) {
#    model_response <- pub@model_sets[[i]]
#    for (j in 1:length(model_response)) {
#      model_set <- model_response[[j]]
#      for(l in 1:length(model_set@models)) {
#        mod <- model_set@models[[l]]
#
#        mod_rows[[length(mod_rows) + 1]] <- tibble(
#          pub_id = pub@id,
#          component = get_component_label(mod),
#          measure = get_measure_label(mod),
#          family = mod@model_specification$family,
#          genus = mod@model_specification$genus,
#          country = mod@model_specification$country,
#          region = mod@model_specification$region,
#          species = mod@model_specification$species,
#          mod = c(mod)
#        )
#      }
#    }
#  }
#}
#
#model_data <- dplyr::bind_rows(mod_rows)
#
## TODO make this data structure instead: (using json just to show...)
#
##{
##  'brackett_1977': {
##    id: 'brackett_1977',
##    ...
##    model_sets: {
##      'hsa': [
##        model_1
##      ],
##      'vsa': [
##        model_2
##      ]
##    }
##  },
##  'temesgen_2008': {
##
##  }
##}
#
## Then from this you can make a flat-file for searching, but it will be much
## easier to make the documentation files using this structure, since all the
## information is available!