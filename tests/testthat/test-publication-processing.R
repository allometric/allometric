test_that("Model row is correctly made", {
  pub <- Publication(
    citation = RefManageR::BibEntry(
      key = "test_2000",
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


  model_row <- create_model_row(brackett_acer, pub, "test_id")

  expect_is(model_row$model[[1]], "FixedEffectsModel")
})

test_that("aggreagte_pub_models runs", {
  pub <- Publication(
    citation = RefManageR::BibEntry(
      key = "test_2000",
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

  #pub <- add_model(pub, brackett_acer)

  #agg_models <- aggregate_pub_models(pub)
  #expect_is(agg_models$model[[1]], "FixedEffectsModel")
})