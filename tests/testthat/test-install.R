test_that("Models install from allometric/models repository", {
  skip_on_cran()
  delete_models(verbose = FALSE)
  install_models(verbose = FALSE)

  models_dir_check <- system.file("models-refactor_variable_args", package = "allometric")

  expect_false(models_dir_check == "")

  parameters_dir_check <- system.file(
    "models-refactor_variable_args/parameters", package = "allometric"
  )

  publications_dir_check <- system.file(
    "models-refactor_variable_args/publications", package = "allometric"
  )

  expect_false(parameters_dir_check   == "")
  expect_false(publications_dir_check == "")
})