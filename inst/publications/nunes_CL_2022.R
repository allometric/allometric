# Models for crown width Nunes et al. 2022.
nunes_CL_2022_citation <- RefManageR::BibEntry(
  bibtype = "article",
  key = "nunes_2022",
  title = "Bulk Density of Shrub Types and Tree Crowns to Use with Forest Inventories in the Iberian Peninsula",
  author = "Nunes, L., Pasalodos-Tato, M., Alberdi, I., Sequeira, A.C., Vega, J.A., Silva, V., Vieira, P., and Rego, F.C.",
  volume = 13,
  issn = "1999-4907",
  doi = "10.3390/f13040555",
  number = 4,
  journal = "Forests",
  year = 2022,
  keywords = "trees", "bulk density equations", "fire behavior", "Portugal", "shrubs", "Spain"
)

nunes_CL_2022 <- Publication(
  citation = nunes_CL_2022_citation,
  descriptors = list(
    country = "EU-ES"
  )
)

model_specifications <- load_parameter_frame("nunes_CL_2022")

nunes_CL_2022 <- add_set(nunes_CL_2022, FixedEffectsSet(
  response_unit = list(
    vsia = units::as_units("m")
  ),
  covariate_units = list(
    hst = units::as_units("m"),
    tph  = units::as_units("ft")
  ),
  parameter_names = c("a0", "a1"),
  predict_fn = function(hst,tph) {
    hts/(1+a0*exp(-a1*(10000/tph)^(-0.5)))
  },
  model_specifications = model_specifications
))