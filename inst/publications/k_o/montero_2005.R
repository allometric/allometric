
montero_2005 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "techreport",
    key = "montero_2005",
    title = "Biomass production and CO2 fixation by Spanish forests",
    author = "Montero, Gregorio and Ruiz-Peinado, Ricardo and Munoz, Marta",
    volume = 13,
    year = 2005,
    institution = "National Institute for Agricultural and Food Research and Technology"
  ),
  descriptors = list(
    country = "ES"
  )
)

# Here we are going to specify model sets in a loop
b_params <- load_parameter_frame("b_montero_2005")
b_param_names <- unique(b_params$allo_var)

for (b_param_name in b_param_names) {
  response_unit <- list()
  response_unit[[b_param_name]] <- units::as_units("kg")
  covariate_units <- list(dsob = units::as_units("cm"))


  # Nest the regions
  model_spec <- b_params %>%
    dplyr::filter(allo_var == b_param_name) %>%
    dplyr::select(-name) %>%
    dplyr::group_by(allo_var, family, genus, species, a, b, cf) %>%
    dplyr::summarise(region = list(region)) %>%
    dplyr::ungroup()

  model_spec <- model_spec[, -1] # drop allo_var column

  set <- FixedEffectsSet(
    response_unit = response_unit,
    covariate_units = covariate_units,
    parameter_names = c("a", "b", "cf"),
    predict_fn = function(dsob) {
      cf * exp(a) * dsob^b
    },
    model_specifications = model_spec
  )

  montero_2005 <- montero_2005 %>% add_set(set)
}

# Branch biomass
bb_params <- load_parameter_frame("bb_montero_2005")

#
bb_spec <- bb_params %>%
  dplyr::select(-name) %>%
  dplyr::group_by(family, genus, species, branch_size, a, b, cf) %>%
  dplyr::summarise(region = list(region)) %>%
  dplyr::ungroup()

bb_set <- FixedEffectsSet(
  response_unit = list(bb = units::as_units("kg")),
  covariate_units = covariate_units,
  parameter_names = c("a", "b", "cf"),
  predict_fn = function(dsob) {
    cf * exp(a) * dsob^b
  },
  model_specifications = bb_spec
)

montero_2005 <- montero_2005 %>% add_set(bb_set)

# Others - total tree
bt_others <- FixedEffectsSet(
  response_unit = list(
    bt = units::as_units("kg")
  ),
  covariate_units = list(
    dsob = units::as_units("cm")
  ),
  parameter_names = c("a", "b", "cf"),
  predict_fn = function(dsob) {
    cf * exp(a) * dsob^b
  },
  model_specifications = tibble::tibble(
    species_group = c("conifers", "hardwoods", "subtropical"),
    a = c(-2.21637, -1.87511, -1.36216),
    b = c(2.35162, 2.29843, 2.2644),
    cf = c(1.002727, 1.000108, 1.00024)
  )
)

# Others - root
br_others <- FixedEffectsSet(
  response_unit = list(
    br = units::as_units("kg")
  ),
  covariate_units = list(
    dsob = units::as_units("cm")
  ),
  parameter_names = c("a", "b", "cf"),
  predict_fn = function(dsob) {
    cf * exp(a) * dsob^b
  },
  model_specifications = tibble::tibble(
    species_group = c("conifers", "hardwoods", "subtropical"),
    a = c(-2.46359, -1.38199, -1.38356),
    b = c(2.13727, 1.96764, 2.05614),
    cf = c(1.026789, 1.002029, 1.000693)
  )
)

montero_2005 <- montero_2005 %>%
  add_set(bt_others) %>%
  add_set(br_others)
