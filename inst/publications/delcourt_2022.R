delcourt_2022 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "article",
    key = "delcourt_2022",
    title = "Allometric equations and wood density parameters for estimating aboveground and woody debris biomass in Cajander larch (Larix cajanderi) forests of northeast Siberia",
    author = "Delcourt, Clement Jean Fr{\'e}d{\'e}ric and Veraverbeke, Sander",
    journal = "Biogeosciences",
    volume = 19,
    number = 18,
    pages = "4499--4520",
    year = 2022,
    publisher = "Copernicus GmbH"
  ),
  descriptors = list(
    country = "RU",
    family = "Pinaceae",
    genus = "Larix",
    species = "cajanderi"
  )
)

params <- load_parameter_frame('b_delcourt_2022')

regions <- unique(params$region)
responses <- unique(params$response_name)

for(response_name in responses) {
  response_unit <- list()
  response_unit[[response_name]] <- units::as_units("kg")
  spec <- params %>% dplyr::filter(
    response_name == {{response_name}}
  )

  set <- FixedEffectsSet(
    response_unit = response_unit,
    covariate_units = list(
      dsob = units::as_units("cm")
    ),
    parameter_names = c("a", "b"),
    predict_fn = function(dsob) {
      a * dsob^b
    },
    model_specifications = spec
  )

  delcourt_2022 <- delcourt_2022 %>% add_set(set)
}

