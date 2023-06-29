poudel_2018 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "article",
    key = "poudel_2018",
    title = "Estimating upper stem diameters and volume of Douglas-fir and Western hemlock trees in the Pacific northwest",
    author = "Poudel, Krishna P and Temesgen, Hailemariam and Gray, Andrew N",
    journal = "Forest Ecosystems",
    volume = 5,
    number = 1,
    pages = "1--12",
    year = 2018,
    publisher = "Springer"
  ),
  descriptors = list(
    country = "US",
    region = c("US-OR", "US-WA")
  )
)



m1 <- FixedEffectsSet(
  response_unit = list(
    rsdodi = units::as_units("cm / cm")
  ),
  covariate_units = list(
    hst = units::as_units("m"),
    hsd = units::as_units("m")
  ),
  parameter_names = c("b_1", "b_2", "b_3", "b_4", "b_5"),
  predict_fn = function(hst, hsd) {
    x <- (hst - hsd) / (hst - 1.3)
    b_1 + b_2 * x + b_3 * x^2 + b_4 * x^3 + b_5 * x^4
  },
  model_specifications = tibble::tibble(
    family = c("Pinaceae", "Pinaceae"),
    genus = c("Pseudotsuga", "Tsuga"),
    species = c("menziesii", "heterophylla"),
    b_1 = c(0.02435, 0.03080),
    b_2 = c(0.85814, 0.42992),
    b_3 = c(2.57379, 4.12143),
    b_4 = c(-5.55862, -7.85114),
    b_5 = c(3.05029, 4.27438)
  )
)

m2 <- FixedEffectsSet(
  response_unit = list(
    dsih = units::as_units("cm")
  ),
  covariate_units = list(
    hst = units::as_units("m"),
    hsd = units::as_units("m"),
    dsob = units::as_units("cm")
  ),
  parameter_names = c("b_1", "b_2", "b_3", "b_4", "b_5", "b_6", "b_7", "b_8", "p"),
  predict_fn = function(hst, hsd, dsob) {
    t <- hsd / hst
    k <- 1.3 / hst
    b_1 * dsob^b_2 * b_3^dsob * ((1 - sqrt(t)) / (1 - sqrt(p)))^(b_4 * t^2 + b_5 * log(t + 0.001) + b_6 * sqrt(t) + b_7 * exp(t) + b_8 * (dsob / hst))
  },
  model_specifications = tibble::tibble(
    family = c("Pinaceae", "Pinaceae"),
    genus = c("Pseudotsuga", "Tsuga"),
    species = c("menziesii", "heterophylla"),
    b_1 = c(0.79314, 0.92336),
    b_2 = c(1.02189, 1.00547),
    b_3 = c(0.99754, 0.99796),
    b_4 = c(1.10118, 1.05050),
    b_5 = c(-0.18022, -0.16240),
    b_6 = c(1.19183, -0.24448),
    b_7 = c(-0.61055, -0.31429),
    b_8 = c(0.15539, 0.30181),
    p = c(0.25, 0.12)
  )
)

m3 <- FixedEffectsSet(
  response_unit = list(
    rsdodi = units::as_units("cm / cm")
  ),
  covariate_units = list(
    hst = units::as_units("m"),
    hsd = units::as_units("m"),
    dsob = units::as_units("cm")
  ),
  parameter_names = c("b_1", "b_2", "b_3", "b_4", "b_5", "b_6", "b_7"),
  predict_fn = function(hst, hsd, dsob) {
    t <- hsd / hst
    ((log(sin(t * pi / 2))) / (log(sin((1.37 / hst) * pi / 2))))^(b_1 + b_2 * sin(t * pi / 2) + b_3 * cos(t * (3 * pi / 2)) + b_4 * ((sin((pi / 2) * t)) / (t)) + b_5 * dsob + b_6 * t * sqrt(dsob) + b_7 * t * sqrt(hst))
  },
  model_specifications = tibble::tibble(
    family = c("Pinaceae", "Pinaceae"),
    genus = c("Pseudotsuga", "Tsuga"),
    species = c("menziesii", "heterophylla"),
    b_1 = c(0.14030, 1.84835),
    b_2 = c(0.72960, 0.01014),
    b_3 = c(0.15440, 0.00175),
    b_4 = c(-0.12140, -1.04746),
    b_5 = c(0.00124, 0.0029),
    b_6 = c(0.02678, 0.03483),
    b_7 = c(-0.09579, -0.13071)
  )
)

m4 <- FixedEffectsSet(
  response_unit = list(
    dsih = units::as_units("cm")
  ),
  covariate_units = list(
    hst = units::as_units("m"),
    hsd = units::as_units("m"),
    dsob = units::as_units("cm")
  ),
  parameter_names = c("b_1", "b_2", "b_3", "b_4", "b_5", "b_6", "b_7"),
  predict_fn = function(hst, hsd, dsob) {
    k <- 1.3 / hst
    t <- hsd / hst
    b_1 * dsob^b_2 * hst^b_3 * ((1 - t^(1 / 3)) / (1 - k^(1 / 3)))^(b_4 * t^4 + b_5 * (1 / exp(dsob / hst)) + b_6 * ((1 - t^(1 / 3)) / (1 - k^(1 / 3)))^(0.1) + b_7 * (1 / dsob) + b_8 * (hst^(1 - (hsd / hst)^(1 / 3))) + b_9 * ((1 - t^(1 / 3)) / (1 - k^(1 / 3))))
  },
  model_specifications = tibble::tibble(
    family = c("Pinaceae", "Pinaceae"),
    genus = c("Pseudotsuga", "Tsuga"),
    species = c("menziesii", "heterophylla"),
    b_1 = c(1.04208, 1.05981),
    b_2 = c(0.99771, 0.99433),
    b_3 = c(-0.03111, -0.01684),
    b_4 = c(0.53788, 0.64632),
    b_5 = c(-1.01291, -1.56599),
    b_6 = c(0.56813, 0.74293),
    b_7 = c(4.96019, 4.75618),
    b_8 = c(0.04124, 0.0389),
    b_9 = c(-0.34417, -0.19425)
  )
)

m5 <- FixedEffectsSet(
  response_unit = list(
    dsih = units::as_units("cm")
  ),
  covariate_units = list(
    hst = units::as_units("m"),
    hsd = units::as_units("m"),
    dsob = units::as_units("cm")
  ),
  parameter_names = c("b_1", "b_2", "b_3"),
  predict_fn = function(hst, hsd, dsob) {
    2 * (((b_1 * dsob) / (1 - exp(b_3 * (1.3 - hst)))) + (dsob / 2 - b_1 * dsob) * (1 - (1 / (1 - exp(b_2 * (1.3 - hst))))) + exp(-b_2 * hsd) * ((dsob / 2 - b_1 * dsob) * exp(1.3 * b_2) / (1 - exp(b_2 * (1.3 - hst)))) - exp(b_3 * hsd) * ((b_1 * dsob * exp(-b_3 * hst)) / (1 - exp(b_3 * (1.3 - hst)))))
  },
  model_specifications = tibble::tibble(
    family = c("Pinaceae", "Pinaceae"),
    genus = c("Pseudotsuga", "Tsuga"),
    species = c("menziesii", "heterophylla"),
    b_1 = c(0.30853, 0.04561),
    b_2 = c(0.08620, -0.02362),
    b_3 = c(0.07768, -0.86616)
  )
)

poudel_2018 <- poudel_2018 %>%
  add_set(m1) %>%
  add_set(m2) %>%
  add_set(m3) %>%
  add_set(m4) %>%
  add_set(m5)
