chittester_1984 <- Publication(
  citation = RefManageR::BibEntry(
    bibtype = "techreport",
    key = "chittester_1984",
    title = "Cubic-foot tree volume equations and tables for western juniper",
    author = "Chittester, Judith M and MacLean, Colin D",
    institution = "US Department of Agriculture, Forest Service, Pacific Northwest Forest and Range Experiment Station (USA)",
    year = 1984
  ),
  descriptors = list(
    country = "US",
    region = c("US-OR", "US-CA"),
    family = "Cupressaceae",
    genus = "Juniperus",
    species = "occidentalis"
  )
)

cvts <- FixedEffectsModel(
  response_unit = list(
    vsia = units::as_units("ft^3")
  ),
  covariate_units = list(
    dsob = units::as_units("in"),
    hst = units::as_units("ft")
  ),
  parameters = list(
    a = 0.307,
    b = 0.00086,
    c = -0.0037
  ),
  predict_fn = function(dsob, hst) {
    f <- a + b * hst + c * dsob * hst / (hst - 4.5)
    ba <- 0.005454154 * dsob^2
    ba * f * hst * (hst / (hst - 4.5))^2
  }
)

cv4 <- FixedEffectsModel(
  response_unit = list(
    vsim = units::as_units("ft^3")
  ),
  covariate_units = list(
    vsoa = units::as_units("ft^3"),
    dsob = units::as_units("in")
  ),
  parameters = list(
    a = 3.48,
    b = 1.18052,
    c = 0.32736,
    d = 2.948
  ),
  predict_fn = function(vsoa, dsob) {
    (vsoa + a) / (b + c * exp(-0.1 * dsob)) - d
  }
)

chittester_1984 <- chittester_1984 %>%
  add_model(cvts) %>%
  add_model(cv4)