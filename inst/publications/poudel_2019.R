poudel_2019 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "article",
    key = "poudel_2019",
    title = "Estimating individual-tree aboveground biomass of tree species in the western USA",
    author = "Poudel, Krishna P and Temesgen, Hailemariam and Radtke, Philip J and Gray, Andrew N",
    journal = "Canadian Journal of Forest Research",
    volume = 49,
    number = 6,
    pages = "701--714",
    year = 2019,
    publisher = "NRC Research Press"
  ),
  descriptors = list(
    country = c("US", "CA"),
    region = c(
      "CA-BC", "US-WA", "US-OR",
      "US-CA", "US-NV", "US-ID",
      "US-MT", "US-UT", "US-AZ",
      "US-CO"
    )
  )
)

cvts <- FixedEffectsSet(
  response_unit = list(
    vsa = units::as_units("m^3")
  ),
  covariate_units = list(
    dsob = units::as_units("cm"),
    hst = units::as_units("m")
  ),
  parameter_names = c("a", "b", "c"),
  predict_fn = function(dsob, hst) {
    exp(a + b * log(dsob) + c * log(hst))
  },
  model_specifications = load_parameter_frame("vsa_poudel_2019")
)

poudel_2019 <- add_set(poudel_2019, cvts)