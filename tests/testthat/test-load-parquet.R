# Tests for the v4 parquet loader (load_models and the model_tbl it produces).
# The vendored dist/ files under inst/models-main are the corpus under test.

models <- load_models()

test_that("load_models returns a model_tbl with the expected shape", {
  expect_s3_class(models, "model_tbl")
  expect_equal(nrow(models), 2392)

  expect_named(
    models,
    c(
      "id", "spec_index", "model_name", "model_type", "pub_id", "pub_year",
      "family_name", "covt_name", "taxa", "region", "component", "model"
    )
  )

  expect_true(all(vapply(models$model, is, logical(1), "FixedEffectsModel")))
  expect_true(all(nchar(models$id) == 8))
})

test_that("a known model predicts the expected value", {
  barnes <- dplyr::filter(models, pub_id == "barnes_1962")
  expect_equal(nrow(barnes), 1)

  pred <- predict(barnes$model[[1]], atb = 20, hst = 50)
  expect_equal(as.numeric(pred), 41.78136, tolerance = 1e-5)
  expect_equal(units::deparse_unit(pred), "ft")

  expect_equal(model_call(barnes$model[[1]]), "hstix50 = f(atb, hst)")
  expect_equal(barnes$id[[1]], "1de6301a")
})

test_that("select_model works by the v4 content-hash id", {
  barnes_id <- dplyr::filter(models, pub_id == "barnes_1962")$id[[1]]

  mod_ix <- select_model(models, 1)
  mod_id <- select_model(models, barnes_id)

  expect_s4_class(mod_ix, "FixedEffectsModel")
  expect_s4_class(mod_id, "FixedEffectsModel")
  expect_equal(mod_id, mod_ix)
})

test_that("a model set produces one row per specification", {
  hahn_vsia <- dplyr::filter(models, pub_id == "hahn_1991", model_name == "vsia")

  expect_equal(nrow(hahn_vsia), 23)
  expect_equal(length(unique(hahn_vsia$id)), 1)
  expect_equal(hahn_vsia$spec_index, 0:22)
})

test_that("taxa and region are searchable list columns", {
  pinus_models <- dplyr::filter(models, purrr::map_lgl(taxa, ~ "Pinus" %in% .))
  expect_gt(nrow(pinus_models), 0)
  expect_true(all(purrr::map_lgl(pinus_models$taxa, ~ "Pinus" %in% .)))
  expect_true(all(vapply(pinus_models$taxa, function(t) is(t, "Taxa"), logical(1))))

  us_co_models <- dplyr::filter(models, purrr::map_lgl(region, ~ "US-CO" %in% .))
  expect_gt(nrow(us_co_models), 0)
  expect_true(all(purrr::map_lgl(us_co_models$region, ~ "US-CO" %in% .)))
})

test_that("numeric descriptors declared as coefficients are substituted", {
  # kozak_1988 dsih stores the relative-height position `p` as a descriptor;
  # the prediction function requires it, so it must be substituted numerically.
  kozak <- dplyr::filter(models, pub_id == "kozak_1988", model_name == "dsih")

  pred <- predict(kozak$model[[1]], hst = 20, hsd = 5, dsob = 15)
  expect_true(is.finite(as.numeric(pred)))
  expect_equal(units::deparse_unit(pred), "cm")
})

test_that("character descriptor qualifiers are not substituted", {
  # bruce_1974 vsia has the descriptor hst = "<= 18 ft hst", which must not
  # replace the hst covariate in the prediction function.
  bruce <- dplyr::filter(models, pub_id == "bruce_1974", model_name == "vsia")

  pred <- predict(bruce$model[[1]], hst = 20, dsob = 10)
  expect_true(is.finite(as.numeric(pred)))
  expect_equal(units::deparse_unit(pred), "ft3")
})
