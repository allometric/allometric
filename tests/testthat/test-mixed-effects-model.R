mixed_effects_model_one_ranef <- MixedEffectsModel(
  response = list(
    "hst" = units::as_units("m")
  ),
  covariates = list(
    "dsob" = units::as_units("cm")
  ),
  parameters = list(
    beta_0 = 40.4218,
    beta_1 = -0.0276,
    beta_2 = 0.936,
    sigma_sq_b = 6.544,
    sigma_sq_epsilon = 2.693
  ),
  predict_ranef = function(hst, dsob) {
    z <- hst - beta_0 * (1 - exp(beta_1 * dsob)^beta_2)
    Id <- diag(length(hst))
    b_i <- sigma_sq_b * t(z) %*% solve(sigma_sq_epsilon * Id * z %*% t(z)) %*%
      (hst - beta_0 * (1 - exp(beta_1 * dsob))^beta_2)
    list(b_i = as.numeric(b_i))
  },
  predict_fn = function(dsob) {
    1.37 + (beta_0 + b_i) * (1 - exp(beta_1 * dsob)^beta_2)
  }
)

test_that("A mixed effects model with one ranef makes predictions", {
  newdata <- data.frame(hst = c(12, 10, 15), dsob = c(50, 43, 60))
  pred <- predict(mixed_effects_model_one_ranef, 10, newdata = newdata)

  val <- 12.37626
  units(val) <- "m"

  expect_equal(pred, val, tolerance = 0.001)
})

test_that("Mixed effects model_call returns correctly formatted string", {
  expect_equal(model_call(mixed_effects_model_one_ranef), "hst = f(dsob, newdata)")
})

mixed_effects_model_fixed_only <- MixedEffectsModel(
  response = list(
    hst = units::as_units("m")
  ),
  covariates = list(
    dsob = units::as_units("cm")
  ),
  parameters = list(
    beta_0 = 40.4218,
    beta_1 = -0.0276,
    beta_2 = 0.936
  ),
  predict_ranef = function() {
    list(b_0_i = 0, b_2_i = 0)
  },
  predict_fn = function(dsob) {
    1.37 + (beta_0 + b_0_i) * (1 - exp(beta_1 * dsob)^(beta_2 + b_2_i))
  },
  fixed_only = T
)


test_that("A mixed effects model can be flagged as fixed only and predict", {
  pred <- predict(mixed_effects_model_fixed_only, 10)
  val <- 10.5726
  units(val) <- "m"

  expect_equal(pred, val, tolerance = 0.001)
})

test_that("Identical mixed effects models are equal", {
  expect_equal(mixed_effects_model_one_ranef, mixed_effects_model_one_ranef)
})


test_that("Different mixed effects models are not equal", {
  expect_equal(mixed_effects_model_one_ranef == mixed_effects_model_fixed_only, FALSE)
})