
feldpausch_2012 <- Publication(
  citation = RefManageR::BibEntry(
    key = "feldpausch_2012",
    bibtype = "article",
    title = "Tree height integrated into pantropical forest biomass estimates",
    author = "Feldpausch, Ted R and Lloyd, Jon and Lewis, Simon L and Brienen, Roel JW and Gloor, Manuel and Monteagudo Mendoza, Abel and Lopez-Gonzalez, Gabriela and Banin, Lindsay and Abu Salim, Kamariah and Affum-Baffoe, Kofi and others",
    journal = "Biogeosciences",
    volume = 9,
    number = 8,
    pages = "3381--3403",
    year = 2012,
    publisher = "Copernicus GmbH"
  )
)

# These models can be specified all the way down to the country level using
# section 2.5
country_frame <- load_parameter_frame("hst_feldpausch_2012_country")

# Geog. region frame
geog_region_frame <- country_frame %>%
  dplyr::group_by(continent, geographic_region, a, b, c) %>%
  dplyr::summarise(country = list(country)) %>%
  dplyr::ungroup()

geog_region_set <- FixedEffectsSet(
  response_unit = list(
    hst = units::as_units("m")
  ),
  covariate_units = list(
    dsob = units::as_units("cm")
  ),
  parameter_names = c("a", "b", "c"),
  predict_fn = function(dsob) {
    a * (1 - exp(-b * dsob^c))
  },
  model_specifications = geog_region_frame
)

feldpausch_2012 <- add_set(feldpausch_2012, geog_region_set)

# These models are fit using pooled data from the previous country set at the
# "continent" level.

continent_params <- tibble::tibble(
  continent = c("Africa", "S. America"),
  a = c(50.096, 42.574),
  b = c(0.03711, 0.0482),
  c = c(0.8291, 0.8307)
)

continent_frame <- country_frame %>%
  dplyr::group_by(continent) %>%
  dplyr::summarise(country = list(country)) %>%
  dplyr::filter(!continent %in% c("Australia", "Asia")) %>% # These two are redundant
  merge(continent_params) %>%
  tibble::as_tibble()

generic_set <- FixedEffectsSet(
  response_unit = list(
    hst = units::as_units("m")
  ),
  covariate_units = list(
    dsob = units::as_units("cm")
  ),
  parameter_names = c("a", "b", "c"),
  predict_fn = function(dsob) {
    a * (1 - exp(-b * dsob^c))
  },
  model_specifications = continent_frame
)

feldpausch_2012 <- add_set(feldpausch_2012, generic_set)

pantropical_frame <- country_frame %>%
  dplyr::summarise(country = list(country)) %>%
  dplyr::mutate(a = 50.874, b = 0.0420, c = 0.784)

pantropical_model <- FixedEffectsModel(
  response_unit = list(
    hst = units::as_units("m")
  ),
  covariate_units = list(
    dsob = units::as_units("cm")
  ),
  parameters = list(
    a = 50.874, b = 0.0420, c = 0.784
  ),
  predict_fn = function(dsob) {
    a * (1 - exp(-b * dsob^c))
  },
  descriptors = pantropical_frame[, "country"]
)

# Unfortunately, Feldpascuh et al. do not specify the source of the biomass
# data to the same degree as the height data. It would take several subjective
# determinations to assign this model to countries. Toward that end, it is
# simply referred to as a pantropical model in the descriptors.

bt_1 <- FixedEffectsModel(
  response_unit = list(
    bt = units::as_units("kg")
  ),
  covariate_units = list(
    dsob = units::as_units("cm"),
    rwd = units::as_units("g / cm^3")
  ),
  parameters = list(
    a = -1.8222,
    b = 2.3370,
    c = 0.1632,
    d = -0.0248,
    e = 0.9792,
    rse = 0.3595
  ),
  predict_fn = function(dsob, rwd) {
    cf <- exp(rse^2 / 2)
    cf * exp(a + b * log(dsob) + c * log(dsob)^2 + d * log(dsob)^3 + e * log(rwd))
  },
  descriptors = list(geographic_region = "pantropical")
)

bt_2 <- FixedEffectsModel(
  response_unit = list(
    bt = units::as_units("kg")
  ),
  covariate_units = list(
    dsob = units::as_units("cm"),
    rwd = units::as_units("g / cm^3"),
    hst = units::as_units("m")
  ),
  parameters = list(
    a = -2.9205,
    b = 0.9894,
    rse = 0.3222
  ),
  predict_fn = function(dsob, rwd, hst) {
    cf <- exp(rse^2 / 2)
    cf * exp(a + b * log(dsob^2 * rwd * hst))
  },
  descriptors = list(geographic_region = "pantropical")
)

feldpausch_2012 <- feldpausch_2012 %>%
  add_model(pantropical_model) %>%
  add_model(bt_1) %>%
  add_model(bt_2)
