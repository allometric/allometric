fixed_effects_model_no_descriptors <- FixedEffectsModel(
  response_unit = list(
    vsia = units::as_units("ft^3")
  ),
  covariate_units = list(
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
  response_unit = list(
    vsia = units::as_units("ft^3")
  ),
  covariate_units = list(
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
  json <- toJSON(fixed_effects_model)
  expect_true(is.character(json))
})

test_that("FixedEffectsModel converts to S4 from JSON", {
  json_path <- system.file("testdata", "test_model.json", package = "allometric")
  json_list <- jsonlite::read_json(json_path)
  json_str <- jsonlite::toJSON(json_list)

  model <- fromJSON(json_str)

  expect_true(model == brackett_acer)
})

