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

  expect_s4_class(model_row$model[[1]], "FixedEffectsModel")
})

test_that("aggregate_pub_models runs", {
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

test_that("ingest_models runs correctly with locally specified data", {
  pub_path <- system.file("testdata/test_publications", package = "allometric")
  params_path <- system.file("testdata/test_parameters", package = "allometric")
  
  models_ingested <- ingest_models(
    FALSE, pub_path = pub_path, params_path = params_path
  )

  expect_equal(25, nrow(models_ingested))
})