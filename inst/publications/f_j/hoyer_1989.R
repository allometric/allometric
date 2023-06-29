hoyer_1989 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "techreport",
    key = "hoyer_1989",
    title = "Height-age and site index curves for Pacific silver fir in the Pacific Northwest",
    author = "Hoyer, Gerald E and Herman, Francis R",
    volume = 418,
    year = 1989,
    institution = "US Department of Agriculture, Forest Service, Pacific Northwest Research Station"
  ),
  descriptors = list(
    family = "Pinaceae",
    genus = "abies",
    species = "amibalis",
    country = "US",
    region = c("US-OR", "US-WA")
  )
)

# Eq. 4 - the selected height model
hst <- FixedEffectsModel(
  response_unit = list(
    hst = units::as_units("ft")
  ),
  covariate_units = list(
    hstix100 = units::as_units("ft"),
    atb = units::as_units("years")
  ),
  parameters = list(
    c = 0.0071839,
    d = 0.0000571,
    f = 1.39005
  ),
  predict_fn = function(hstix100, atb)  {
    hstix100 * (1 - exp(-(c + d *hstix100) * atb))^f /
    (1 - exp(-(c+ d * S) * 100))
  }
)

# Eq. 8 - Site index at 100
hstix100 <- FixedEffectsModel(
  response_unit = list(
    hstix100 = units::as_units("ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    atb = units::as_units("years")
  ),
  parameters = list(
    a = -0.0268797,
    b = 0.0046259,
    c = -0.0015862,
    d = -0.0761453,
    e = 0.0891105
  ),
  predict_fn = function(hst, atb) {
    hst * exp(
      a * (atb - 100) / atb +
      b * (atb - 100)^2 / 100 +
      c * (atb - 100)^3 / 10000 +
      d * (atb - 100) / sqrt(hst) +
      e * (atb - 100) / hst
    )
  }
)

hoyer_1989 <- hoyer_1989 %>%
  add_model(hst) %>%
  add_model(hstix100)