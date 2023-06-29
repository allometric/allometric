montero_2020 <- Publication(
  citation = RefManageR::BibEntry(
    key = "montero_2020",
    bibtype = "techreport",
    title = "Biomass production and carbon sequestration by Spanish shrublands and by the superficial organic horizon of forest soils",
    author = "Montero, G and López-Leiva, C and Ruiz-Peinado, R and López-Senespleda, E and Onrubia, R and Pasalodos, M",
    year = 2020,
    institution = "Ministry of Agriculture, Fisheries and Food: Madrid, Spain"
  ),
  descriptors = list(
    country = "ES"
  )
)

all_params <- load_parameter_frame("montero_2020")

hht_polynomial <- FixedEffectsSet(
  response_unit = list(
    "hht" = units::as_units("m")
  ),
  covariate_units = list(
    "ah" = units::as_units("years")
  ),
  parameter_names = c("c1", "c2", "c3"),
  predict_fn = function(ah) {
    c1^2 * ah + c2 * ah + c3
  },
  model_specifications = all_params %>%
    dplyr::filter(equation == "Height_Age", equation_type == "polynomial") %>%
    dplyr::select(family, genus, species, c1, c2, c3)
)

hht_power <- FixedEffectsSet(
  response_unit = list(
    "hht" = units::as_units("m")
  ),
  covariate_units = list(
    "ah" = units::as_units("years")
  ),
  parameter_names = c("c1", "c2"),
  predict_fn = function(ah) {
    c1 * ah^c2
  },
  model_specifications = all_params %>%
    dplyr::filter(equation == "Height_Age", equation_type == "power") %>%
    dplyr::select(family, genus, species, c1, c2)
)

dh_polynomial <- FixedEffectsSet(
  response_unit = list(
    "dh" = units::as_units("mm")
  ),
  covariate_units = list(
    "ah" = units::as_units("years")
  ),
  parameter_names = c("c1", "c2", "c3"),
  predict_fn = function(ah) {
    c1^2 * ah + c2 * ah + c3
  },
  model_specifications = all_params %>%
    dplyr::filter(equation == "Diameter_Age", equation_type == "polynomial") %>%
    dplyr::select(family, genus, species, c1, c2, c3)
)

dh_power <- FixedEffectsSet(
  response_unit = list(
    "dh" = units::as_units("mm")
  ),
  covariate_units = list(
    "ah" = units::as_units("years")
  ),
  parameter_names = c("c1", "c2"),
  predict_fn = function(ah) {
    c1 * ah^c2
  },
  model_specifications = all_params %>%
    dplyr::filter(equation == "Diameter_Age", equation_type == "power") %>%
    dplyr::select(family, genus, species, c1, c2)
)

bh_p <- FixedEffectsSet(
  response_unit = list(
    "bh_p" = units::as_units("Mg / ha")
  ),
  covariate_units = list(
    "rv_p" = units::as_units("m^2 / m^2"),
    "hht_p" = units::as_units("dm")
  ),
  parameter_names = c("c1", "c2", "c3"),
  predict_fn = function(rv_p, hht_p) {
    c1 * hht_p * c3 * acos(sqrt(rv_p))^c2
  },
  model_specifications = all_params %>%
    dplyr::filter(equation == "Biomass_FCC_H", equation_type == "acos_sqrt") %>%
    dplyr::select(family, genus, species, c1, c2, c3)
)

inc_bh_p_acos <- FixedEffectsSet(
  response_unit = list(
    "i_bh_p" = units::as_units("Mg / ha / year")
  ),
  covariate_units = list(
    "rv_p" = units::as_units("m^2 / m^2"),
    "hht_p" = units::as_units("dm")
  ),
  parameter_names = c("c1", "c2", "c3"),
  predict_fn = function(rv_p, hht_p) {
    c1 * hht_p * c3 * acos(sqrt(rv_p))^c2
  },
  model_specifications = all_params %>%
    dplyr::filter(equation == "IncBiomass_FCC_H", equation_type == "acos_sqrt") %>%
    dplyr::select(family, genus, species, c1, c2, c3)
)

inc_bh_p_exp <- FixedEffectsSet(
  response_unit = list(
    "i_bh_p" = units::as_units("Mg / ha / year")
  ),
  covariate_units = list(
    "rv_p" = units::as_units("m^2 / m^2"),
    "hht_p" = units::as_units("dm")
  ),
  parameter_names = c("c1", "c2", "c3", "c4"),
  predict_fn = function(rv_p, hht_p) {
    c4 * exp(c1) * rv_p^c2 * hht_p^c3
  },
  model_specifications = all_params %>%
    dplyr::filter(equation == "IncBiomass_FCC_H", equation_type == "exp_log") %>%
    dplyr::select(family, genus, species, c1, c2, c3, c4)
)

bh_p_power <- FixedEffectsSet(
  response_unit = list(
    "i_bh_p" = units::as_units("Mg / ha")
  ),
  covariate_units = list(
    "ah_p" = units::as_units("years")
  ),
  parameter_names = c("c1", "c2"),
  predict_fn = function(ah_p) {
    c1 * ah_p^c2
  },
  model_specifications = all_params %>%
    dplyr::filter(equation == "Biomass_Age", equation_type == "power") %>%
    dplyr::select(family, genus, species, c1, c2)
)

montero_2020 <- montero_2020 %>%
  add_set(hht_polynomial) %>%
  add_set(hht_power) %>%
  add_set(dh_polynomial) %>%
  add_set(dh_power) %>%
  add_set(bh_p) %>%
  add_set(inc_bh_p_acos) %>%
  add_set(inc_bh_p_exp) %>%
  add_set(bh_p_power)