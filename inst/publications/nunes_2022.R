nunes_2022 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "article",
    key = "nunes_2022",
    title = "Bulk Density of Shrub Types and Tree Crowns to Use with Forest Inventories in the Iberian Peninsula",
    author = "Nunes, Leonia and Pasalodos-Tato, Maria and Alberdi, Iciar and Sequeira, Ana Catarina and Vega, Jose Antonio and Silva, Vasco and Vieira, Pedro and Rego, Francisco Castro",
    volume = 13,
    issn = "1999-4907",
    doi = "10.3390/f13040555",
    number = 4,
    journal = "Forests",
    year = 2022
  ),
  descriptors = list(
    country = "ES"
  )
)

hcl <- FixedEffectsSet(
  response_unit = list(
    hcl = units::as_units("m")
  ),
  covariate_units = list(
    hst = units::as_units("m"),
    en  = units::as_units("ha^-1") # TODO look at defining units for trees per hectare and acre, etc
  ),
  parameter_names = c("a0", "a1"),
  predict_fn = function(hst, en) {
    hst / (1 + a0 * exp(-a1 * (10000 / en)^(-0.5)))
  },
  model_specifications = load_parameter_frame("hcl_nunes_2022")
)

dc <- FixedEffectsSet(
  response_unit = list(
    dc = units::as_units("m")
  ),
  covariate_units = list(
    dsob = units::as_units("cm"),
    en = units::as_units("ha^-1") # TODO look at defining units for trees per hectare
  ),
  parameter_names = c("b0", "b1", "b2"),
  predict_fn = function(dsob, en) {
    b0 * (dsob^b1) * ((10000 / en)^(-0.5))^b2
  },
  model_specifications = load_parameter_frame("dc_nunes_2022")
)

nunes_2022 <- nunes_2022 %>%
  add_set(hcl) %>%
  add_set(dc)