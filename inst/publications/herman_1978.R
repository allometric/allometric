herman_1978 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "techreport",
    key = "herman_1978",
    title = "Height growth and site index estimates for noble fir in high elevation forests of the Oregon-Washington Cascades",
    author = "Herman, Francis R and Curtis, Robert O and DeMars, Donald J",
    volume = 243,
    year = 1978,
    institution = "Department of Agriculture, Forest Service, Pacific Northwest Forest and Range Experiment Station"
  ),
  descriptors = list(
    family = "Pinaceae",
    genus = "Abies",
    species = "procera",
    region = c("US-OR", "US-WA"),
    country = "US"
  )
)

hstix100 <- FixedEffectsModel(
  response_unit = list(
    hstix100 = units::as_units("ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    atb = units::as_units("years")
  ),
  parameters = list(
    a1 = -62.755,
    a2 = 672.55,
    b1 = 0.9484,
    b2 = 516.49,
    c1 = -0.00144,
    c2 = 0.1442
  ),
  predict_fn = function(hst, atb) {
    a <- a1 + a2 * (1 / atb)^(0.5)
    b <- b1 + b2 * (1 / atb)^2
    c <- c1 + c2 * (1 / atb)
    a + b * (hst - 4.5) + c * (hst - 4.5)^2
  }
)

herman_1978 <- herman_1978 %>% add_model(hstix100)