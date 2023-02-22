bracket_1977_citation <- RefManageR::BibEntry(
  bibtype = "techreport",
  key = "brackett_1977",
  title = "Notes on tarif tree volume computation",
  author = "Brackett, Michael",
  year = 1977,
  institution = "State of Washington, Dept. of Natural Resources"
)

brackett_1977 <- Publication(
  citation = bracket_1977_citation,
  descriptors = list(
    country = "US",
    region = "US-WA"
  )
)

model_specifications <- load_parameter_frame("vsa_brackett_1977")

brackett_1977 <- add_set(brackett_1977, FixedEffectsSet(
  response_unit = list(
    vsia = units::as_units("ft3")
  ),
  covariate_units = list(
    dsob = units::as_units("in"),
    hst  = units::as_units("ft")
  ),
  parameter_names = c("a", "b", "c"),
  predict_fn = function(dsob, hst) {
    10^a * dsob^b * hst^c
  },
  model_specifications = model_specifications
))
