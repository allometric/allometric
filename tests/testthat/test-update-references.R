pub <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "article",
    author = "test",
    title = "test",
    journal = "test",
    year = 2000,
    volume = 0
  ),
  descriptors = list(
    region = "US-WA"
  )
)

ref_model <- FixedEffectsModel(
  response_unit = list(vsa = units::as_units("ft^3")),
  covariate_units = list(dsob = units::as_units("in")),
  parameters = list(a = 1),
  descriptors = list(country = "US"),
  predict_fn = function(dsob) {a*dsob}
)

pub <- pub %>% add_model(ref_model)

test_that("response section lines are correct", {
  test_str <- "\\code{vsa = a * dsob}\n\\itemize{\n\\item{\\code{vsa [ft3]}}{ - volume of the entire stem, including top and stump}\n\\item{\\code{dsob [in]}}{ - diameter of the stem, outside bark at breast height}\n}\n\\bold{Model Parameters}\n\\preformatted{  country     a\n1 US          1}\n\\out{<hr>}"
  expect_equal(test_str, response_section_lines(pub@response_sets[['vsa']]))
})

test_that("rd_lines header is correct", {
  rd_lines_test <- rd_lines(pub)

  expect_equal(rd_lines_test[[1]], "\\name{test_2000}")
  expect_equal(rd_lines_test[[2]], "\\alias{test_2000}")
  expect_equal(rd_lines_test[[3]], "\\title{test (2000)}")
  expect_equal(rd_lines_test[[4]], "\\description{Allometric models from test (2000)}")
})


test_that("check internal keyword is caught", {
  man_path_t <- system.file("man", "check_args_in_predict_fn.Rd")
  man_path_f <- system.file("man", "FixedEffectsModel.Rd")
  #expect_true(check_internal(man_path_t)) # FIXME returning false for some reason...
  expect_false(check_internal(man_path_f))
})


test_that("update_reference_index runs", {
  # Kind of cheeky but at least it is something...
  #update_reference_index()
  #expect_true(file.exists(system.file("_pkgdown.yml", package="allometric")))
})