bruce_1974 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "techreport",
    key = "bruce_1974",
    title = "Volume equations for second-growth Douglas-fir",
    author = "Bruce, David and DeMars, Donald J",
    volume = 239,
    year = 1974,
    institution = "Pacific Northwest Forest and Range Experiment Station, Forest Service"
  ),
  descriptors = list(
    country = c("US", "CA"),
    region = c("US-OR", "US-WA", "CA-BC"),
    family = "Pinaceae",
    genus = "Pseudotsuga",
    species = "menziesii"
  )
)

small <- FixedEffectsModel(
  response_unit = list(
    vsia = units::as_units("ft^3")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    dsob = units::as_units("in")
  ),
  parameters = list(
    a = 0.406098,
    b = 0.0762998,
    c = 0.00262615,
    d = 0.005454154
  ),
  predict_fn = function(hst, dsob) {
    fos <- a * (hst - 0.9)^2 / (hst - 4.5)^2 - b * dsob * (hst - 0.9)^3 / (hst - 4.5)^3 +
      c * dsob * hst * (hst - 0.9)^3 / (hst - 4.5)^3
    d * fos * (dsob^2 * hst)
  },
  descriptors = list(
    hst = "<= 18 ft hst"
  )
)

large <- FixedEffectsModel(
  response_unit = list(
    vsia = units::as_units("ft^3")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    dsob = units::as_units("in")
  ),
  parameters = list(
    a = 0.480961,
    b = 42.46542,
    c = 10.99643,
    d = 0.107809,
    e = 0.00409083,
    f = 0.005454154
  ),
  predict_fn = function(hst, dsob) {
    fol <- a + b / hst^2 - c * dsob / hst^2 - d * dsob / hst - e * dsob
    f * fol * (dsob^2 * hst)
  },
  descriptors = list(
    hst = "> 18 ft hst"
  )
)

bruce_1974 <- bruce_1974 %>%
  add_model(small) %>%
  add_model(large)
