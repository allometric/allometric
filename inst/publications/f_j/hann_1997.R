hann_1997_citation <- RefManageR::BibEntry(
  bibtype = "techreport",
  key = "hann_1997",
  title = "Equations for predicting the largest crown width of stand-grown trees in western Oregon",
  author = "Hann, D.W.",
  year = 1997,
  institution = "Oregon State University, College of Forestry, Forest Research Lab"
)

hann_1997 <- Publication(
  citation = hann_1997_citation,
  descriptors = list(
    country = "US",
    region = "US-OR"
  )
)

dcl <- FixedEffectsSet(
  response_unit = list(
    dcl = units::as_units("ft")
  ),
  covariate_units = list(
    dsob = units::as_units("in"),
    hst = units::as_units("ft"),
    rc = units::as_units("ft / ft"),
    dcm = units::as_units("ft")
  ),
  parameter_names = c(
    "b0", "b1", "b2"
  ),
  predict_fn = function(dsob, hst, rc, dcm) {
    dcm * rc ^ (b0 + b1 * (rc * hst) + b2 * (dsob / hst))
  },
  model_specifications = load_parameter_frame("dcl_hann_1997")
)

hann_1997 <- hann_1997 %>% add_set(dcl)