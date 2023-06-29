curtis_1974 <- Publication(
  citation = RefManageR::BibEntry(
    key = "curtis_1974",
    bibtype = "article",
    title = "Height growth and site index for Douglas-fir in high-elevation forests of the Oregon-Washington Cascades",
    author = "Curtis, Robert O and Herman, Francis R and DeMars, Donald J",
    volume = 20,
    number = 4,
    pages = "307--316",
    year = 1974,
    journal = "Forest Science"
  ),
  descriptors = list(
    family = "Pinaceae",
    genus = "Pseudotsuga",
    species = "menziesii",
    country = "US",
    region = c("US-OR", "US-WA")
  )
)

eq3_lte100 <- FixedEffectsModel(
  response_unit = list(
    hstix100 = units::as_units("ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    atb = units::as_units("years")
  ),
  parameters = list(
    alpha_1 = 0.010006,
    beta_1 = 1,
    beta_2 = 0.00549779,
    beta_3 = 1.46842e-14
  ),
  predict_fn = function(hst, atb) {
    alpha <- alpha_1 * (100 - atb)^2
    beta <- beta_1 + beta_2 * (100 - atb) + beta_3 * (100 - atb)^7
    alpha + beta * (hst - 4.5) + 4.5
  },
  descriptors = list(
    age_class = "<= 100"
  )
)

eq3_gt100 <- FixedEffectsModel(
  response_unit = list(
    hstix100 = units::as_units("ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    atb = units::as_units("years")
  ),
  parameters = list(
    alpha_1 = 7.66772,
    alpha_2 = -0.95,
    beta_1 = 1,
    beta_2 = -0.730948,
    beta_3 = 0.80
  ),
  predict_fn = function(hst, atb) {
    alpha <- alpha_1 * (exp(alpha_2 * (100 / (atb - 100))^2))
    beta <- beta_1 + beta_2 * (log(atb, base = 10) - 2)^beta_3
    alpha + beta * (hst - 4.5) + 4.5
  },
  descriptors = list(
    age_class = "> 100"
  )
)

curtis_1974 <- curtis_1974 %>%
  add_model(eq3_lte100) %>%
  add_model(eq3_gt100)
