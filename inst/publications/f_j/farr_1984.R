farr_1984 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "techreport",
    key = "farr_1984",
    title = "Site index and height growth curves for unmanaged even-aged stands of western hemlock and Sitka spruce in southeast Alaska.",
    author = "Farr, Wilbur",
    number = 326,
    year = 1984,
    institution = "Pacific Northwest Forest and Range Experiment Station"
  ),
  descriptors = list(
    region = "US-AK",
    country = "US"
  )
)

pisi.hstix50 <- FixedEffectsModel(
  response_unit = list(
    hstix50 = units::as_units("ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    atb = units::as_units("years")
  ),
  parameters = list(
    a = 90.93,
    b = 6.396816,
    c = -4.098921,
    d = 0.7628741,
    e = -0.00244688,
    f = 2.445811e-7,
    g = -2.022153e-22,
    h = -0.2050542,
    i = 1.449615,
    j = -0.01780992,
    k = 6.519748e-5,
    l = -1.095593e-23
  ),
  predict_fn = function(hst, atb) {
    log_atb <- log(atb)
    x4 <- b + c * log_atb + d * log_atb^2 + e * log_atb^5 +
      f * log_atb^10 + g * log(atb)^30

    x5 <- h + i * log_atb + j * log_atb^3 + k * log_atb^5 +
      l * log_atb^30

    a - exp(x4) * exp(x5) + exp(x4) * (hst - 4.5)
  },
  descriptors = list(
    family = "Pinaceae",
    genus = "Picea",
    species = "sitchensis"
  )
)

tshe.hstix50 <- FixedEffectsModel(
  response_unit = list(
    hstix50 = units::as_units("ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    atb = units::as_units("years")
  ),
  parameters = list(
    a = 87.7,
    b = -0.5004715,
    c = 1.082291,
    d = -0.2673998,
    e = 8.355966e-6,
    f = -7.751521e-9,
    g = 7.142552e-27,
    h = 0.3621734,
    i = 1.149181,
    j = -0.005617852,
    k = -7.267547e-6,
    l = 1.708195e-16,
    m = -2.482794e-22
  ),
  predict_fn = function(hst, atb) {
    log_atb <- log(atb)
    x1 <- b + c * log_atb + d * log_atb^2 + e * log_atb^8 +
      f * log_atb^12 + g * log(atb)^36

    x2 <- h + i * log_atb + j * log_atb^3 + k * log_atb^7 +
      l * log_atb^22 + m * log_atb^30

    a - exp(x1) * exp(x2) + exp(x1) * (hst - 4.5)
  },
  descriptors = list(
    family = "Pinaceae",
    genus = "Tsuga",
    species = "heterophylla"
  )
)

farr_1984 <- farr_1984 %>%
  add_model(pisi.hstix50) %>%
  add_model(tshe.hstix50)