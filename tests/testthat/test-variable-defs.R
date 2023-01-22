test_that("get_variable_def returns correct defintion", {
  my_var <- "hst"

  matches <- get_variable_def("hst")
  expect_true(all(startsWith(matches$search_str, "hst")))

  exact_match <- get_variable_def("hst", return_exact_only = T)
  expect_true(nrow(exact_match) == 1 & exact_match$search_str == "hst")
})

test_that("prepare_var_defs produces correct output", {
  var_defs_post <- prepare_var_defs(var_defs.pre)

  expect_true(is.list(var_defs))
  expect_equal(length(var_defs), 6)
})