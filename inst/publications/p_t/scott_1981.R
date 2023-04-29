scott_1981 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "techreport",
    key = "scott_1981",
    title = "Northeastern forest survey revised cubic-foot volume equations",
    author = "Charles Thomas Scott",
    volume = 304,
    year = 1981,
    institution = "US Department of Agriculture, Forest Service"
  ),
  descriptors = list(
    country = 'US',
    region = c(
      'US-TN', 'US-OH', 'US-WV', 'US-MD', 'US-DE', 'US-PA', 'US-NJ', 'US-NY',
      'US-CT', 'US-RI', 'US-MA', 'US-VT', 'US-NH', 'US-ME'
    )
  )
)

vsm_spc <- FixedEffectsSet(
  response_unit = list(
    vsia = units::as_units('ft^3')
  ),
  covariate_units = list(
    dsob = units::as_units('in'),
    hsm = units::as_units('ft')
  ),
  parameter_names = c('b_0', 'b_1', 'b_2', 'b_3', 'b_4', 'b_5'),
  predict_fn = function(dsob, hsm) {
    b_0 + b_1 * dsob^b_2 + b_3 * dsob^(b_4) * hsm^b_5
  },
  model_specifications = load_parameter_frame('vsm_scott_1981_1')
)

vsm_grp <- FixedEffectsSet(
  response_unit = list(
    vsia = units::as_units('ft^3')
  ),
  covariate_units = list(
    dsob = units::as_units('in'),
    hsm = units::as_units('ft')
  ),
  parameter_names = c('b_0', 'b_1', 'b_2', 'b_3', 'b_4', 'b_5'),
  predict_fn = function(dsob, hsm) {
    b_0 + b_1 * dsob^b_2 + b_3 * dsob^(b_4) * hsm^b_5
  },
  model_specifications = load_parameter_frame('vsm_scott_1981_2')
)


scott_1981 <- scott_1981 %>%
  add_set(vsm_spc) %>%
  add_set(vsm_grp)