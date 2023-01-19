turner_2000 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "article",
    key = "turner_2000",
    title = "Assessing alternative allometric algorithms for estimating leaf area of Douglas-fir trees and stands",
    author = "Turner, David P and Acker, Steven A and Means, Joseph E and Garman, Steven L",
    journal = "Forest Ecology and Management",
    volume = 126,
    number = 1,
    pages = "61--76",
    year = 2000,
    publisher = "Elsevier"
  ),
  descriptors = list(
    country = "US",
    region = "US-OR"
  )
)

bf <- FixedEffectsSet(
  response_unit = list(
    bf = units::as_units("kg")
  ),
  covariate_units = list(
    dsob = units::as_units("cm")
  ),
  parameter_names = c("a", "b"),
  predict_fn = function(dsob) {
    exp(a + (b * log(dsob)))
  },
  model_specifications = tibble::tibble(
    family = c("Pinaceae", "Pinaceae", "Cupressaceae"),
    genus = c("Pseudotsuga", "Tsuga", "Thuja"),
    species = c("menziesii", "heterophylla", "plicata"),
    a = c(-2.846, -4.130, -2.617),
    b = c(1.701, 2.128, 1.782)
  )
)

turner_2000 <- add_set(turner_2000, bf)
