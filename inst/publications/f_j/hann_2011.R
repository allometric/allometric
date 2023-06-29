hann_2011 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "TechReport",
    key = "hann_2011",
    title = "Revised volume and taper equations for six major conifer species in southwest Oregon",
    author = "Hann, David W",
    institution = "Oregon State University",
    volume = 2,
    year = 2011
  ),
  descriptors = list(
    country = "US",
    region = "US-OR"
  )
)

dsib <- FixedEffectsSet(
  response_unit = list(
    dsib = units::as_units("in")
  ),
  covariate_units = list(
    dsob = units::as_units("in"),
    rc = units::as_units("ft/ft")
  ),
  parameter_names = c("b_1", "b_2", "b_3"),
  predict_fn = function(dsob, rc) {
    b_1 * dsob^b_2 * exp(b_3 * (1 - rc)^(0.5))
  },
  model_specifications = tibble::tibble(
    load_parameter_frame("dsib_hann_2011")
  )
)

dui1 <- FixedEffectsSet(
  response_unit = list(
    dui1 = units::as_units("in")
  ),
  covariate_units = list(
    dsob = units::as_units("in"),
    rc = units::as_units("ft/ft")
  ),
  parameter_names = c("b_1", "b_2", "b_3", "b_4", "b_5"),
  predict_fn = function(dsob, rc) {
    b_1 + b_2 * dsob^b_3 * exp(b_4 * rc^b_5)
  },
  model_specifications = tibble::tibble(
    load_parameter_frame("dui1_hann_2011")
  )
)

vsio <- FixedEffectsSet(
  response_unit = list(
    vsio = units::as_units("ft^3")
  ),
  covariate_units = list(
    hso = units::as_units("ft"),
    dsob = units::as_units("in"),
    hsv = units::as_units("ft")
  ),
  parameter_names = c("b_1", "b_2", "b_3", "b_4", "k", "b_5", "b_7"),
  predict_fn = function(hso, dsob, hsv) {
    b_1 * (hso / dsob)^(b_2 * (1 - exp(b_3 * dsob^b_4)))^k *
      exp(b_5 * (hsv / hso)) * dsob^b_7 * dsob^2 * hso
  },
  model_specifications = tibble::tibble(load_parameter_frame("vso_hann_2011"))
)

hann_2011 <- hann_2011 %>%
  add_set(dsib) %>%
  add_set(dui1) %>%
  add_set(vsio)
