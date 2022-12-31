pub_list <- readRDS(system.file('extdata/pub_list.RDS', package = "allometric"))

search_descriptors <- c(
  "family", "genus", "species", "country", "region"
)

out_order <- c(
  "component", "measure", "country", "region",
  "family", "genus", "species", "model"
)

results <- list()

#' Transforms a set of searched models into a tibble of models and descriptors
aggregate_results <- function(results) {
  agg_results <- list()
  for (i in seq_along(results)) {
    result <- results[[i]]
    model <- result$model
    pub <- result$pub

    model_descriptors <- c(
      model@descriptors,
      model@pub_descriptors,
      model@set_descriptors
    )

    descriptors_row <- tibble::as_tibble(list(pub_id = pub@id))

    descriptors_row$model <- c(model)

    descriptors_row$country <- list(model_descriptors$country)

    if(is.null(model_descriptors$country)) {
      stop(paste(TextCite(pub@citation), 'did not contain a country code.'))
    }

    descriptors_row$region <- list(model_descriptors$region)
    descriptors_row$family <- model_descriptors$family
    descriptors_row$genus <- model_descriptors$genus
    descriptors_row$species <- model_descriptors$species

    family_names <- pub@citation$author$family
    descriptors_row$family_names <- list(family_names)

    covt_names <- names(model@covariate_units)
    descriptors_row$covt_names <- list(covt_names)

    pub_year <- as.numeric(pub@citation$year)
    descriptors_row$pub_year <- pub_year

    response_def <- get_variable_def(names(model@response_unit)[[1]])

    descriptors_row$component <- response_def$component_name
    descriptors_row$measure <- response_def$measure_name

    agg_results[[i]] <- descriptors_row
  }

  agg_results <- dplyr::bind_rows(agg_results) %>%
    dplyr::arrange(family, genus, species)

  # Order the columns
  not_in_order <- colnames(agg_results)[!colnames(agg_results) %in% out_order]
  order_cols <- c(out_order, not_in_order)

  agg_results[, order_cols]
}

for (pub in pub_list) {
  for (response_set in pub@response_sets) {
    for (model_set in response_set) {
      for (model in model_set@models) {
        results[[length(results) + 1]] <- list(
          pub = pub,
          model = model
        )
      }
    }
  }
}

allometric_models <- aggregate_results(results)
out_dir <- system.file('extdata', package='allometric')
out_path <- file.path(out_dir, 'allometric_models.RDS')

saveRDS(allometric_models, out_path)
