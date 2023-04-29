hahn_1991 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "article",
    key = "hahn_1991",
    title = "Cubic and board foot volume models for the Central States",
    author = "Hahn, Jerold T and Hansen, Mark H",
    journal = "Northern Journal of Applied Forestry",
    volume = 8,
    number = 2,
    pages = "46--57",
    year = 1991,
    publisher = "Oxford University Press"
  ),
  descriptors = list(
    country = "US",
    region = c("US-IN", "US-IL", "US-MO", "US-IA")
  )
)

cuvol <- FixedEffectsSet(
  response_unit = list(vsia = units::as_units("ft^3")),
  covariate_units = list(
    hstix = units::as_units("ft"),
    dsob = units::as_units("in")
  ),
  parameter_names = c("b_1", "b_2", "b_3", "b_4"),
  predict_fn = function(hstix, dsob) {
    b_1 * hstix^b_2 * (1 - exp(b_3 * dsob^b_4))
  },
  covariate_definitions = list(
    hstix = "Site index at an un-specified base age."
  ),
  model_specifications = load_parameter_frame("vsa_hahn_1991_1")
)

bdft <- FixedEffectsSet(
  response_unit = list(vsia = units::as_units("board_foot")),
  covariate_units = list(
    hstix = units::as_units("ft"),
    dsob = units::as_units("in")
  ),
  parameter_names = c("b_1", "b_2", "b_3", "b_4"),
  predict_fn = function(hstix, dsob) {
    b_1 * hstix^b_2 * (1 - exp(b_3 * dsob^b_4))
  },
  covariate_definitions = list(
    hstix = "Site index at an un-specified base age."
  ),
  model_specifications = load_parameter_frame("vsa_hahn_1991_2")
)

hahn_1991 <- hahn_1991 %>%
  add_set(cuvol) %>%
  add_set(bdft)
