
paine_1982 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "techreport",
    key = "paine_1982",
    title = "Maximum crown-width equations for southwestern Oregon tree species",
    author = "Paine, D.P. & Hann, D.W.",
    year = 1982,
    institution = "Oregon State University, School of Forestry, Forest Research Lab"
  ),
  descriptors = list(
    country = "US",
    region = "US-OR"
  )
)

dcm <- FixedEffectsSet(
  response_unit = list(
    dcm = units::as_units("feet")
  ),
  covariate_units = list(
    dsob = units::as_units("in")
  ),
  parameter_names = c(
    "a0", "a1", "a2"
  ),
  predict_fn = function(dsob) {
    a0 + a1 * dsob + a2 * dsob^2
  },
  model_specifications = load_parameter_frame("dcm_paine_1982")
)

paine_1982 <- paine_1982 %>% add_set(dcm)