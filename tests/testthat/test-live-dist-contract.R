# Contract test against the live published v4 model distribution.
#
# The schema of the dist/*.parquet files published by the allometric/models
# repository is a cross-repo contract with this loader (they are written by
# the orc tooling). The vendored corpus under inst/models-main/dist can drift
# from the published distribution, which is what load_models() reads after a
# fresh install_models(redownload = TRUE). This test downloads the live dist
# and runs the loader against it, so a schema change or corpus regression
# surfaces in CI instead of in user sessions.
#
# Disabled unless ALLOMETRIC_LIVE_DIST=1 so normal check runs (offline, CRAN)
# never hit the network; the dist-contract workflow sets it.

test_that("loader handles the current live v4 dist", {
  skip_on_cran()
  skip_if_not(
    nzchar(Sys.getenv("ALLOMETRIC_LIVE_DIST")),
    "live-dist contract check not enabled (set ALLOMETRIC_LIVE_DIST=1)"
  )

  dist_path <- tempfile("allometric_live_dist_")
  on.exit(unlink(dist_path, recursive = TRUE), add = TRUE)

  tryCatch(
    allometric:::download_dist_files(dist_path),
    error = function(e) skip(paste("download failed:", conditionMessage(e)))
  )

  tables <- allometric:::read_dist_tables(dist_path)

  # Schema contract: the loader joins model_specs.set_id -> models.id and
  # models.pub_id -> publications.pub_id, and each spec carries its own id.
  expect_setequal(
    names(tables$model_specs),
    c("id", "set_id", "spec_index", "parameters", "taxa", "region",
      "component", "descriptors")
  )
  expect_setequal(
    names(tables$models),
    c("id", "pub_id", "model_name", "model_type", "response", "covariates",
      "prediction_function", "covt_defs", "response_definition",
      "description", "notes", "taxa", "region", "component", "descriptors",
      "source_file")
  )
  expect_true("pub_id" %in% names(tables$publications))

  # Join integrity
  expect_true(all(tables$model_specs$set_id %in% tables$models$id))
  expect_true(all(tables$models$pub_id %in% tables$publications$pub_id))
  expect_true(all(!duplicated(tables$model_specs$id)))

  # Full reconstruction through the same path as load_models()
  joined <- allometric:::join_model_tables(tables)
  models <- allometric:::build_model_tbl(joined)
  expect_s3_class(models, "model_tbl")
  expect_gt(nrow(models), 0)

  # Semantic canary: a known model must still predict its historical value.
  barnes <- dplyr::filter(models, pub_id == "barnes_1962")
  expect_equal(nrow(barnes), 1)
  pred <- predict(barnes$model[[1]], atb = 20, hst = 50)
  expect_equal(as.numeric(pred), 41.78136, tolerance = 1e-5)
  expect_equal(units::deparse_unit(pred), "ft")
})
