iffsc_2022 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "techreport",
    key = "iffsc_2022",
    title = "Modelos de biomassa para espécies arbóreas nativas de Santa Catarina",
    year = 2022,
    institution = "Inventário Florístico Florestal de Santa Catarina",
    author = "IFFSC"
  ),
  descriptors = list(
    country = "BR",
    region = "BR-SC"
  )
)

pantropical <- FixedEffectsModel(
  response_unit = list(
    bt = units::as_units("kg")
  ),
  covariate_units = list(
    dsob = units::as_units("cm"),
    rwd = units::as_units("g / cm^3")
  ),
  parameters = list(
    a = 0.05678,
    b = 31.1785,
    c = 30.0868,
    d = 0.9894
  ),
  predict_fn = function(dsob, rwd) {
    a * (dsob^2 * (1.3 + ((b * dsob) / (c * dsob))) * rwd)^d
  },
  descriptors = list(
    geographic_region = "pantropical",
    forest_type = "dense ombrophilous"
  )
)

cecropia_galaziovii <- FixedEffectsModel(
  response_unit = list(bt = units::as_units("kg")),
  covariate_units = list(
    dsoc = units::as_units("cm"),
    hst = units::as_units("m")
  ),
  parameters = list(
    a = 295.6,
    b = 6.1366,
    c = -0.1161,
    d = -0.1522
  ),
  predict_fn = function(dsoc, hst) {
    a / (1 + exp(b + c * dsoc + d * hst))
  },
  descriptors = list(
    family = "Uritaceae",
    genus = "Cecropia",
    species = "galaziovii"
  )
)

cyathea_delgadii <- FixedEffectsModel(
  response_unit = list(bt = units::as_units("kg")),
  covariate_units = list(
    dsob = units::as_units("cm"),
    hst = units::as_units("m")
  ),
  parameters = list(
    a = 0.1523,
    b = 1.1254,
    c = 1.0338
  ),
  predict_fn = function(dsob, hst) {
    a * dsob^b * hst^c
  },
  descriptors = list(
    family = "Cyatheaceae",
    genus = "Cyathea",
    species = "delgadii"
  )
)

euterpe_edulis <- FixedEffectsModel(
  response_unit = list(bt = units::as_units("kg")),
  covariate_units = list(
    dsob = units::as_units("cm"),
    hst = units::as_units("m")
  ),
  parameters = list(
    a = 0.0175,
    b = 1.5288,
    c = 1.6600
  ),
  predict_fn = function(dsob, hst) {
    a * dsob^b * hst^c
  },
  descriptors = list(
    family = "Arecaceae",
    genus = "Euterpe",
    species = "edulist"
  )
)

# Skipping section 1.3, these are clearly from another publication and the
# text says they are not used anyway. Just add the other publication later.

# Eq 8.
mixed_ombrophilous <- FixedEffectsModel(
  response_unit = list(
    bt = units::as_units("kg")
  ),
  covariate_units = list(
    dsob = units::as_units("cm"),
    rwd = units::as_units("g / cm^3")
  ),
  parameters = list(
    a = 0.05678,
    b = 23.8622,
    c = 25.3497,
    d = 0.9894
  ),
  predict_fn = function(dsob, rwd) {
    a * (dsob^2 * (1.3 + ((b * dsob) / (c + dsob))) * rwd)^d
  },
  descriptors = list(
    forest_type = "mixed ombrophilous"
  )
)

araucaria_angustifolia <- FixedEffectsModel(
  response_unit = list(
    bt = units::as_units("kg")
  ),
  covariate_units = list(
    dsob = units::as_units("cm"),
    rwd = units::as_units("g / cm^3")
  ),
  parameters = list(
    a = 0.05678,
    b = 23.1311,
    c = -10.0152,
    d = 0.9894
  ),
  predict_fn = function(dsob, rwd) {
    a * (dsob^2 * (1.3 + b * exp(c / dsob)) * rwd)^d
  },
  descriptors = list(
    family = "Araucariaceae",
    genus = "Araucaria",
    species = "angustifolia"
  )
)

deciduous <- FixedEffectsModel(
  response_unit = list(
    bt = units::as_units("kg")
  ),
  covariate_units = list(
    dsob = units::as_units("cm"),
    rwd = units::as_units("g / cm^3")
  ),
  parameters = list(
    a = 0.05678,
    b = 20.6603,
    c = 0.037056,
    d = 0.9894
  ),
  predict_fn = function(dsob, rwd) {
    a * (dsob^2 * (1.3 + b * (1 - exp(c * dsob))) * rwd)^d
  },
  descriptors = list(
    forest_type = "deciduous"
  )
)


iffsc_2022 <- iffsc_2022 %>%
  add_model(pantropical) %>%
  add_model(cecropia_galaziovii) %>%
  add_model(cyathea_delgadii) %>%
  add_model(euterpe_edulis) %>%
  add_model(araucaria_angustifolia) %>%
  add_model(deciduous)
