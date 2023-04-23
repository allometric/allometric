kozak_1988 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "article",
    key = "kozak_1988",
    title = "A variable-exponent taper equation",
    journal = "Canadian Journal of Forest Research",
    author = "Kozak, A",
    volume = 18,
    number = 11,
    pages = "1363--1368",
    year = 1988,
    publisher = "NRC Research Press Ottawa, Canada"
  ),
  descriptors = list(
    country = "CA",
    region = "CA-BC"
  )
)

taper <- FixedEffectsSet(
  response_unit = list(
    dsih = units::as_units("cm")
  ),
  covariate_units = list(
    hst = units::as_units("m"),
    hsd = units::as_units("m"),
    dsob = units::as_units("cm")
  ),
  parameter_names = c("a_0", "a_1", "a_2", "b_1", "b_2", "b_3", "b_4", "b_5"),
  predict_fn = function(hst, hsd, dsob) {
    x <- (1 - sqrt(hsd / hst)) / (1 - sqrt(p))
    z <- hsd / hst
    a_0 * dsob^a_1 * a_2^dsob * x^(b_1 * z^2 + b_2 * log(z + 0.001) + b_3 * sqrt(z) + b_4 * exp(z) + b_5 * (dsob / hst))
  },
  model_specifications = tibble::tibble(load_parameter_frame("kozak_1988"))
)

kozak_1988 <- kozak_1988 %>% add_set(taper)