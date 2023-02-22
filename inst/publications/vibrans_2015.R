vibrans_2015 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "article",
    key = "vibrans_2015",
    title = "Generic and specific stem volume models for three subtropical forest types in southern Brazil",
    author = "Vibrans, Alexander C and Moser, Paolo and Oliveira, Laio Z and de Maçaneiro, João P",
    journal = "Annals of Forest Science",
    volume = 72,
    number = 6,
    pages = "865--874",
    year = 2015,
    publisher = "BioMed Central"
  ),
  descriptors = list(
    country = "BR",
    region = "BR-SC"
  )
)

vsoa_species <- FixedEffectsSet(
  response_unit = list(
    vsoa = units::as_units("m^3")
  ),
  covariate_units = list(
    dsob = units::as_units("cm"),
    hst = units::as_units("m")
  ),
  parameter_names = c("beta_0", "beta_1", "beta_2"),
  predict_fn = function(dsob, hst) {
    circ <- dsob * pi
    1000 * exp(beta_0 + beta_1 * log(circ^2) + beta_2 * log(hst))
  },
  model_specifications = load_parameter_frame("vsa_vibrans_2015")
)

vsoa_generics <- FixedEffectsSet(
  response_unit = list(
    vsoa = units::as_units("m^3")
  ),
  covariate_units = list(
    dsob = units::as_units("cm"),
    hst = units::as_units("m")
  ),
  parameter_names = c("beta_0", "beta_1", "beta_2"),
  predict_fn = function(dsob, hst) {
    circ <- dsob * pi
    1000 * exp(beta_0 + beta_1 * log(circ^2) + beta_2 * log(hst))
  },
  model_specifications = tibble::tibble(
    forest_type = c("DEC", "MIX", "DEN", "ALL"),
    forest_type_description = c("seasonal deciduous", "mixed ombrophilous", "dense ombrophilous", "overall generic"),
    beta_0 = c(-17.68, -17.96, -17.75, -17.84),
    beta_1 = c(0.95, 0.96, 0.98, 0.96),
    beta_2 = c(0.67, 0.76, 0.57, 0.69)
  )
)

vibrans_2015 <- vibrans_2015 %>%
  add_set(vsoa_species) %>%
  add_set(vsoa_generics)
