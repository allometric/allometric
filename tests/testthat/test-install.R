test_that("Models install from allometric/models repository", {
  skip_on_cran()
  delete_models(verbose = FALSE)
  install_models(verbose = FALSE)

  models_dir_check <- system.file("models-main", package = "allometric")

  expect_false(models_dir_check == "")

  models_rds_check <- system.file(
    "models-main/models.RDS", package = "allometric"
  )

  expect_false(models_rds_check == "")
})