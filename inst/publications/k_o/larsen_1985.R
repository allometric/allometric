larsen_1985 <- Publication(
  citation = RefManageR::BibEntry(
    key = "larsen_1985",
    bibtype = "techreport",
    title = "Equations for predicting diameter and squared diameter inside bark at breast height for six major conifers of southwest Oregon",
    author = "Larsen, David Rolf and Hann, David W",
    year = 1985,
    institution = "Oregon State University"
  ),
  descriptors = list(
    country = "US",
    region = "US-OR"
  )
)

dsib <- FixedEffectsSet(
  response_unit = list(
    dsib = units::as_units("in")
  ),
  covariate_units = list(
    dsob = units::as_units("in")
  ),
  parameter_names = c(
    "b1", "b2"
  ),
  predict_fn = function(dsob) {
    b1 * (dsob)^b2
  },
  model_specifications = load_parameter_frame("dsib_larsen_1985")
)

larsen_1985 <- larsen_1985 %>%
  add_set(dsib)