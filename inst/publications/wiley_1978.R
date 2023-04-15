wiley_1978 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "techreport",
    key = "wiley_1978",
    title = "Site index tables for western hemlock in the Pacific Northwest",
    author = "Wiley, Kenneth N.",
    institution = "Weyerhaeuser",
    number = 17,
    year = 1978
  ),
  descriptors = list(
    family = "Pinaceae",
    genus = "Tsuga",
    species = "heterophylla",
    country = c("US", "CA"),
    region = c("US-OR", "US-WA", "CA-BC")
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
    a = 0.1394,
    b = 0.0137,
    c = 0.00007,
    d = -1.7307,
    e = -0.0616,
    f = 0.00192
  ),
  predict_fn = function(hst, atb) {
    2500 * (((hst - 4.5) * (a + b * atb + c * atb^2)) / 
      (atb^2 - (hst - 4.5) * (d + e * atb + f * atb^2))) + 4.5
  }
)

wiley_1978 <- wiley_1978 %>% add_model(hstix50)