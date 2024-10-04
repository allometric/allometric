test_that("get_model returns a useable model", {
  mod <- get_model("3d9a37b1")

  expect_s4_class(mod, "FixedEffectsModel")

  pred <- predict(mod, 30, 20, 40)
  pred_rnd <- round(pred, 1)

  answer <- 18.7
  units(answer) <- "cm"

  expect_equal(pred_rnd, answer)
})

test_that("query_models returns a useable model_tbl", {
  pub_id <- "kozak_1988"
  models <- query_models(pub_id = pub_id)

  expect_equal(class(models)[[1]], "model_tbl")
})
