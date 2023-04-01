moore_1996 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "article",
    key = "moore_1996",
    title = "Height-diameter equations for ten tree species in the Inland Northwest",
    author = "Moore, James A and Zhang, Lianjun and Stuck, Dean",
    journal = "Western Journal of Applied Forestry",
    volume = 11,
    number = 4,
    pages = "132--137",
    year = 1996,
    publisher = "Oxford University Press"
  ),
  descriptors = list(
    country = "US",
    region = c("US-MT", "US-OR", "US-WA", "US-ID")
  )
)

wykoff_set <- FixedEffectsSet(
  response_unit = list(
    hst = units::as_units("ft")
  ),
  covariate_units = list(
    dsob = units::as_units("in")
  ),
  parameter_names = c("a", "b"),
  predict_fn = function(dsob) {
    4.5 + exp(a + (b / (dsob + 1)))
  },
  model_specifications = load_parameter_frame("hst_moore_1996_1")
)

lundqvist_set <- FixedEffectsSet(
  response_unit = list(
    hst = units::as_units("ft")
  ),
  covariate_units = list(
    dsob = units::as_units("in")
  ),
  parameter_names = c("a", "b", "c"),
  predict_fn = function(dsob) {
    4.5 + a * exp(-b * dsob^(-c))
  },
  model_specifications = load_parameter_frame("hst_moore_1996_2")
)

moore_1996 <- moore_1996 %>%
  add_set(wykoff_set) %>%
  add_set(lundqvist_set)
