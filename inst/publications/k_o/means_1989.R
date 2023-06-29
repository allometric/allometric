means_1989 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "article",
    key = "means_1989",
    title = "Height Growth and Site Index Curves for Douglas-Fir in the Siuslaw National Forest, Oregon",
    author = "Means, JF and Sabin, TE",
    journal = "Western Journal of Applied Forestry",
    volume = 4,
    number = 4,
    year = 1989
  ),
  descriptors = list(
    country = "US",
    region = "US-OR",
    family = "Pinaceae",
    genus = "Pseudotsuga",
    species = "menziesii"
  )
)

# Eq. 6
hstix50 <- FixedEffectsModel(
  response_unit = list(
    hstix50 = units::as_units("ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    atb = units::as_units("years")
  ),
  parameters = list(
    b0 = 1.42956,
    b1 = 0.37900,
    b2 = 65.11,
    b3 = -0.022733,
    b4 = 1.27157
  ),
  predict_fn = function(hst, atb) {
    39.77 + (b0 / exp(atb / 50) + b1 * exp(atb / 300)) *
      (hst - b2 * (1 - exp(b3 * atb))^b4)
  }
)

means_1989 <- means_1989 %>%
  add_model(hstix50)