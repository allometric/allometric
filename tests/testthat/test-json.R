fixed_effects_model_no_descriptors <- FixedEffectsModel(
  response = list(
    vsia = units::as_units("ft^3")
  ),
  covariates = list(
    dsob = units::as_units("in")
  ),
  parameters = list(
    a = 1
  ),
  predict_fn = function(dsob) {
    intermediate <- dsob + 1
    a * dsob^2
  },
  covariate_definitions = list(
    dsob = "diameter but different!"
  ),
  response_definition = "volume but different!"
)


fixed_effects_model_descriptors <- FixedEffectsModel(
  response = list(
    vsia = units::as_units("ft^3")
  ),
  covariates = list(
    dsob = units::as_units("in")
  ),
  parameters = list(
    a = 1
  ),
  predict_fn = function(dsob) {
    intermediate <- dsob + 1
    a * dsob^2
  },
  descriptors = list(
    species = "pseudotsuga"
  ),
  covariate_definitions = list(
    dsob = "diameter but different!"
  ),
  response_definition = "volume but different!"
)

test_that("FixedEffectsModel converts to JSON from S4", {
  json <- toJSON(fixed_effects_model_descriptors)
  expect_true(is.character(json))

  json <- toJSON(fixed_effects_model_no_descriptors)
  expect_true(is.character(json))
})

test_that("FixedEffectsModel converts to S4 from JSON", {
  json_path <- system.file("testdata", "fixef_no_descriptors.json", package = "allometric")
  json_list <- jsonlite::read_json(json_path)
  json_str <- jsonlite::toJSON(json_list, digits = NA)

  brackett_acer_no_descriptors <- brackett_acer
  brackett_acer_no_descriptors@specification <- brackett_acer@parameters

  model <- fromJSON(json_str)
  expect_true(model == brackett_acer_no_descriptors)
})

test_that("FixedEffectsModel toJSON inverts", {
  # FIXME still not working
  expect_true(brackett_acer == fromJSON(toJSON(brackett_acer)))
})
