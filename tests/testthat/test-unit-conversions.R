fem <- FixedEffectsModel(
  response_unit = list(
    vsia = units::as_units("ft^3")
  ),
  covariate_units = list(
    dsob = units::as_units("in"),
    hst = units::as_units("ft")
  ),
  parameters = list(a = 1),
  predict_fn = function(dsob, hst) {
    a * dsob * hst
  }
)


test_that("units convert when different covariate units are specified", {
  vals1 <- c(5, 10)
  vals2 <- c(5, 10)

  units(vals1) <- c("cm")
  units(vals2) <- c("m")

  covariate_units <- list(
    dsob = units::as_units("in"),
    hst  = units::as_units("ft")
  )

  conv_out <- convert_units(vals1, vals2, units_list = covariate_units)

  u11 <- 1.968504
  u12 <- 3.937008
  u21 <- 16.4042
  u22 <- 32.8074

  units(u11) <- "in"
  units(u12) <- "in"
  units(u21) <- "ft"
  units(u22) <- "ft"

  expect_equal(length(conv_out), 2)
  expect_equal(conv_out[[1]][[1]], u11, tolerance = 0.001)
  expect_equal(conv_out[[1]][[2]], u12, tolerance = 0.001)
  expect_equal(conv_out[[2]][[1]], u21, tolerance = 0.001)
  expect_equal(conv_out[[2]][[2]], u22, tolerance = 0.001)
})

test_that("correct prediction is obtained when covt units are converted", {
  vals1 <- c(5, 10)
  vals2 <- c(5, 10)

  units(vals1) <- c("cm")
  units(vals2) <- c("m")

  preds <- predict(fem, vals1, vals2)

  u1 <- 32.29173
  u2 <- 129.16693

  units(u2) <- "ft^3"
  units(u1) <- "ft^3"

  expect_equal(preds[[1]], u1, tolerance = 0.001)
  expect_equal(preds[[2]], u2, tolerance = 0.001)
})

test_that("correct prediction is obtained when response units are converted", {
  vals1 <- c(5, 10)
  vals2 <- c(5, 10)

  units(vals1) <- c("cm")
  units(vals2) <- c("m")

  preds <- predict(fem, vals1, vals2, output_units = "m^3")

  u1 <- 0.9144
  u2 <- 3.6576

  units(u1) <- "m^3"
  units(u2) <- "m^3"

  expect_equal(preds[[1]], u1, tolerance = 0.001)
  expect_equal(preds[[2]], u2, tolerance = 0.001)
})


test_that("predictions are made even if covt units are not specified", {
  vals1 <- c(5, 10)
  vals2 <- c(5, 10)

  u1 <- 0.7079212
  u2 <- 2.8316847

  units(u1) <- "m^3"
  units(u2) <- "m^3"

  preds <- predict(fem, vals1, vals2, output_units = "m^3")

  expect_equal(preds[[1]], u1, tolerance = 0.001)
  expect_equal(preds[[2]], u2, tolerance = 0.001)
})