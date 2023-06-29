huynh_2022 <- Publication(
  citation = RefManageR::BibEntry(
    key = "huynh_2022",
    bibtype = "article",
    title = "Allometric equations to estimate aboveground biomass in spotted gum (Corymbia citriodora subspecies variegata) plantations in Queensland",
    author = "Huynh, Trinh and Lewis, Tom and Applegate, Grahame and Pachas, Anibal Nahuel A and Lee, David J",
    journal = "Forests",
    volume = 13,
    number = 3,
    pages = 486,
    year = 2022,
    publisher = "MDPI"
  ),
  descriptors = list(
    country = "AU",
    region = "AU-QLD",
    family = "Myrtaceae",
    genus = "Corymbia",
    species = "citriodora"
  )
)

all_params <- load_parameter_frame("huynh_2022")

model_group <- list(
  "3" = list(
    parameter_names = c("alpha", "beta"),
    covariate_units = list(
      dsob = units::as_units("cm")
    ),
    predict_fn = function(dsob) {
      alpha * dsob^beta
    }
  ),
  "4" = list(
    parameter_names = c("alpha", "beta"),
    covariate_units = list(
      hst = units::as_units("m")
    ),
    predict_fn = function(hst) {
      alpha * hst^beta
    }
  ),
  "5" = list(
    parameter_names = c("alpha", "beta", "beta_1"),
    covariate_units = list(
      dsob = units::as_units("cm"),
      hst = units::as_units("m")
    ),
    predict_fn = function(dsob, hst) {
      alpha * dsob^beta * hst^beta_1
    }
  ),
  "6" = list(
    parameter_names = c("alpha", "beta"),
    covariate_units = list(
      dsob = units::as_units("cm"),
      hst = units::as_units("m")
    ),
    predict_fn = function(dsob, hst) {
      alpha * (dsob^2 * hst)^beta
    }
  ),
  "7" = list(
    parameter_names = c("alpha", "beta", "beta_1"),
    covariate_units = list(
      dsob = units::as_units("cm"),
      rwd = units::as_units("kg / m^3")
    ),
    predict_fn = function(dsob, rwd) {
      alpha * dsob^beta * rwd^beta_1
    }
  ),
  "8" = list(
    parameter_names = c("alpha", "beta", "beta_1", 'beta_2'),
    covariate_units = list(
      dsob = units::as_units("cm"),
      hst = units::as_units("m"),
      rwd = units::as_units("kg / m^3")
    ),
    predict_fn = function(dsob, hst, rwd) {
      alpha * dsob^beta + hst^beta_1 + rwd^beta_2
    }
  ),
  "9" = list(
    parameter_names = c("alpha", "beta"),
    covariate_units = list(
      dsob = units::as_units("cm"),
      hst = units::as_units("m"),
      rwd = units::as_units("kg / m^3")
    ),
    predict_fn = function(dsob, hst, rwd) {
      alpha * (dsob^2 * hst * rwd)^beta
    }
  ),
  "10" = list(
    parameter_names = c("alpha", "beta"),
    covariate_units = list(
      dsob = units::as_units("cm")
    ),
    predict_fn = function(dsob) {
      alpha * dsob^beta
    }
  ),
  "11" = list(
    parameter_names = c("alpha", "beta"),
    covariate_units = list(
      hst = units::as_units("m")
    ),
    predict_fn = function(hst) {
      alpha * hst^beta
    }
  ),
  "12" = list(
    parameter_names = c("alpha", "beta"),
    covariate_units = list(
      dc = units::as_units("m")
    ),
    predict_fn = function(dc) {
      alpha * dc^beta
    }
  ),
  "13" = list(
    parameter_names = c("alpha", "beta", "beta_1"),
    covariate_units = list(
      dsob = units::as_units("cm"),
      dc = units::as_units("m")
    ),
    predict_fn = function(dsob, dc) {
      alpha * dsob^beta * dc^beta_1
    }
  ),
  "14" = list(
    parameter_names = c("alpha", "beta", "beta_1", "beta_2"),
    covariate_units = list(
      dsob = units::as_units("cm"),
      hst = units::as_units("m"),
      dc = units::as_units("m")
    ),
    predict_fn = function(dsob, hst, dc) {
      alpha * dsob^beta * hst^beta_1 * dc^beta_2
    }
  ),
  "15" = list(
    parameter_names = c("alpha", "beta"),
    covariate_units = list(
      dsob = units::as_units("cm"),
      hst = units::as_units("m"),
      dc = units::as_units("m")
    ),
    predict_fn = function(dsob, hst, dc) {
      alpha * (dsob^2 * hst* dc)^beta
    }
  ),
  "16" = list(
    parameter_names = c("alpha", "beta", "beta_1", "beta_2", "beta_3"),
    covariate_units = list(
      dsob = units::as_units("cm"),
      hst = units::as_units("m"),
      rwd = units::as_units("kg / m^3"),
      dc = units::as_units("m")
    ),
    predict_fn = function(dsob, hst, rwd, dc) {
      alpha * dsob^beta * hst^beta_1 * rwd^beta_2 * dc^beta_3
    }
  ),
  "17" = list(
    parameter_names = c("alpha", "beta"),
    covariate_units = list(
      dsob = units::as_units("cm"),
      hst = units::as_units("m"),
      rwd = units::as_units("kg / m^3"),
      dc = units::as_units("m")
    ),
    predict_fn = function(dsob, hst, rwd, dc) {
      alpha * (dsob^2 * hst * rwd * dc)^beta
    }
  ),
  "18" = list(
    parameter_names = c("alpha", "beta"),
    covariate_units = list(
      vc = units::as_units("cm^3")
    ),
    predict_fn = function(vc) {
      alpha * vc^beta
    }
  ),
  "19" = list(
    parameter_names = c("alpha", "beta", "beta_1"),
    covariate_units = list(
      dsob = units::as_units("cm"),
      vc = units::as_units("cm^3")
    ),
    predict_fn = function(dsob, vc) {
      alpha * dsob^beta * vc^beta_1
    }
  ),
  "20" = list(
    parameter_names = c("alpha", "beta", "beta_1", "beta_2"),
    covariate_units = list(
      dsob = units::as_units("cm"),
      hst = units::as_units("m"),
      vc = units::as_units("cm^3")
    ),
    predict_fn = function(dsob, hst, vc) {
      alpha * dsob^beta * hst^beta_1 * vc^beta_2
    }
  ),
  "21" = list(
    parameter_names = c("alpha", "beta"),
    covariate_units = list(
      dsob = units::as_units("cm"),
      hst = units::as_units("m"),
      vc = units::as_units("cm^3")
    ),
    predict_fn = function(dsob, hst, vc) {
      alpha * (dsob^2 * hst * vc)^beta
    }
  ),
  "22" = list(
    parameter_names = c("alpha", "beta", "beta_1", "beta_2", "beta_3"),
    covariate_units = list(
      dsob = units::as_units("cm"),
      hst = units::as_units("m"),
      rwd = units::as_units("kg / m^3"),
      vc = units::as_units("cm^3")
    ),
    predict_fn = function(dsob, hst, rwd, vc) {
      alpha * dsob^beta * hst^beta_1 * rwd^beta_2 * vc^beta_3
    }
  ),
  "23" = list(
    parameter_names = c("alpha", "beta"),
    covariate_units = list(
      dsob = units::as_units("cm"),
      hst = units::as_units("m"),
      rwd = units::as_units("kg / m^3"),
      vc = units::as_units("cm^3")
    ),
    predict_fn = function(dsob, hst, rwd, vc) {
      alpha * (dsob^2 * hst * rwd * vc)^beta
    }
  )
)

for(i in seq_along(model_group)) {
  eq_id <- names(model_group)[[i]]
  config <- model_group[[eq_id]]

  parameters <- all_params[all_params$equation_no == as.numeric(eq_id), config$parameter_names]

  mod <- FixedEffectsModel(
    response_unit = list(
      bt = units::as_units("kg")
    ),
    covariate_units = config$covariate_units,
    parameters = parameters,
    predict_fn = config$predict_fn,
    descriptors = list(
      equation_no = eq_id
    )
  )

  huynh_2022 <- huynh_2022 %>% add_model(mod)
}