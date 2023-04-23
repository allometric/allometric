king_1966 <- Publication(
  citation = RefManageR::BibEntry(
    key = "king_1966",
    bibtype = "techreport",
    title = "Site index curves for Douglas-fir in the Pacific Northwest",
    author = "King, James E.",
    year = 1966,
    number = 8,
    institution = "Weyerhaeuser Forestry Research Center"
  ),
  descriptors = list(
    family = "Pinaceae",
    genus = "Pseudotsuga",
    species = "menziesii",
    country = "US",
    region = "US-WA"
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
    a = 0.954038,
    b = -0.0558178,
    c = 0.000733819,
    d = 0.109757,
    e = 0.00792236,
    f = 0.000197693
  ),
  predict_fn = function(hst, atb) {
    4.5 + 2500 / ((atb^2 / (hst - 4.5) + a + b * atb + c * atb^2) / (d + e * atb + f * atb^2))
  }
)

king_1966 <- king_1966 %>% add_model(hstix50)