ritchie_1987 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "techreport",
    key = "ritche_1987",
    title = "Equations for predicting height to crown base for fourteen tree species in southwest Oregon",
    author = "Ritchie, Martin W and Hann, David W",
    institution = "Oregon State University",
    year = 1987
  ),
  descriptors = list(
    country = "US",
    region = "US-OR"
  )
)

rc_1 <- FixedEffectsSet(
  response_unit = list(
    rc = units::as_units("ft / ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    ccfl = units::as_units("ft^2 / ft^2"),
    gs_s = units::as_units("ft^2 / acre"),
    dsob = units::as_units("in"),
    hstix50 = units::as_units("ft")
  ),
  parameter_names = paste("b_", seq(0, 5), sep = ""),
  predict_fn = function(hst, ccfl, gs_s, dsob, hstix50) {
    1 - ((1) / (1 + exp(b_0 + b_1 * hst + b_2 * ccfl + b_3 * log(gs_s) + b_4 * (dsob / hst) + b_5 * (hstix50 - 4.5))))
  },
  model_specifications = load_parameter_frame("rc_ritchie_1987_1"),
  covariate_definitions = list(
    ccfl = "crown competition factor of large trees"
  )
)

rc_2 <- FixedEffectsSet(
  response_unit = list(
    rc = units::as_units("ft / ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    ccfl = units::as_units("ft^2 / ft^2"),
    gs_s = units::as_units("ft^2 / acre")
  ),
  parameter_names = paste("b_", seq(0, 3), sep = ""),
  predict_fn = function(hst, ccfl, gs_s) {
    1 - ((1) / (1 + exp(b_0 + b_1 * hst + b_2 * ccfl + b_3 * log(gs_s))))
  },
  model_specifications = load_parameter_frame("rc_ritchie_1987_2"),
  covariate_definitions = list(
    ccfl = "crown competition factor of large trees"
  )
)

rc_3 <- FixedEffectsSet(
  response_unit = list(
    rc = units::as_units("ft / ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    ccfl = units::as_units("ft^2 / ft^2"),
    gs_s = units::as_units("ft^2 / acre"),
    dsob = units::as_units("in")
  ),
  parameter_names = c("b_0", "b_2", "b_3", "b_4"),
  predict_fn = function(hst, ccfl, gs_s, dsob) {
    1 - ((1) / (1 + exp(b_0 + b_2 * ccfl + b_3 * log(gs_s) + b_4 * (dsob / hst))))
  },
  model_specifications = load_parameter_frame("rc_ritchie_1987_3"),
  covariate_definitions = list(
    ccfl = "crown competition factor of large trees"
  )
)

rc_4 <- FixedEffectsSet(
  response_unit = list(
    rc = units::as_units("ft / ft")
  ),
  covariate_units = list(
    ccfl = units::as_units("ft^2 / ft^2")
  ),
  parameter_names = c("b_0", "b_2"),
  predict_fn = function(ccfl) {
    1 - ((1) / (1 + exp(b_0 + b_2 * ccfl)))
  },
  model_specifications = load_parameter_frame("rc_ritchie_1987_4"),
  covariate_definitions = list(
    ccfl = "crown competition factor of large trees"
  )
)

rc_tanoak <- FixedEffectsModel(
  response_unit = list(
    rc = units::as_units("ft / ft")
  ),
  covariate_units = list(
    ccfl = units::as_units("ft^2 / ft^2")
  ),
  parameters = list(
    b_2 = -0.00088567
  ),
  predict_fn = function(ccfl) {
    1 - ((1) / (1 + exp(b_2 * ccfl)))
  },
  descriptors = list(family = "Fagaceae", genus = "Notholithocarpus", species = "densiflorus"),
  covariate_definitions = list(
    ccfl = "crown competition factor of large trees"
  )
)

rc_canyon_live_oak <- FixedEffectsModel(
  response_unit = list(
    rc = units::as_units("ft / ft")
  ),
  covariate_units = list(
    gs_s = units::as_units("ft^2 / acre")
  ),
  parameters = list(
    b_0 = 2.22352,
    b_3 = -0.426931
  ),
  predict_fn = function(gs_s) {
    1 - ((1) / (1 + exp(b_0 + b_3 * log(gs_s))))
  },
  descriptors = list(family = "Fagaceae", genus = "Quercus", species = "chrysolepis")
)

rc_black_oak <- FixedEffectsModel(
  response_unit = list(
    rc = units::as_units("ft / ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    dsob = units::as_units("in"),
    gs_s = units::as_units("ft^2 / acre")
  ),
  parameters = list(
    b_0 = 2.65524,
    b_3 = -0.646829,
    b_4 = 0.728396
  ),
  predict_fn = function(dsob, hst, gs_s) {
    1 - ((1) / (1 + exp(b_0 + b_3 * log(gs_s) + b_4 * (dsob / hst))))
  },
  descriptors = list(family = "Fagaceae", genus = "Quercus", species = "kelloggii")
)

rc_bigleaf_maple <- FixedEffectsModel(
  response_unit = list(
    rc = units::as_units("ft / ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    ccfl = units::as_units("ft^2 / ft^2")
  ),
  parameters = list(
    b_0 = 0.919152,
    b_1 = -0.00768402,
    b_2 = -0.00618461
  ),
  predict_fn = function(hst, ccfl) {
    1 - ((1) / (1 + exp(b_0 + b_1 * hst + b_2 * ccfl)))
  },
  descriptors = list(family = "Fagaceae", genus = "Quercus", species = "kelloggii"),
  covariate_definitions = list(
    ccfl = "crown competition factor of large trees"
  )
)

ritchie_1987 <- ritchie_1987 %>%
  add_set(rc_1) %>%
  add_set(rc_2) %>%
  add_set(rc_3) %>%
  add_set(rc_4) %>%
  add_model(rc_tanoak) %>%
  add_model(rc_canyon_live_oak) %>%
  add_model(rc_black_oak) %>%
  add_model(rc_bigleaf_maple)
