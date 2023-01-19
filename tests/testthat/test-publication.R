
pub <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "article",
    author = "test",
    title = "test",
    journal = "test",
    year = 2000,
    volume = 0
  ),
  descriptors = list(
    region = "US-WA"
  )
)

mod_dup_descriptor <- FixedEffectsModel(
  response_unit = list(vsa = units::as_units("ft^3")),
  covariate_units = list(dsob = units::as_units("in")),
  predict_fn <- function(dsob) {
    a * dsob
  },
  descriptors = list(region = "US-WA"),
  parameters = list(a = 1)
)

test_that("Publication add_model errors on duplicated descriptor", {
  expect_error(add_model(pub, mod_dup_descriptor), "Duplicated descriptors:")
})

fixed_effects_model <- FixedEffectsModel(
  response_unit = list(vsa = units::as_units("ft^3")),
  covariate_units = list(dsob = units::as_units("in")),
  predict_fn = function(dsob) {
    a * dsob
  },
  parameters = list(a = 1)
)

test_that("Publication add_model adds model for fixed effects model", {
  pub_add_fixef <- add_model(pub, fixed_effects_model)
  expect_equal(length(pub_add_fixef@response_sets[["vsa"]][[1]]@models), 1)
  expect_equal(n_models(pub_add_fixef), 1)
  expect_equal(n_sets(pub_add_fixef), 1)
})

fixed_effects_set <- FixedEffectsSet(
  response_unit = list(vsa = units::as_units("ft^3")),
  covariate_units = list(dsob = units::as_units("in")),
  predict_fn = function(dsob) {
    a * dsob
  },
  parameter_names = c("a"),
  model_specifications = tibble::tibble(a = c(1, 2))
)

test_that("Publication add_set adds set for fixed effects set", {
  pub_add_fixef <- add_set(pub, fixed_effects_set)
  expect_equal(length(pub_add_fixef@response_sets[["vsa"]][[1]]@models), 2)
  expect_equal(n_models(pub_add_fixef), 2)
  expect_equal(n_sets(pub_add_fixef), 1)
})

mixed_effects_model <- MixedEffectsModel(
  response_unit = list(vsa = units::as_units("ft^3")),
  covariate_units = list(dsob = units::as_units("in")),
  predict_fn = function(dsob) {
    a * dsob + a0i
  },
  predict_ranef = function(dsob) {
    list(a0i = 0)
  },
  parameters = list(a = 1)
)

test_that("Publication add_model adds model for mixed effects model", {
  pub_add_mixef <- add_model(pub, mixed_effects_model)
  expect_equal(length(pub_add_mixef@response_sets[["vsa"]][[1]]@models), 1)
  expect_equal(n_models(pub_add_mixef), 1)
  expect_equal(n_sets(pub_add_mixef), 1)
})
