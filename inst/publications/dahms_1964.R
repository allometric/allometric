dahms_1964 <- Publication(
  citation = RefManageR::BibEntry(
    key = "dahms_1964",
    bibtype = "techreport",
    title = "Gross and net yield tables for lodgepole pine",
    author = "Dahms, Walter G",
    year = 1964,
    institution = "Pacific Northwest Forest and Range Experiment Station, Forest Service"
  ),
  descriptors = list(
    family = "Pinaceae",
    genus = "Pinus",
    species = "contorta",
    region = "US-OR",
    country = "US"
  )
)

hstix100 <- FixedEffectsModel(
  response_unit = list(
    hstix100 = units::as_units("ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    att = units::as_units("years")
  ),
  parameters = list(
    a = -0.0968,
    b = 0.02679,
    c = -0.00009309
  ),
  predict_fn = function(hst, att) {
    hst / (a + b * att + c * att^2)
  }
)

dahms_1964 <- dahms_1964 %>% add_model(hstix100)