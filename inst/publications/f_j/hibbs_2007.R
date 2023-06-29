hibbs_2007 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "article",
    key = "hibbs_2011",
    title = "Stem taper and volume of managed red alder",
    author = "Hibbs, David and Bluhm, Andrew and Garber, Sean",
    journal = "Western Journal of Applied Forestry",
    volume = 22,
    number = 1,
    pages = "61--66",
    year = 2007,
    publisher = "Oxford University Press"
  ),
  descriptors = list(
    country = c("US", "CA"),
    region = c("US-OR", "US-WA", "CA-BC"),
    family = "Betulaceae",
    genus = "Alnus",
    species = "rubra"
  )
)

dsih <- FixedEffectsModel(
  response_unit = list(
    dsih = units::as_units("in")
  ),
  covariate_units = list(
    dsob = units::as_units("in"),
    hst = units::as_units("ft"),
    hsd = units::as_units("in")
  ),
  parameters = list(
    a_1 = 0.8995,
    a_2 = 1.0205,
    a_3 = 0.2631,
    a_4 = -18.8990,
    a_5 = 4.2549,
    a_6 = 0.6221
  ),
  predict_fn = function(dsob, hst, hsd) {
    z <- hsd / hst
    p <- hst / 4.5
    x <- (1 - sqrt(z)) / (1 - sqrt(p))
    a_1 * dsob^a_2 * x^(a_3 * (1.364409 * dsob^(1 / 3) * exp(a_4 * z) + exp(a_5 * (dsob / hst)^a_6 * z)))
  }
)

hibbs_2007 <- add_model(hibbs_2007, dsih)
