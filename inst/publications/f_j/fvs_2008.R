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

# Curtis-Arney functional form, 4.1.1a
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
      ((4.5 + p2 * exp(-p3 * 3^p4) - 4.51) * ((dsob - 0.3) / 2.7)) + 4.51
    }
  },
  model_specifications = load_parameter_frame("fvs_hst_2008_1") %>%
    dplyr::filter(
      (
        genus == "Pseudotsuga" &
        !geographic_region %in% c("612 Siuslaw, 712 BLM Coos", "708 BLM Salem")
      ) | genus != "Pseudotsuga"
    )
)

curtis_arney_df <- FixedEffectsSet(
  response_unit = list(
    hst = units::as_units("ft")
  ),
  covariate_units = list(
    dsob = units::as_units("in")
  ),
  parameter_names = c("p2", "p3", "p4"),
  predict_fn = function(dsob) {
    if(dsob >= 5) {
      4.5 + p2 * exp(-p3 * dsob^p4)
    } else {
      ((4.5 + p2 * exp(-p3 * 5^p4) - 4.51) * (dsob - 0.3) / 4.7) + 4.51
    }
  },
  model_specifications = load_parameter_frame("fvs_hst_2008_1") %>%
    dplyr::filter(
      genus == "Pseudotsuga" &
      geographic_region %in% c("612 Siuslaw, 712 BLM Coos", "708 BLM Salem")
    )
)

wykoff <- FixedEffectsSet(
  response_unit = list(
    hst = units::as_units("ft")
  ),
  covariate_units = list(
    dsob = units::as_units("in")
  ),
  parameter_names = c("b1", "b2"),
  predict_fn = function(dsob) {
    4.5 + exp(b1 + b2 / (dsob + 1))
  },
  load_parameter_frame("fvs_hst_2008_2")
)



fvs_2008 <- fvs_2008 %>%
  add_set(curtis_arney_not_df) %>%
  add_set(curtis_arney_df) %>%
  add_set(wykoff)