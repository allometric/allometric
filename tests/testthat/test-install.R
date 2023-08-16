test_that("Models install from allometric/models repository", {
  delete_models()
  install_models()

  models_dir_check <- system.file("models", package = "allometric")

  expect_false(models_dir_check == "")

  parameters_dir_check <- system.file(
    "models/parameters", package = "allometric"
  )

  publications_dir_check <- system.file(
    "models/publications", package = "allometric"
  )

  expect_false(parameters_dir_check   == "")
  expect_false(publications_dir_check == "")
})