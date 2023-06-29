hann_1987 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "techreport",
    key = "hann_1987",
    title = "Dominant-height-growth and site-index equations for Douglas-fir and ponderosa pine in southwest Oregon",
    author = "Hann, David W and Scrivani, John A and others",
    institution = "Oregon State University",
    year = 1987
  ),
  descriptors = list(
    country = "US",
    region = "US-OR"
  )
)


hstix50_psme <- FixedEffectsModel(
  response_unit = list(
    hstix50 = units::as_units("ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    atb = units::as_units("yr")
  ),
  parameters = list(
    b_1 = -0.0521778,
    b_2 = 0.000715141,
    b_3 = 0.00797252,
    b_4 = -0.000133377
  ),
  predict_fn = function(hst, atb) {
    4.5 + (hst - 4.5) * exp(b_1 * (atb - 50) + b_2 * (atb - 50)^2 + b_3 * (atb - 50) * log(hst - 4.5) + b_4 * (atb - 50)^2 * log(hst - 4.5))
  },
  descriptors = list(
    family = "Pinaceae",
    genus = "Pseudotsuga",
    species = "menziesii"
  )
)

hstix50_pipo <- FixedEffectsModel(
  response_unit = list(
    hstix50 = units::as_units("ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    atb = units::as_units("yr")
  ),
  parameters = list(
    b_1 = -0.0699340,
    b_2 = 0.000359644,
    b_3 = 0.0120483,
    b_4 = -0.0000718058
  ),
  predict_fn = function(hst, atb) {
    4.5 + (hst - 4.5) * exp(b_1 * (atb - 50) + b_2 * (atb - 50)^2 + b_3 * (atb - 50) * log(hst - 4.5) + b_4 * (atb - 50)^2 * log(hst - 4.5))
  },
  descriptors = list(
    family = "Pinaceae",
    genus = "Pinus",
    species = "ponderosa"
  )
)

hann_1987 <- hann_1987 %>%
  add_model(hstix50_psme) %>%
  add_model(hstix50_pipo)
