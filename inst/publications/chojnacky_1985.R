chojnacky_1985 <- Publication(
  citation = RefManageR::BibEntry(
    key = "chojnacky_1985",
    bibtype = "techreport",
    title = "Pinyon-juniper volume equations for the central Rocky Mountain States",
    author = "Chojnacky, David C",
    volume = 339,
    year = 1985,
    institution = "US Department of Agriculture, Forest Service"
  ),
  descriptors = list(
    country = "US"
  )
)

# two parameter species models
two_params <- FixedEffectsSet(
  response_unit = list(
    vsoa = units::as_units("ft^3")
  ),
  covariate_units = list(
    dsoc = units::as_units("in"),
    hst = units::as_units("ft")
  ),
  parameter_names = c("a", "b"),
  predict_fn = function(dsoc, hst) {
    (a + b * (dsoc^2 * hst))^3
  },
  model_specifications = load_parameter_frame("vsa_chojnacky_1985_1")
)

# three parameter species models
three_params <- FixedEffectsSet(
  response_unit = list(
    vsoa = units::as_units("ft^3")
  ),
  covariate_units = list(
    dsoc = units::as_units("in"),
    hst = units::as_units("ft"),
    single_stem = units::unitless
  ),
  parameter_names = c("a", "b", "c"),
  predict_fn = function(dsoc, hst, single_stem) {
    (a + b * (dsoc^2 * hst + c * single_stem))^3
  },
  model_specifications = load_parameter_frame("vsa_chojnacky_1985_2"),
  covariate_definitions = list(
    single_stem = "Equal to 1 if the tree has one stem, 0 otherwise"
  )
)

# hardwood models
hardwoods <- FixedEffectsSet(
  response_unit = list(
    vsoa = units::as_units("ft^3")
  ),
  covariate_units = list(
    dsoc = units::as_units("in"),
    hst = units::as_units("ft")
  ),
  parameter_names = c("a", "b"),
  predict_fn = function(dsoc, hst) {
    (a + b * (dsoc^2 * hst))^3
  },
  model_specifications = load_parameter_frame("vsa_chojnacky_1985_3")
)

chojnacky_1985 <- chojnacky_1985 %>%
  add_set(two_params) %>%
  add_set(three_params) %>%
  add_set(hardwoods)
