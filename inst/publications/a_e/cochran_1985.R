cochran_1985 <- Publication(
  citation = RefManageR::BibEntry(
    key = "cochran_1985",
    bibtype = "techreport",
    title = "Site index, height growth, normal yields, and stocking levels for larch in Oregon and Washington",
    author = "Cochran, PH",
    volume = 424,
    year = 1985,
    institution = "US Department of Agriculture, Forest Service, Pacific Northwest Forest and Experiment Station"
  ),
  descriptors = list(
    family = "Pinaceae",
    genus = "Larix",
    species = "occidentalis",
    country = "US",
    region = c("US-OR", "US-WA")
  )
)

hstix50 <- FixedEffectsModel(
  response_unit = list(
    hstix50 = units::as_units("ft")
  ),
  covariate_units = list(
    atb = units::as_units("years"),
    hst = units::as_units("ft")
  ),
  parameters = list(
    a = 78.07,
    b1 = 3.51412,
    b2 = -0.125483,
    b3 = 0.0023559,
    b4 = -0.00002028,
    b5 = 0.000000064782,
    b6 = 1.46897,
    b7 = 0.0092466,
    b8 = -0.00023957,
    b9 = 0.0000011122
  ),
  predict_fn = function(atb, hst) {
    b <- b1 + b2 * atb  + b3 * atb^2 + b4 * atb^3 + b5 * atb^4
    b_m <- b * (b6 * atb + b7 * atb^2 + b8 * atb^3 + b9 * atb^4)

    a + b * (hst - 4.5) - b * b_m
  }
)

cochran_1985 <- cochran_1985 %>% 
  add_model(hstix50)