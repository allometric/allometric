myers_1964a <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "techreport",
    key = "myers_1964a",
    title = "Volume tables and point-sampling factors for ponderosa pine in the Black Hills",
    author = "Myers, Clifford A",
    institution = "Rocky Mountain Forest and Range Experiment Station, Forest Service, US",
    year = 1964,
    volume = 8
  ),
  descriptors = list(
    country = "US",
    region = c("US-WY", "US-SD"),
    family = "Pinaceae",
    genus = "Pinus",
    species = "ponderosa"
  )
)

covariate_units_hst <- list(
  dsob = units::as_units('in'),
  hst = units::as_units('ft')
)

covariate_units_hsm <- list(
  dsob = units::as_units('in'),
  hsm = units::as_units('ft')
)

parameter_names <- c('a', 'b')

# Table 1
vsom_cuft <- FixedEffectsSet(
  response_unit = list(
    vsom = units::as_units('ft^3')
  ),
  covariate_units = covariate_units_hst,
  predict_fn = function(dsob, hst) {
    a + b * dsob^2 * hst
  },
  parameter_names = parameter_names,
  model_specifications = tibble::tibble(
    d2h = c("<= 6000", "> 6000"),
    a = c(0.030288, -1.557103),
    b = c(0.002213, 0.002474)
  )
)

# Table 2
vsom_cuft_2 <- FixedEffectsSet(
  response_unit = list(
    vsom = units::as_units('ft^3')
  ),
  covariate_units = covariate_units_hst,
  predict_fn = function(dsob, hst) {
    a + b * dsob^2 * hst
  },
  parameter_names = parameter_names,
  model_specifications = tibble::tibble(
    d2h = c("<= 6700", "> 6700"),
    a = c(-1.032297, -2.257724),
    b = c(0.002297, 0.002407)
  )
)

# Table 3
rsvg_cuft <- FixedEffectsSet(
  response_unit = list(
    rsvg = units::as_units("ft^3 / ft^2")
  ),
  covariate_units = covariate_units_hst,
  parameter_names = parameter_names,
  predict_fn = function(dsob, hst) {
    a * hst + b / dsob^2
  },
  model_specifications = tibble::tibble(
    tree_size = c("small", "large"),
    a = c(-189.2734, -413.9575),
    b = c(0.4212, 0.4413)
  )
)

# Table 4
vsom_bdfts <- FixedEffectsSet(
  response_unit = list(
    vsom = units::as_units("board_foot")
  ),
  covariate_units = covariate_units_hst,
  parameter_names = parameter_names,
  predict_fn = function(dsob, hst) {
    a + b * dsob^2 * hst
  },
  model_specifications = tibble::tibble(
    bdft_rule = "Scribner",
    d2h = c('<= 16000', '> 16000'),
    a = c(-34.167170, -99.212720),
    b = c(0.012331, 0.016318)
  )
)

# Table 5
rsvg_bdfts <- FixedEffectsSet(
  response_unit = list(
    rsvg = units::as_units("board_foot / ft^2")
  ),
  covariate_units = covariate_units_hst,
  parameter_names = parameter_names,
  predict_fn = function(dsob, hst) {
    a * hst + b / dsob^2
  },
  model_specifications = tibble::tibble(
    bdft_rule = "Scribner",
    tree_size = c('small', 'large'),
    a = c(2.609, 2.9919),
    b = c(-6264.6076, -18190.8177)
  )
)

# Table 6
vsom_bdfts_logs <- FixedEffectsSet(
  response_unit = list(
    vsom = units::as_units("board_foot")
  ),
  covariate_units = covariate_units_hsm,
  parameter_names = parameter_names,
  predict_fn = function(dsob, hsm) {
    a + b * dsob^2 * hsm
  },
  model_specifications = tibble::tibble(
    bdft_rule = "Scribner",
    d2h = c('<= 1200', '> 1200'),
    a = c(1.737800, -56.188070),
    b = c(0.264275, 0.312659)
  ),
  covariate_definitions = list(
    hsm = "Number of 16-foot logs to 8-inch top"
  )
)

# Table 7
rsvg_bdfts_logs <- FixedEffectsSet(
  response_unit = list(
    rsvg = units::as_units("board_foot / ft^2")
  ),
  covariate_units = covariate_units_hsm,
  parameter_names = parameter_names,
  predict_fn = function(dsob, hsm) {
    a * hsm + b / dsob^2
  },
  model_specifications = tibble::tibble(
    bdft_rule = "Scribner",
    tree_size = c('small', 'large'),
    a = c(48.4538, 57.3247),
    b = c(318.6285, -10302.1764)
  ),
  covariate_definitions = list(
    hsm = "Number of 16-foot logs to 8-inch top"
  )
)

# Table 8
vsom_bdfti <- FixedEffectsSet(
  response_unit = list(
    vsom = units::as_units("board_foot")
  ),
  covariate_units = covariate_units_hst,
  parameter_names = parameter_names,
  predict_fn = function(dsob, hst) {
    a + b * dsob^2 * hst
  },
  model_specifications = tibble::tibble(
    bdft_rule = "International 1/4-inch",
    d2h = c('<= 13000', '> 13000'),
    a = c(-44.360460, -68.750200),
    b = c(0.015011, 0.016991)
  )
)

# Table 9
rsvg_bdfti <- FixedEffectsSet(
  response_unit = list(
    rsvg = units::as_units("board_foot / ft^2")
  ),
  covariate_units = covariate_units_hst,
  parameter_names = parameter_names,
  predict_fn = function(dsob, hst) {
    a * hst + b / dsob^2
  },
  model_specifications = tibble::tibble(
    bdft_rule = "International 1/4-inch",
    tree_size = c('small', 'large'),
    a = c(2.7523, 3.1153),
    b = c(-8133.5644, -12605.4639)
  )
)

# Table 10
vsom_bdfti_logs <- FixedEffectsSet(
  response_unit = list(
    vsom = units::as_units("board_foot")
  ),
  covariate_units = covariate_units_hsm,
  parameter_names = parameter_names,
  predict_fn = function(dsob, hsm) {
    a + b * dsob^2 * hsm
  },
  model_specifications = tibble::tibble(
    bdft_rule = "International 1/4-inch",
    d2h = c('<= 1100', '> 1100'),
    a = c(2.338510, -5.939610),
    b = c(0.312621, 0.318669)
  ),
  covariate_definitions = list(
    hsm = "Number of 16-foot logs to 8-inch top"
  )
)

# Table 11
rsvg_bdfti_logs <- FixedEffectsSet(
  response_unit = list(
    rsvg = units::as_units("board_foot / ft^2")
  ),
  covariate_units = covariate_units_hsm,
  parameter_names = parameter_names,
  predict_fn = function(dsob, hsm) {
    a * hsm + b / dsob^2
  },
  model_specifications = tibble::tibble(
    bdft_rule = "International 1/4-inch",
    tree_size = c('small', 'large'),
    a = c(57.3196, 58.4285),
    b = c(428.7697, -1089.0374)
  ),
  covariate_definitions = list(
    hsm = "Number of 16-foot logs to 8-inch top"
  )
)

myers_1964a <- myers_1964a %>%
  add_set(vsom_cuft) %>%
  add_set(vsom_cuft_2) %>%
  add_set(rsvg_cuft) %>%
  add_set(vsom_bdfts) %>%
  add_set(rsvg_bdfts) %>%
  add_set(vsom_bdfts_logs) %>%
  add_set(rsvg_bdfts_logs) %>%
  add_set(vsom_bdfti) %>%
  add_set(rsvg_bdfti) %>%
  add_set(vsom_bdfti_logs) %>%
  add_set(rsvg_bdfti_logs)
