rustagi_1991 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "article",
    key = "rustagi_1991",
    title = "Compatible variable-form volume and stem-profile equations for Douglas-fir",
    author = "Rustagi, Krishna P and Loveless Jr, Robert S",
    journal = "Canadian Journal of Forest Research",
    volume = 21,
    number = 2,
    pages = "143--151",
    year = 1991,
    publisher = "NRC Research Press Ottawa, Canada"
  ),
  descriptors = list(
    country = c("US", "CA"),
    region = c("US-OR", "US-WA", "CA-BC"),
    family = "Pinaceae",
    genus = "Pseudotsuga",
    species = "menziesii"
  )
)

eq_20 <- FixedEffectsModel(
  response_unit = list(
    vsio = units::as_units("m^3")
  ),
  covariate_units = list(
    dsib = units::as_units("cm"),
    hso = units::as_units("m"),
    hsdip75 = units::as_units("m")
  ),
  parameters = list(
    kb_0 = 0.000014599,
    kb_1 = 0.000052801
  ),
  predict_fn = function(dsib, hso, hsdip75) {
    kb_0 * (dsib)^2 * hso + kb_1 * (dsib)^2 * (hsdip75 - 1.37)
  }
)

eq_21 <- FixedEffectsModel(
  response_unit = list(
    vsio = units::as_units("m^3")
  ),
  covariate_units = list(
    dsib = units::as_units("cm"),
    hso = units::as_units("m"),
    hsdop67 = units::as_units("m")
  ),
  parameters = list(
    kb_0 = 0.000010912,
    kb_1 = 0.000051610
  ),
  predict_fn = function(dsib, hso, hsdop67) {
    kb_0 * (dsib)^2 * hso + kb_1 * (dsib)^2 * (hsdop67 - 1.37)
  }
)

eq_22 <- FixedEffectsModel(
  response_unit = list(
    vsio = units::as_units("m^3")
  ),
  covariate_units = list(
    dsob = units::as_units("cm"),
    hso = units::as_units("m"),
    hsdop67 = units::as_units("m")
  ),
  parameters = list( # The authors transformed the parameter estimates away from eq. 13, so I use a-f as parameter names
    k = 7.854e-5,
    a = 0.0067803,
    b = -0.042807,
    c = 0.067566,
    d = 0.065611,
    e = -0.41423,
    f = 0.65380
  ),
  predict_fn = function(dsob, hso, hsdop67) {
    k * (a * hso + b * dsob * hso + c * dsob^2 * hso + d * (hsdop67 - 1.37)) +
      e * dsob * (hsdop67 - 1.37) + f * dsob^2 * (hsdop67 - 1.37)
  }
)

rustagi_1991 <- rustagi_1991 %>%
  add_model(eq_20) %>%
  add_model(eq_21) %>%
  add_model(eq_22)
