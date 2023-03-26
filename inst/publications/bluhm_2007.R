bluhm_2007 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "techreport",
  key = "bluhm_2007",
    title = "Taper equation and volume tables for plantation-grown red alder",
    author = "Bluhm, Andrew A and Garber, Sean M and Hibbs, David E",
    volume = 735,
    year = 2007,
    institution = "US Department of Agriculture, Forest Service, Pacific Northwest Research Station"
  ),
  descriptors = list(
    country = c("US", "CA"),
    region = c("US-OR", "US-WA", "CA-BC"),
    family = "Betulaceae", genus = "Alnus", species = "rubra"
  )
)

dsih <- FixedEffectsModel(
  response_unit = list(
    dsih = units::as_units("in")
  ),
  covariate_units = list(
    dsob = units::as_units("in"),
    hst = units::as_units("ft"),
    hsd = units::as_units("in"),
    rc = units::as_units("ft / ft")
  ),
  parameters = list(
    a_1 = 0.9113,
    a_2 = 1.0160,
    a_3 = 0.2623,
    a_4 = -18.7695,
    a_5 = 3.1931,
    a_6 = 0.1631,
    a_7 = 0.4180
  ),
  predict_fn = function(dsob, hst, hsd, rc) {
    z <- hsd / hst
    p <- 4.5 / hst
    x <- (1 - sqrt(z)) / (1 - sqrt(p))
    a_1 * dsob^a_2 * x^(a_3 * (1.364409 * dsob^(1 / 3) * exp(a_4 * z) + exp(a_5 * rc^a_6 * (dsob / hst)^a_7 * z)))
  }
)

bluhm_2007 <- bluhm_2007 %>%
  add_model(dsih)
