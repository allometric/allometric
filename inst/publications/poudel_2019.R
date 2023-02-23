poudel_2019 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "article",
    key = "poudel_2019",
    title = "Estimating individual-tree aboveground biomass of tree species in the western USA",
    author = "Poudel, Krishna P and Temesgen, Hailemariam and Radtke, Philip J and Gray, Andrew N",
    journal = "Canadian Journal of Forest Research",
    volume = 49,
    number = 6,
    pages = "701--714",
    year = 2019,
    publisher = "NRC Research Press"
  ),
  descriptors = list(
    country = c("US", "CA"),
    region = c(
      "CA-BC", "US-WA", "US-OR",
      "US-CA", "US-NV", "US-ID",
      "US-MT", "US-UT", "US-AZ",
      "US-CO"
    )
  )
)

cvts <- FixedEffectsSet(
  response_unit = list(
    vsia = units::as_units("m^3")
  ),
  covariate_units = list(
    dsob = units::as_units("cm"),
    hst = units::as_units("m")
  ),
  parameter_names = c("a", "b", "c"),
  predict_fn = function(dsob, hst) {
    exp(a + b * log(dsob) + c * log(hst))
  },
  model_specifications = load_parameter_frame("vsa_poudel_2019")
)

# Table 4, models that use a, b and c parameters
agb_1 <- FixedEffectsSet(
  response_unit = list(
    bt = units::as_units("kg")
  ),
  covariate_units = list(
    dsob = units::as_units("cm"),
    hst = units::as_units("m")
  ),
  parameter_names = c("a", "b", "c", "cf"),
  predict_fn = function(dsob, hst) {
    cf * exp(a + b * log(dsob) + c * log(hst))
  },
  model_specifications = load_parameter_frame("bt_poudel_2019_1")
)

# Table 5, models that use a, b, c and d parameters
agb_2 <- FixedEffectsSet(
  response_unit = list(
    bt = units::as_units("kg")
  ),
  covariate_units = list(
    dsob = units::as_units("cm"),
    hst = units::as_units("m")
  ),
  parameter_names = c("a", "b", "c", "d", "cf"),
  predict_fn = function(dsob, hst) {
    cf * exp(a + b * log(dsob) + c * log(hst) + d * hst)
  },
  model_specifications = load_parameter_frame("bt_poudel_2019_2")
)

# Table 5, models that use a and b parameters
agb_3 <- FixedEffectsSet(
  response_unit = list(
    bt = units::as_units("kg")
  ),
  covariate_units = list(
    dsob = units::as_units("cm")
  ),
  parameter_names = c("a", "b", "cf"),
  predict_fn = function(dsob) {
    cf * exp(a + b * log(dsob))
  },
  model_specifications = load_parameter_frame("bt_poudel_2019_3")
)

# Table 6, volume to biomass conversion
v_to_agb <- FixedEffectsSet(
  response_unit = list(
    bt = units::as_units("kg")
  ),
  covariate_units = list(
    vsia = units::as_units("m^3")
  ),
  parameter_names = c("a", "b", "cf"),
  predict_fn = function(vsia) {
    cf * exp(a + b * log(vsia))
  },
  model_specifications = load_parameter_frame("bt_poudel_2019_4")
)

rsbt <- FixedEffectsSet(
  response_unit = list(
    rsbt = units::as_units("kg / kg")
  ),
  covariate_units = list(
    dsob = units::as_units("cm"),
    hst = units::as_units("m")
  ),
  parameter_names = c(
    paste("a", seq(4), sep = "_"),
    paste("b", seq(4), sep = "_"),
    paste("c", seq(4), sep = "_")
  ),
  predict_fn = function(dsob, hst) {
    denom <- sum(
      exp(a_1 + b_1 * log(dsob) + c_1 * log(hst)),
      exp(a_2 + b_2 * log(dsob) + c_2 * log(hst)),
      exp(a_3 + b_3 * log(dsob) + c_3 * log(hst)),
      exp(a_4 + b_4 * log(dsob) + c_4 * log(hst))
    )

    exp(a_1 + b_1 * log(dsob) + c_1 * log(hst)) / denom
  },
  model_specifications = load_parameter_frame("b_poudel_2019")
)

rkbt <- FixedEffectsSet(
  response_unit = list(
    rkbt = units::as_units("kg / kg")
  ),
  covariate_units = list(
    dsob = units::as_units("cm"),
    hst = units::as_units("m")
  ),
  parameter_names = c(
    paste("a", seq(4), sep = "_"),
    paste("b", seq(4), sep = "_"),
    paste("c", seq(4), sep = "_")
  ),
  predict_fn = function(dsob, hst) {
    denom <- sum(
      exp(a_1 + b_1 * log(dsob) + c_1 * log(hst)),
      exp(a_2 + b_2 * log(dsob) + c_2 * log(hst)),
      exp(a_3 + b_3 * log(dsob) + c_3 * log(hst)),
      exp(a_4 + b_4 * log(dsob) + c_4 * log(hst))
    )

    exp(a_2 + b_2 * log(dsob) + c_2 * log(hst)) / denom
  },
  model_specifications = load_parameter_frame("b_poudel_2019")
)


rfbt <- FixedEffectsSet(
  response_unit = list(
    rfbt = units::as_units("kg / kg")
  ),
  covariate_units = list(
    dsob = units::as_units("cm"),
    hst = units::as_units("m")
  ),
  parameter_names = c(
    paste("a", seq(4), sep = "_"),
    paste("b", seq(4), sep = "_"),
    paste("c", seq(4), sep = "_")
  ),
  predict_fn = function(dsob, hst) {
    denom <- sum(
      exp(a_1 + b_1 * log(dsob) + c_1 * log(hst)),
      exp(a_2 + b_2 * log(dsob) + c_2 * log(hst)),
      exp(a_3 + b_3 * log(dsob) + c_3 * log(hst)),
      exp(a_4 + b_4 * log(dsob) + c_4 * log(hst))
    )

    exp(a_3 + b_3 * log(dsob) + c_3 * log(hst)) / denom
  },
  model_specifications = load_parameter_frame("b_poudel_2019")
)

rbbt <- FixedEffectsSet(
  response_unit = list(
    rbbt = units::as_units("kg / kg")
  ),
  covariate_units = list(
    dsob = units::as_units("cm"),
    hst = units::as_units("m")
  ),
  parameter_names = c(
    paste("a", seq(4), sep = "_"),
    paste("b", seq(4), sep = "_"),
    paste("c", seq(4), sep = "_")
  ),
  predict_fn = function(dsob, hst) {
    denom <- sum(
      exp(a_1 + b_1 * log(dsob) + c_1 * log(hst)),
      exp(a_2 + b_2 * log(dsob) + c_2 * log(hst)),
      exp(a_3 + b_3 * log(dsob) + c_3 * log(hst)),
      exp(a_4 + b_4 * log(dsob) + c_4 * log(hst))
    )

    exp(a_4 + b_4 * log(dsob) + c_4 * log(hst)) / denom
  },
  model_specifications = load_parameter_frame("b_poudel_2019")
)

poudel_2019 <- poudel_2019 %>%
  add_set(cvts) %>%
  add_set(agb_1) %>%
  add_set(agb_2) %>%
  add_set(agb_3) %>%
  add_set(v_to_agb) %>%
  add_set(rfbt) %>%
  add_set(rkbt) %>%
  add_set(rsbt) %>%
  add_set(rbbt)
