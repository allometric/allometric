fvs_2008 <- Publication(
  citation = RefManageR::BibEntry(
    key = "fvs_2008",
    bibtype = "techreport",
    title = "Pacific Northwest Coast (PN) Variant Overview – Forest Vegetation Simulator",
    author = "FVS Staff",
    year = 2008,
    institution = "U.S. Department of Agriculture, Forest Service, Forest Management Service Center"
  ),
  descriptors = list(
    country = "US",
    region = c("US-OR", "US-WA")
  )
)

# Curtis-Arney functional form, 4.1.1a, non-df
curtis_arney_not_df <- FixedEffectsSet(
  response_unit = list(
    hst = units::as_units("ft")
  ),
  covariate_units = list(
    dsob = units::as_units("in")
  ),
  parameter_names = c("p2", "p3", "p4"),
  predict_fn = function(dsob) {
    if(dsob >= 3) {
      4.5 + p2 * exp(-p3 * dsob^p4)
    } else {
      ((4.5 + p2 * exp(-p3 * 3 * dsob^p4) - 4.51) * ((dsob - 0.3) / 2.7)) + 4.51
    }
  },
  model_specifications = load_parameter_frame("fvs_hst_2008_1") %>%
    dplyr::filter(genus != "Pseudotsuga")
)


fvs_2008 <- fvs_2008 %>%
  add_set(curtis_arney_not_df)