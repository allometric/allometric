harrington_1986 <- Publication(
  citation = RefManageR::BibEntry(
    key = "harrington_1986",
    bibtype = "techreport",
    title = "Height growth and site index curves for red alder",
    author = "Harrington, CA and Curtis, RO",
    year = 1986,
    institution = "Pacific Northwest Research Station, US Department of Agriculture, Forest Service"
  ),
  descriptors = list(
    family = "Betulaceae",
    genus = "Alnus",
    species = "rubra",
    country = "US",
    region = c("US-OR", "US-WA")
  )
)

hstix20 <- FixedEffectsModel(
  response_unit = list(
    hstix = units::as_units("ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    atb = units::as_units("years")
  ),
  parameters = list(
    a1 = 16.5158,
    a2 = -1.40726,
    a3 = 0.033727,
    a4 = -0.00023267,
    b1 = 1.25934,
    b2 = -0.012989,
    b3 = 3.5220
  ),
  predict_fn = function(hst, atb) {
    a <- a1 + a2 * atb + a3 * atb^2 + a4 * atb^3
    b <- b1 + b2 * atb + b3 * (1 / atb)^3

    a + b * hst
  }
)

harrington_1986 <- harrington_1986 %>%
  add_model(hstix20)
