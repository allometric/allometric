taxon_pp <- Taxon(
  family = "Pinaceae",
  genus = "Pinus",
  species = "ponderosa"
)

taxon_wwp <- Taxon(
  family = "Pinaceae",
  genus = "Pinus",
  species = "monticola"
)

taxon_fam <- Taxon(family = "Pinaceae")

taxa_1 <- Taxa(taxon_pp, taxon_wwp)

test_that("Taxon %in% Taxa works", {
  expect_true(taxon_pp %in% taxa_1)
  expect_true(taxon_wwp %in% taxa_1)

  expect_false(taxon_fam %in% taxa_1)
})

test_that("Taxa %in% Taxon works", {
  expect_equal(taxa_1 %in% taxon_pp, c(TRUE, FALSE))
  expect_equal(taxa_1 %in% taxon_wwp, c(FALSE, TRUE))
  expect_equal(taxa_1 %in% taxon_fam, c(FALSE, FALSE))
})

test_that("Taxon == Taxon works", {
  expect_equal(taxon_pp, taxon_pp)
  expect_equal(taxon_fam, taxon_fam)
  expect_false(taxon_pp == taxon_fam)
})

test_that("character %in% Taxon works", {
  expect_true("Pinus" %in% taxon_pp)
  expect_true("ponderosa" %in% taxon_pp)
  expect_false("asdf" %in% taxon_pp)
})

test_that("Taxon %in% character works", {
  expect_equal(taxon_pp %in% "Pinus", c(FALSE, TRUE, FALSE))
  expect_equal(taxon_pp %in% "ponderosa", c(FALSE, FALSE, TRUE))
  expect_equal(taxon_pp %in% "asf", c(FALSE, FALSE, FALSE))
})

test_that("character %in% Taxa works", {
  expect_true("Pinus" %in% taxa_1)
  expect_true("ponderosa" %in% taxa_1)
  expect_false("asdf" %in% taxa_1)
})

test_that("Taxa %in% character works", {
  expect_equal(taxa_1 %in% "Pinus", c(TRUE, TRUE))
  expect_equal(taxa_1 %in% "ponderosa", c(TRUE, FALSE))
  expect_equal(taxa_1 %in% "asf", c(FALSE, FALSE))
})

test_that("aggregate_taxa creates correct Taxa and Taxon grouping", {
  test_table_1 <- tibble::tibble(
    family = "Pinaceae",
    genus = "Pinus",
    species = "ponderosa"
  )

  test_table_2 <- tibble::tibble(
    family = "Pinaceae",
    genus = "Pinus",
    species = "monticola"
  )

  test_table_together <- rbind(test_table_1, test_table_2)

  agg_table_1 <- test_table_1 %>% aggregate_taxa()
  agg_table_12 <- test_table_together %>% aggregate_taxa()

  expect_equal(nrow(agg_table_1), 1)
  
  expect_s4_class(agg_table_1$taxa[[1]], "Taxa")
  expect_s4_class(agg_table_1$taxa[[1]][[1]], "Taxon")

  expect_equal(nrow(agg_table_12), 2)
  expect_equal(length(agg_table_12$taxa[[1]]), 1)
  expect_s4_class(agg_table_12$taxa[[1]], "Taxa")
  
  expect_s4_class(agg_table_12$taxa[[1]][[1]], "Taxon")
})

test_that("Non-unique Taxon objects throw error", {
  expect_error({
    Taxa(Taxon(family = "a"), Taxon(family = "a"))
  })
})