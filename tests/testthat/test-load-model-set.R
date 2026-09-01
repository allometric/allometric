# Tests for load_model() and load_set(), the by-publication loaders that back
# the site's "Load Model" / "Load Set" example code (models repo YAML `name`
# fields are the dist `model_name` values).

test_that("load_model returns a single model that predicts", {
  model <- load_model("barnes_1962", "hstix50")

  expect_s4_class(model, "FixedEffectsModel")
  pred <- predict(model, atb = 20, hst = 50)
  expect_equal(as.numeric(pred), 41.78136, tolerance = 1e-5)
  expect_equal(units::deparse_unit(pred), "ft")
})

test_that("load_model errors on a model set and points to load_set", {
  expect_error(
    load_model("barrett_2006", "hst"),
    "is a model set with 38 specifications; use load_set\\(\\)"
  )
})

test_that("load_model errors with available names when name is unknown", {
  expect_error(
    load_model("barrett_2006", "bogus"),
    "no model named 'bogus' for publication 'barrett_2006'; available model names: hst"
  )
})

test_that("load_model errors on an unknown publication", {
  expect_error(load_model("no_such_pub", "hst"), "no models found for publication 'no_such_pub'")
})

test_that("load_model rejects non-scalar arguments", {
  expect_error(load_model(c("a", "b"), "hst"), "single character strings")
  expect_error(load_model("barrett_2006", 1), "single character strings")
})

test_that("load_set returns a model_tbl with one row per specification", {
  set <- load_set("barrett_2006", "hst")

  expect_s3_class(set, "model_tbl")
  expect_equal(nrow(set), 38)
  expect_equal(set$spec_index, 0:37)
  expect_true(all(vapply(set$model, is, logical(1), "FixedEffectsModel")))

  # Every specification is a distinct species with distinct parameters, and
  # the set shares one functional form: predicting over the rows works.
  pred <- predict(set, dsob = 10)
  expect_s3_class(pred, "units")
  expect_equal(length(pred), 38)
  expect_true(all(is.finite(as.numeric(pred))))
  expect_equal(units::deparse_unit(pred), "m")
})

test_that("load_set returns a one-row model_tbl for a single model", {
  set <- load_set("barnes_1962", "hstix50")
  expect_s3_class(set, "model_tbl")
  expect_equal(nrow(set), 1)
  expect_equal(set$model[[1]], load_model("barnes_1962", "hstix50"))
})

test_that("load_set errors on unknown names and publications", {
  expect_error(load_set("barrett_2006", "bogus"), "no model named 'bogus'")
  expect_error(load_set("no_such_pub", "hst"), "no models found for publication 'no_such_pub'")
})
