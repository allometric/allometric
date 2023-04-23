curtis_1990 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "techreport",
    key = "curtis_1990",
    title = "Height growth and site index curves for western white pine in the Cascade Range of Washington and Oregon",
    author = "Curtis, Robert O and Diaz, Nancy M and Clendenen, Gary W",
    year = 1990,
    institution = "US Department of Agriculture, Forest Service, Pacific Northwest Research Station"
  ),
  descriptors = list(
    family = "Pinaceae",
    genus = "Pinus",
    species = "monticola",
    region = c("US-OR", "US-WA"),
    country = "US"
  )
)

hstix50 <- FixedEffectsModel(
  response_unit = list(
    hstix50 = units::as_units("ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    atb = units::as_units("years")
  ),
  parameters = list(
    a = -2.608801,
    b = -0.715601,
    c = 0.408404,
    d = 0.138199
  ),
  predict_fn = function(hst, atb) {
    log_50 <- log(50)
    log_atb <- log(atb)

    exp(a * (log_atb - log_50) + b * (log_atb - log_50)^2) *
      hst^(1 + c * (log_atb - log_50) + d * (log_atb - log_50)^2)
  }
)

curtis_1990 <- curtis_1990 %>% add_model(hstix50)