chojnacky_1994 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "techreport",
    key = "chojnacky_1994",
    title = "Volume equations for New Mexico's pinyon-juniper dryland forests. Forest Service research paper",
    author = "Chojnacky, DC",
    year = 1994,
    institution = "Forest Service, Ogden, UT (United States). Intermountain Research Station"
  ),
  descriptors = list(
    country = "US",
    region = "US-NM"
  )
)

vsoa_small <- FixedEffectsSet(
  response_unit = list(
    vsoa = units::as_units('ft^3')
  ),
  covariate_units = list(
    dsoc = units::as_units('in'),
    hst = units::as_units('ft')
  ),
  parameter_names = c('beta_0', 'beta_1', 'beta_2'),
  predict_fn = function(dsoc, hst) {
    X <- dsoc^2 * hst / 1000
    beta_0 + beta_1 * X + beta_2 * X^2
  },
  model_specifications = load_parameter_frame('vsa_chojnacky_1994')
)

vsoa_large <- FixedEffectsSet(
  response_unit = list(
    vsoa = units::as_units('ft^3')
  ),
  covariate_units = list(
    dsoc = units::as_units('in'),
    hst = units::as_units('ft')
  ),
  parameter_names = c('beta_0', 'beta_1', 'beta_2', 'X_0'),
  predict_fn = function(dsoc, hst) {
    X <- dsoc^2 * hst / 1000
    beta_0 + beta_1 * X + beta_2 * (3 * X_0^2 - 2 * X_0^3 / X)
  },
  model_specifications = load_parameter_frame('vsa_chojnacky_1994')
)

chojnacky_1994 <- chojnacky_1994 %>%
  add_set(vsoa_small) %>%
  add_set(vsoa_large)