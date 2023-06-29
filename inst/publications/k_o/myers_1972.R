myers_1972 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "techreport",
    key = "myers_1972",
    title = "Volume tables and point-sampling factors for Engelmann spruce in Colorado and Wyoming",
    author = "Myers, Clifford A and Edminster, Carleton B",
    volume = 95,
    year = 1972,
    institution = "Rocky Mountain Forest and Range Experiment Station, Forest Service"
  ),
  descriptors = list(
    country = "US",
    region = c("US-CO", "US-WY"),
    family = "Pinaceae",
    genus = "Picea",
    species = "engelmanii"
  )
)

vol_func <- function(dsob, hst) {
  a + b * dsob^2 * hst
}

vbar_func <- function(dsob, hst) {
  a * hst - b / dsob^2
}

covt_units_ht <- list(
  dsob = units::as_units('in'),
  hst = units::as_units('ft')
)

covt_units_logs <- list(
  dsob = units::as_units('in'),
  hsm = units::unitless
)

param_names <- c('a', 'b')

cuft_vol <- FixedEffectsSet(
  response_unit = list(
    vsoa = units::as_units('ft^3')
  ),
  covariate_units = covt_units_ht,
  parameter_names = param_names,
  predict_fn = vol_func,
  model_specifications = load_parameter_frame('vsa_myers_1972_1')
)

cuft_vbar <- FixedEffectsSet(
  response_unit = list(
    rsvg = units::as_units('ft^3 / ft^2')
  ),
  covariate_units = covt_units_ht,
  parameter_names = param_names,
  predict_fn = vbar_func,
  model_specifications = load_parameter_frame('rsvg_myers_1972_1')
)

bdft_vol_logs <- FixedEffectsSet(
  response_unit = list(
    vsom = units::as_units('board_foot')
  ),
  covariate_units = covt_units_logs,
  parameter_names = param_names,
  predict_fn = function(dsob, hsm) {a + b * dsob^2 * hsm},
  model_specifications = load_parameter_frame('vsm_myers_1972_1'),
  covariate_definitions = list(
    hsm = "Number of 16 foot logs to merchantable top"
  )
)

bdft_vol_feet <- FixedEffectsSet(
  response_unit = list(
    vsim = units::as_units('board_foot')
  ),
  covariate_units = covt_units_ht,
  parameter_names = param_names,
  predict_fn = vol_func,
  model_specifications = load_parameter_frame('vsm_myers_1972_2')
)

bdft_vbar_logs <- FixedEffectsSet(
  response_unit = list(
    rsvg = units::as_units('ft^3 / ft^2')
  ),
  covariate_units = covt_units_logs,
  parameter_names = param_names,
  predict_fn = function(dsob, hsm) {a * hsm + b / dsob^2},
  model_specifications = load_parameter_frame('rsvg_myers_1972_2'),
  covariate_definitions = list(
    hsm = "Number of 16 foot logs to merchantable top"
  )
)

bdft_vbar_feet <- FixedEffectsSet(
  response_unit = list(
    rsvg = units::as_units('ft^3 / ft^2')
  ),
  covariate_units = covt_units_ht,
  parameter_names = param_names,
  predict_fn = vbar_func,
  model_specifications = load_parameter_frame('rsvg_myers_1972_3')
)

myers_1972 <- myers_1972 %>%
  add_set(cuft_vol) %>%
  add_set(bdft_vol_logs) %>%
  add_set(cuft_vbar) %>%
  add_set(bdft_vol_feet) %>%
  add_set(bdft_vbar_feet) %>%
  add_set(bdft_vbar_logs)