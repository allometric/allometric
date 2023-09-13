test_that("get_model_hash returns an md5 string", {
  predict_fn_populated <- function(dsob) {
    1.2 * dsob
  }
  descriptors <- tibble::tibble(country = "US")

  hash <- get_model_hash(predict_fn_populated, descriptors)
  expect_equal(hash, "e826bd8a3a66fc5d77e95e812a8ae6c9")
})

test_that("append_search_descriptors creates a valid tibble row", {
  row <- tibble::tibble(a = c(1))
  descriptors <- tibble::tibble(country = "US")

  suppressWarnings((
    row <- append_search_descriptors(row, descriptors)
  ))

  test_row <- tibble::tibble(a = 1, country = list("US"), region = list(NULL))

  expect_equal(row, test_row)
})