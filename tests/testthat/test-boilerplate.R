test_that("generate_pub_obj generates a publication object", {
  pub_obj <- generate_pub_obj("test_2001", "techreport")
  expect_true(is.character(pub_obj))
})


test_that("generate_fixef_model generates fixed effects model text", {
  fixef <- generate_fixef_model()
  expect_true(is.character(fixef))
})