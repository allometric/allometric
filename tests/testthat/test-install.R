test_that("v4 dist files download from the models repository", {
  skip_on_cran()

  dist_path <- tempfile("allometric_dist_")
  on.exit(unlink(dist_path, recursive = TRUE), add = TRUE)

  tryCatch(
    download_dist_files(dist_path),
    error = function(e) skip(paste("download failed:", conditionMessage(e)))
  )

  expect_true(
    all(file.exists(
      file.path(
        dist_path,
        c("models.parquet", "model_specs.parquet", "publications.parquet")
      )
    ))
  )
})

test_that("check_models_installed is true with the vendored dist", {
  expect_true(check_models_installed())
})
