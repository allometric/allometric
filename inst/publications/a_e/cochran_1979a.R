cochran_1979a <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "techreport",
    key = "cochran_1979a",
    title = "Site index and height growth curves for managed, even-aged stands of white or grand fir east of the Cascades in Oregon and Washington",
    author = "Cochran, PH",
    volume = 252,
    year = 1979,
    institution = "Department of Agriculture, Forest Service, Pacific Northwest Forest and Range Experiment Station"
  ),
  descriptors = list(
    country = "US",
    region = c("US-OR", "US-WA")
  )
)

hstix50.wf <- FixedEffectsModel(
  response_unit = list(
    hstix50 = units::as_units("ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    atb = units::as_units("years")
  ),
  parameters = list(
    a = 3.886,
    b = -1.8017,
    c = 0.2105,
    d = -0.0000002885,
    e = 0.000000000000000001187,
    f = -0.30935,
    g = 1.2383,
    h = 0.001762,
    i = -0.0000054,
    j = 0.0000002046,
    k = - 0.000000000000404

  ),
  predict_fn = function(hst, atb) {
    log_atb <- log(atb)
    x1 <- a + b * log_atb + c * log_atb^2 + d * log_atb^9 + e * log_atb
    x2 <- f + g * log_atb + h * log_atb^4 + i * log_atb^9 + j * log_atb^11 + k * log_atb^18

    (hst - 4.5) * exp(x1) - exp(x1) * exp(x2) + 89.43
  },
  descriptors = list(
    family = "Pinaceae",
    genus = "Abies",
    species = "concolor"
  )
)

hstix50.gf <- hstix50.wf
descriptors(hstix50.gf) <- tibble::tibble(
  family = "Pinaceae", genus = "Abies", species = "grandis"
)

cochran_1979a <- cochran_1979a %>%
  add_model(hstix50.wf) %>%
  add_model(hstix50.gf)
