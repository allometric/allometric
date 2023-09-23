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

test_that("prepare_var_defs returns a list equal to the length of the number of measures", {
  n_measures <- nrow(measure_defs)
  var_defs <- prepare_var_defs(var_defs_pre, measure_defs, component_defs)

  expect_equal(length(var_defs), n_measures)
})

test_that("get_measure_defs returns a non-empty dataframe", {
  measure_defs_ <- get_measure_defs()

  expect_true(is.data.frame(measure_defs_))
  expect_true(nrow(measure_defs) > 0)
})

test_that("matched model type returns correct value", {
  matched_type <- get_model_type("dsoh")

  expect_equal("taper", matched_type)
})