test_that("get_variable_def returns correct defintion", {
  my_var <- "hst"

  matches <- get_variable_def("hst")
  expect_true(all(startsWith(matches$search_str, "hst")))

  exact_match <- get_variable_def("hst", return_exact_only = TRUE)
  expect_true(nrow(exact_match) == 1 & exact_match$search_str == "hst")
})

test_that("get_variable_def returns correct defintion with suffix", {
  my_var <- "bt_p"
  matches <- get_variable_def(my_var)

  expect_equal(matches$description, "tree biomass (plot-level)")
})

test_that("get_variable_def returns correct defintion with prefix", {
  my_var <- "i_bt"
  matches <- get_variable_def(my_var)

  expect_equal(matches$description, "tree biomass (increment)")
})

test_that("get_variable_def returns correct defintion with prefix and suffix", {
  my_var <- "i_bt_p"
  matches <- get_variable_def(my_var)

  expect_equal(matches$description, "tree biomass (plot-level increment)")
})

test_that("prepare_var_defs produces correct output", {
  load_var_defs()

  expect_true(is.list(var_defs))
  expect_equal(length(var_defs), 8)
})