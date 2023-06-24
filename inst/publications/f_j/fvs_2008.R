fvs_2008 <- Publication(
  citation = RefManageR::BibEntry(
    key = "fvs_2008",
    bibtype = "techreport",
    title = "Pacific Northwest Coast (PN) Variant Overview - Forest Vegetation Simulator",
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
  model_specifications = load_parameter_frame("hst_fvs_2008_1") %>%
    dplyr::filter(
      (
        genus == "Pseudotsuga" &
        !geographic_region %in% c("612 - Siuslaw, 712 - BLM Coos", "708 - BLM Salem")
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
  model_specifications = load_parameter_frame("hst_fvs_2008_1") %>%
    dplyr::filter(
      genus == "Pseudotsuga" &
      geographic_region %in% c("612 - Siuslaw, 712 - BLM Coos", "708 - BLM Salem")
    )
)

# Eq. 4.1.2
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
  load_parameter_frame("hst_fvs_2008_2")
)

# Eq. 4.1.3. first group
first_413 <- FixedEffectsSet(
  response_unit = list(
    hst = units::as_units("ft")
  ),
  covariate_units = list(
    dsob = units::as_units("in"),
    rc = units::as_units("ft/ft")
  ),
  parameter_names = c("h1", "h2", "h3", "h4", "h5"),
  predict_fn = function(dsob, rc) {
    exp(h1 + (h2 * dsob) + (h3 * rc * 100) + (h4 * dsob^2) + h5)
  },
  load_parameter_frame("hst_fvs_2008_3")
)


# Eq. 4.1.3. second group
second_413 <- FixedEffectsSet(
  response_unit = list(
    hst = units::as_units("ft")
  ),
  covariate_units = list(
    dsob = units::as_units("in"),
    rc = units::as_units("ft/ft")
  ),
  parameter_names = c("h1", "h2", "h3", "h4", "h5"),
  predict_fn = function(dsob, rc) {
    h1 + (h2 * dsob) + (h3 * rc * 100) + (h4 * dsob^2) + h5
  },
  load_parameter_frame("hst_fvs_2008_4")
)

# Eq. 4.1.3. third group TODO

# Eq. 4.3.1.1. & 4.3.1.2.
rc <- FixedEffectsSet(
  response_unit = list(
    rc = units::as_units("ft / ft")
  ),
  covariate_units = list(
    hst = units::as_units("ft"),
    gs_s = units::as_units("ft^2 / acre")
  ),
  parameter_names = c("r1", "r2", "r3"),
  predict_fn = function(hst, gs_s) {
    x <- r1 + r2 * hst + r3 * gs_s
    ((x - 1) * 10 + 1) / 100
  },
  model_specifications = load_parameter_frame("rc_fvs_2008")
)

fvs_2008 <- fvs_2008 %>%
  add_set(curtis_arney_not_df) %>%
  add_set(curtis_arney_df) %>%
  add_set(wykoff) %>%
  add_set(first_413) %>%
  add_set(second_413) %>%
  add_set(rc)