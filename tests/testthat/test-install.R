test_that("Models install from allometric/models repository", {
  skip_on_cran()
  delete_models()
  install_models()

  models_dir_check <- system.file("models-main", package = "allometric")

  expect_false(models_dir_check == "")

  parameters_dir_check <- system.file(
    "models-main/parameters", package = "allometric"
  )

  publications_dir_check <- system.file(
    "models-main/publications", package = "allometric"
  )

  expect_false(parameters_dir_check   == "")
  expect_false(publications_dir_check == "")
})