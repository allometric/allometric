dolph_1991 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "techreport",
    key = "dolph_1991",
    title = "Polymorphic site index curves for red fir in California and southern Oregon",
    author = "Dolph, K Leroy",
    volume = 206,
    year = 1991,
    institution = "US Department of Agriculture, Forest Service, Pacific Southwest Research Station"
  ),
  descriptors = list(
    country = "US",
    region = c("US-CA", "US-OR"),
    family = "Pinaceae",
    genus = "Abies",
    species = "magnifica"
  )
)

# Dolph does not explicitly give a site index function, see p. 3, paragraph
# starting with "Equation 3 expresses...", therefore only the height function
# is made here.
hst <- FixedEffectsModel(
  response_unit = list(
    hst = units::as_units("ft")
  ),
  covariate_units = list(
    hstix50 = units::as_units("ft"),
    atb = units::as_units("years")
  ),
  parameters = list(
    b1 = 1.51744,
    b2 = 1.41512 * 10^-6,
    b3 = -4.40853 * 10^-2,
    b4 = -3.04951 * 10^6,
    b5 = 5.72474 * 10^-4
  ),
  predict_fn = function(hstix50, atb) {
    B <- atb * exp(atb * b3) * b2 * hstix50 + (atb * exp(atb * b3) * b2)^2 *
      b4 + b5
    B50 <- 50 * exp(atb * b3) * b2 * hstix50 + (50 * exp(50 * b3) * b2)^2 *
      b4 + b5

    ((hstix50 - 4.5) * (1 - exp(-B * atb^b1))) / (1 - exp(-B50 * 50^b1)) + 4.5
  }
)

dolph_1991 <- dolph_1991 %>%
  add_model(hst)
