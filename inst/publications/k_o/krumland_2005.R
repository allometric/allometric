krumland_2005_citation <- RefManageR::BibEntry(
  bibtype = "techreport",
  key = "krumland_2005",
  title = "Site index systems for major young-growth forest and woodland species in northern California",
  author = "Krumland, Bruce & Eng, Helge",
  year = 2005,
  institution = "State of California, The Resources Agency, Department of Forestry and Fire Protection"
)


krumland_2005 <- Publication(
  citation = krumland_2005_citation,
  descriptors = list(
    country = "US",
    region = "US-CA"
  )
)

model_specifications <- load_parameter_frame("hstix_krumland_2005")

krumland_2005_cr1_model_set <- FixedEffectsSet(
  response_unit = list(
    hstixi = units::as_units("ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    atb = units::as_units("years"),
    ati = units::as_units("years")
  ),
  parameter_names = c("b_1", "b_2"),
  predict_fn = function(hst, atb, ati) {
    4.5 + (hst - 4.5) * ((1 - exp(b_1 * ati)) / (1 - exp(b_1 * atb))) ^ b_2
  },
  model_specifications = model_specifications %>%
    dplyr::select(-c(b_3, b_4)) %>%
    dplyr::filter(model == "CR1")
)

krumland_2005_cr2_model_set <- FixedEffectsSet(
  response_unit = list(
    hstixi = units::as_units("ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    atb = units::as_units("years"),
    ati = units::as_units("years")
  ),
  parameter_names = c("b_1", "b_2", "b_3"),
  predict_fn = function(hst, atb, ati) {
    L_0 <- log(hst - 4.5)
    Y_0 <- log(1 - exp(b_1 * atb))
    R_0 <- ((L_0 - b2 * Y_0) + sqrt((L_0 - b_2 * Y_0) ^ 2 - 4 * b_3 * Y_0)) / 2
    hstixi <- 4.5 + (hst - 4.5) * ((1 - exp(b_1 * ati)) / (1 - exp(b_1 * atb)))^
      (b_2 + b_3 / R_0)
  },
  model_specifications = model_specifications %>%
    dplyr::select(-c(b_4)) %>%
    dplyr::filter(model == "CR2")
)

krumland_2005_sh1_model_set <- FixedEffectsSet(
  response_unit = list(
    hstixi = units::as_units("ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    atb = units::as_units("years"),
    ati = units::as_units("years")
  ),
  parameter_names = c("b_1", "b_2"),
  predict_fn = function(hst, atb, ati) {
    R_0 <- log(hst - 4.5) - (b_1 * atb ^ b_2)
    hstixi <- 4.5 + exp(R_0 + b_1 * ati ^ b_2)
  },
  model_specifications = model_specifications %>%
    dplyr::select(-c(b_3, b_4)) %>%
    dplyr::filter(model == "SH1")
)

krumland_2005_sh2_model_set <- FixedEffectsSet(
  response_unit = list(
    hstixi = units::as_units("ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    atb = units::as_units("years"),
    ati = units::as_units("years")
  ),
  parameter_names = c("b_1", "b_2", "b_3", "b_4"),
  predict_fn = function(hst, atb, ati) {
    R_0 <- (log(hst - 4.5) - b_1 - b_2 * atb ^ b_4) / (1 + b_3 * atb ^ b_4)
    hstixi <- 4.5 + exp(b_1 + R_0 + (b_2 + b_3 * R_0) * ati ^ b_2)
  },
  model_specifications = model_specifications %>%
    dplyr::filter(model == "SH2")
)

krumland_2005_kp1_model_set <- FixedEffectsSet(
  response_unit = list(
    hstixi = units::as_units("ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    atb = units::as_units("years"),
    ati = units::as_units("years")
  ),
  parameter_names = c("b_1", "b_2", "b_3"),
  predict_fn = function(hst, atb, ati) {
    R_0 <- (((atb ^ b_1) / (hst - 4.5)) - b_2) / (b_3 + atb ^ b_1)
    hstixi <- 4.5 + ((ati ^ b_1) / (b_2 + b_3 * R_0 + R_0 * ati ^ b_1))
  },
  model_specifications = model_specifications %>%
    dplyr::select(-c(b_4)) %>%
    dplyr::filter(model == "KP1")
)

krumland_2005_lg1_model_set <- FixedEffectsSet(
  response_unit = list(
    hstixi = units::as_units("ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    atb = units::as_units("years"),
    ati = units::as_units("years")
  ),
  parameter_names = c("b_1", "b_2", "b_3"),
  predict_fn = function(hst, atb, ati) {
    L_0 <- (hst - 4.5)
    Y_0 <- exp(b_3 * log(atb))
    R_0 <- ((L_0 - b_1) + sqrt((L_0 - b_1) ^ 2 + 4 * b_2 * Y_0 * L_0)) / 2
    hstixi <- 4.5 + (b1 + R_0) / (1 + (b_2 / R_0) * exp(b_3 * log(ati)))
  },
  model_specifications = model_specifications %>%
    dplyr::select(-c(b_4)) %>%
    dplyr::filter(model == "LG1")
)

krumland_2005 <- krumland_2005 %>%
  add_set(krumland_2005_cr1_model_set) %>%
  add_set(krumland_2005_cr2_model_set) %>%
  add_set(krumland_2005_kp1_model_set) %>%
  add_set(krumland_2005_lg1_model_set) %>%
  add_set(krumland_2005_sh1_model_set) %>%
  add_set(krumland_2005_sh2_model_set)