

test_that("get_density_def returns correct defintion", {
  e_def <- get_density_def('es')
  expect_equal(e_def$description, 'stem density')
})