temesgen_2008_citation <- RefManageR::BibEntry(
  bibtype = "article",
  key = "temesgen_2008",
  title = "Analysis and comparison of nonlinear tree height prediction
        strategies for Douglas-fir forests",
  author = "Temesgen, Hailemariam and Monleon, Vicente J. and Hann, David W.",
  journal = "Canadian Journal of Forest Research",
  year = 2008,
  volume = 38,
  number = 3,
  pages = "553-565",
  year = 2008
)

temesgen_2008 <- Publication(
  citation = temesgen_2008_citation,
  descriptors = list(
    country = "US",
    region = "US-OR",
    family = "Pinaceae",
    genus = "Pseudotsuga",
    species = "menziesii"
  )
)

temesgen_2008 <- add_model(temesgen_2008, FixedEffectsModel(
  response_unit = list(
    hst = units::as_units("m")
  ),
  covariate_units = list(
    dsob = units::as_units("cm")
  ),
  parameters = list(
    b_0 = 51.9954,
    b_1 = -0.0208,
    b_2 = 1.0182
  ),
  predict_fn = function(dsob) {
    1.37 + b_0 * (1 - exp(b_1 * dsob)^b_2)
  }
))

temesgen_2008 <- add_model(temesgen_2008, MixedEffectsModel(
  response_unit = list(
    hst = units::as_units("m")
  ),
  covariate_units = list(
    dsob = units::as_units("cm")
  ),
  parameters = list(
    beta_0 = 40.4218,
    beta_1 = -0.0276,
    beta_2 = 0.936,
    sigma_sq_b = 6.544,
    sigma_sq_epsilon = 2.693
  ),
  predict_ranef = function(hst, dsob) {
    z <- hst - beta_0 * (1 - exp(beta_1 * dsob)^beta_2)
    Id <- diag(length(hst))
    b_i <- sigma_sq_b * t(z) %*% solve(sigma_sq_epsilon * Id * z %*% t(z)) %*%
      (hst - beta_0 * (1 - exp(beta_1 * dsob))^beta_2)
    list(b_i = as.numeric(b_i))
  },
  predict_fn = function(dsob) {
    1.37 + (beta_0 + b_i) * (1 - exp(beta_1 * dsob)^beta_2)
  }
))

temesgen_2008 <- add_model(temesgen_2008, MixedEffectsModel(
  response_unit = list(
    hst = units::as_units("m")
  ),
  covariate_units = list(
    dsob = units::as_units("cm")
  ),
  parameters = list(
    beta_0 = 41.8199,
    beta_1 = -0.0241,
    beta_2 = 0.8604
  ),
  predict_ranef = function() {
    list(b_0_i = 0, b_2_i = 0)
  },
  predict_fn = function(dsob) {
    1.37 + (beta_0 + b_0_i) * (1 - exp(beta_1 * dsob)^(beta_2 + b_2_i))
  },
  fixed_only = T
))

temesgen_2008 <- add_model(temesgen_2008, FixedEffectsModel(
  response_unit = list(
    hst = units::as_units("m")
  ),
  covariate_units = list(
    ccfl = units::as_units("m2 / ha"),
    gs_s = units::as_units("m2 / ha"),
    dsob = units::as_units("cm")
  ),
  parameters = list(
    beta_00 = 43.7195,
    beta_01 = 0.0644,
    beta_02 = 0.128,
    beta_1 = -0.0194,
    beta_2 = 1.0805
  ),
  predict_fn = function(ccfl, gs_s, dsob) {
    1.37 + (beta_00 + beta_01 * ccfl + beta_02 * gs_s) *
      (1 - exp(beta_1 * dsob)^beta_2)
  },
  covariate_definitions = list(
    ccfl = "crown competition factor of large trees"
  )
))

temesgen_2008 <- add_model(temesgen_2008, MixedEffectsModel(
  response_unit = list(
    hst = units::as_units("m")
  ),
  covariate_units = list(
    ccfl = units::as_units("m2 / ha"),
    gs_s = units::as_units("m2 / ha"),
    dsob = units::as_units("cm")
  ),
  parameters = list(
    beta_00 = 32.4635,
    beta_01 = 0.0363,
    beta_02 = 0.2585,
    beta_1 = -0.021,
    beta_2 = 0.9906
  ),
  predict_ranef = function() {
    list(b_i = 0)
  },
  predict_fn = function(ccfl, gs_s, dsob) {
    1.37 + (beta_00 + beta_01 * ccfl + beta_02 * gs_s + b_i) *
      (1 - exp(beta_1 * dsob)^beta_2)
  },
  fixed_only = T,
  covariate_definitions = list(
    ccfl = "crown competition factor of large trees"
  )
))

temesgen_2008 <- add_model(temesgen_2008, MixedEffectsModel(
  response_unit = list(
    hst = units::as_units("m")
  ),
  covariate_units = list(
    ccfl = units::as_units("m2 / ha"),
    gs_s = units::as_units("m2 / ha"),
    dsob = units::as_units("cm")
  ),
  parameters = list(
    beta_00 = 35.7419,
    beta_01 = 0.0431,
    beta_02 = 0.2447,
    beta_1 = -0.0184,
    beta_2 = 0.961
  ),
  predict_ranef = function() {
    list(b_0_i = 0, b_2_i = 0)
  },
  predict_fn = function(ccfl, gs_s, dsob) {
    1.37 + (beta_00 + beta_01 * ccfl + beta_02 * gs_s + b_0_i) *
      (1 - exp(beta_1 * dsob)^(beta_2 + b_2_i))
  },
  covariate_definitions = list(
    ccfl = "crown competition factor of large trees"
  )
))
