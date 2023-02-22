hann_1978 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "techreport",
    key = "hann_1978",
    title = "Comprehensive tree volume equations for major species of New Mexico and Arizona. I. Results and methodology. II. Tables for unforked trees",
    institution = "Research Paper, Intermountain Forest and Range Experiment Station, USDA Forest Service",
    author = "Hann, DW and Bare, BB",
    number = "INT-209/No. INT-210",
    year = 1978
  ),
  descriptors = list(
    country = "US",
    region = c("US-AZ", "US-NM")
  )
)

vsia <- FixedEffectsSet(
  response_unit = list(
    vsia = units::as_units('ft^3')
  ),
  covariate_units = list(
    dsob = units::as_units('in'),
    hst = units::as_units('ft')
  ),
  parameter_names = c('a_0', 'a_1'),
  predict_fn = function(dsob, hst) {
    a_0 + a_1 * dsob^2 * hst
  },
  model_specifications = load_parameter_frame('vsa_hann_1978')
)

hann_1978 <- hann_1978 %>%
  add_set(vsia)