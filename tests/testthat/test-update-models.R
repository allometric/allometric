

test_that("update_pub_list produces a pub_list.RDS file that contains all publications", {
  install_models()

  run_pubs <- get_run_pubs(verbose = F)
  update_pub_list(run_pubs)

  pub_list_path <- file.path(
    system.file("extdata", package = "allometric"),
    "pub_list.RDS"
  )

  pubs <- readRDS(pub_list_path)
  pubs_path <- system.file("models/publications", package = "allometric")
  n_files <- length(get_pub_file_spec(pubs_path)$pub_paths)

  expect_equal(n_files, length(pubs))
  expect_true(file.exists(pub_list_path))
})

pub_list_path <- file.path(
  system.file("extdata", package = "allometric"),
  "pub_list.RDS"
)

pubs <- get_pub_list(pub_list_path)

test_that("get_pub_list returns a list of publications", {
  expect_equal(class(pubs), "list")

  pub_classes <- c()

  for (pub in pubs) {
    pub_classes <- c(pub_classes, class(pub))
  }

  expect_true(all(pub_classes == "Publication"))
})

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

model_results <- get_model_results()
model_ids <- read.csv(system.file("model_ids.csv", package = "allometric"))

test_that("get_model_results returns a list of length equal to model_ids", {

  model_ids <- read.csv(system.file("model_ids.csv", package = "allometric"))
  expect_equal(nrow(model_ids), length(model_results))
})

test_that("aggregate_results returns tbl_df of length equal to model_ids", {
  out <- aggregate_results(model_results)

  expect_s3_class(out, "tbl_df")
  expect_equal(nrow(out), nrow(model_ids))
})

test_that("bad id does not exist", {
  check <- id_exists(model_ids, "bad id")
  expect_false(check)
})

test_that("uuid8 returns an 8 character string", {
  test_str <- uuid8()

  expect_equal(nchar(test_str), 8)
})

test_that("append_id returns a tibble with the appended id", {
  model_ids <- tibble::tibble(proxy_id = "asdfasdf", id = "this_id")
  model_ids_appended <- append_id(model_ids, "new_proxy", "new_id")

  expect_equal(nrow(model_ids_appended), 2)
  expect_equal(model_ids_appended$id[[2]], "new_id")
})