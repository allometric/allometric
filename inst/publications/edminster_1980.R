edminster_1980 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "techreport",
    key =  "edminster_1980",
    author = "Edminster, Carleton B and Beeson, Robert T and Metcalf, Gary E",
    title = "Volume tables and point-sampling factors for ponderosa pine in the Front Range of Colorado",
    volume = 218,
    year = 1980,
    institution = "Rocky Mountain Forest and Range Experiment Station, Forest Service, US"
  ),
  descriptors = list(
    country = "US",
    region = "US-CO",
    family = "Pinaceae",
    genus = "Pinus",
    species = "ponderosa"
  )
)

# Table 1
vsia <- FixedEffectsModel(
  response_unit = list(vsia = units::as_units("ft^3")),
  covariate_units = list(
    dsob = units::as_units("in"),
    hst = units::as_units("ft")
  ),
  parameters = list(
    a = 0,
    b = 0.00226
  ),
  predict_fn = function(dsob, hst) {
    a + b * dsob^2 * hst
  }
)

# Table 2
vsim <- FixedEffectsModel(
  response_unit = list(vsim = units::as_units("ft^3")),
  covariate_units = list(
    dsob = units::as_units("in"),
    hst = units::as_units("ft")
  ),
  parameters = list(
    a = -0.44670,
    b = 0.00216
  ),
  predict_fn = function(dsob, hst) {
    a + b * dsob^2 * hst
  }
)

edminster_1980 <- edminster_1980 %>%
  add_model(vsia) %>%
  add_model(vsim)