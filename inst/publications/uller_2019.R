uller_2019 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "article",
    key = "uller_2019",
    author = "Uller, Heitor Felippe and Zimermann Oliveira, Laio and Klitzke, Aline Renata and Roberto Eleotério, Jackson and Fantini, Alfredo Celso and Vibrans, Alexander Christian",
    title = "Aboveground biomass quantification and tree-level prediction models for the Brazilian subtropical Atlantic Forest",
    journal = "Southern Forests",
    volume = 81,
    number = 3,
    pages = "261--271",
    year = 2019,
    publisher = "NISC"
  ),
  descriptors = list(
    country = "BR",
    region = "BR-SC"
  )
)

mod_1 <- FixedEffectsModel(
  response_unit = list(bt = units::as_units("kg")),
  covariate_units = list(dsob = units::as_units("cm")),
  parameters = list(
    beta_0 = -48.4365,
    beta_1 = 0.6467
  ),
  predict_fn = function(dsob) {
    beta_0 + beta_1 * dsob^2
  }
)

mod_2 <- FixedEffectsModel(
  response_unit = list(bt = units::as_units("kg")),
  covariate_units = list(dsob = units::as_units("cm")),
  parameters = list(
    beta_0 = -2.3702,
    beta_1 = 2.5179,
    bcf = 1.0542
  ),
  predict_fn = function(dsob) {
    exp(log(beta_0) + beta_1 * log(dsob)) * bcf
  }
)

mod_3 <- FixedEffectsModel(
  response_unit = list(bt = units::as_units("kg")),
  covariate_units = list(
    dsob = units::as_units("cm"),
    hst = units::as_units("m")
  ),
  parameters = list(
    beta_0 = 25.9310,
    beta_1 = 0.0258
  ),
  predict_fn = function(dsob, hst) {
    beta_0 + beta_1 * (dsob^2 * hst)
  }
)

mod_4 <- FixedEffectsModel(
  response_unit = list(bt = units::as_units("kg")),
  covariate_units = list(
    dsob = units::as_units("cm"),
    hst = units::as_units("m")
  ),
  parameters = list(
    beta_0 = -3.4062,
    beta_1 = 0.9774,
    bcf = 1.0494
  ),
  predict_fn = function(dsob, hst) {
    exp(log(beta_0) + beta_1 * log(dsob^2 * hst)) * bcf
  }
)

mod_5 <- FixedEffectsModel(
  response_unit = list(bt = units::as_units("kg")),
  covariate_units = list(
    dsob = units::as_units("cm"),
    hst = units::as_units("m")
  ),
  parameters = list(
    beta_0 = -3.1284,
    beta_1 = 2.1077,
    beta_2 = -0.7103,
    bcf = 1.0468
  ),
  predict_fn = function(dsob, hst) {
    exp(log(beta_0) + beta_1 * log(dsob) + beta_2 * log(hst)) * bcf
  }
)

mod_6 <- FixedEffectsModel(
  response_unit = list(bt = units::as_units("kg")),
  covariate_units = list(
    dsob = units::as_units("cm"),
    hst = units::as_units("m")
  ),
  parameters = list(
    beta_0 = -3.1501,
    beta_1 = 2.0693,
    beta_2 = 0.7595,
    bcf = 1.0456
  ),
  predict_fn = function(dsob, hst) {
    exp(log(beta_0) + beta_1 * log(dsob^2) + beta_2 * log(hst)) * bcf
  }
)

mod_7 <- FixedEffectsModel(
  response_unit = list(bt = units::as_units("kg")),
  covariate_units = list(
    dsob = units::as_units("cm"),
    rsd = units::as_units("kg / m^3")
  ),
  parameters = list(
    beta_0 = -9.0086,
    beta_1 = 2.4606,
    beta_2 = 1.0895,
    bcf = 1.0206
  ),
  predict_fn = function(dsob, rsd) {
    exp(log(beta_0) + beta_1 * log(dsob) + beta_2 * log(rsd)) * bcf
  }
)

mod_8 <- FixedEffectsModel(
  response_unit = list(bt = units::as_units("kg")),
  covariate_units = list(
    dsob = units::as_units("cm"),
    hst = units::as_units("m"),
    rsd = units::as_units("kg / m^3")
  ),
  parameters = list(
    beta_0 = 10.2861,
    beta_1 = 0.00005
  ),
  predict_fn = function(dsob, hst, rsd) {
    beta_0 + beta_1 * (dsob^2 * hst * rsd)
  }
)

mod_9 <- FixedEffectsModel(
  response_unit = list(bt = units::as_units("kg")),
  covariate_units = list(
    dsob = units::as_units("cm"),
    hst = units::as_units("m"),
    rsd = units::as_units("kg / m^3")
  ),
  parameters = list(
    beta_0 = -9.1954,
    beta_1 = 0.9561,
    bcf = 1.0209
  ),
  predict_fn = function(dsob, hst, rsd) {
    exp(log(beta_0) + beta_1 * log(dsob^2 * hst * rsd)) * bcf
  }
)

mod_10 <- FixedEffectsModel(
  response_unit = list(bt = units::as_units("kg")),
  covariate_units = list(
    dsob = units::as_units("cm"),
    hst = units::as_units("m"),
    rsd = units::as_units("kg / m^3")
  ),
  parameters = list(
    beta_0 = -8.8907,
    beta_1 = 2.1642,
    beta_2 = 0.5072,
    beta_3 = 0.9999,
    bcf = 1.0175
  ),
  predict_fn = function(dsob, hst, rsd) {
    exp(log(beta_0) + beta_1 * log(dsob) + beta_2 * log(hst) + beta_3 * log(rsd)) * bcf
  }
)

uller_2019 <- uller_2019 %>%
  add_model(mod_1) %>%
  add_model(mod_2) %>%
  add_model(mod_3) %>%
  add_model(mod_4) %>%
  add_model(mod_5) %>%
  add_model(mod_6) %>%
  add_model(mod_7) %>%
  add_model(mod_8) %>%
  add_model(mod_9) %>%
  add_model(mod_10)
