setOldClass("units")
setOldClass("BibEntry")

.AllometricModel <- setClass("AllometricModel",
  slots = c(
    response_unit = "list",
    covariate_units = "list",
    predict_fn = "function",
    descriptors = "list",
    set_descriptors = "list",
    pub_descriptors = "list",
    citation = "BibEntry"
  )
)

#' Base class for allometric models
#'
#' This class is primarily used as a parent class for other model
#' implementations.
#'
#' @param response_unit - A list containing one element with the name of the
#' respone variable as the key and the units of the response variable as class
#' `units::units`
#' @param covariate_units - A list containing all covariates used in the model
#' with the name of the covariate as the key and the units of the covariate as
#' class `units::units`
#' @param predict_fn - A function that takes all covariates named in
#' `covariate_units` as arguments.
#' @export
AllometricModel <- function(response_unit, covariate_units, predict_fn,
                            descriptors = list()) {

  allometric_model <- .AllometricModel(
    response_unit = response_unit,
    covariate_units = covariate_units,
    predict_fn = predict_fn,
    descriptors = descriptors,
    citation = RefManageR::BibEntry(bibtype="misc", title="", author="", year=0)
  )

  allometric_model
}

measure_def <- data.frame(
  measure = c("d", "v", "g", "h", "b", "r"),
  measure_label = c(
    "diameter", "volume", "basal area", "height", "biomass",
    "ratio"
  )
)

component_def <- data.frame(
  component = c("s", "b", "f", "c", "n", "p"),
  component_label = c("stem", "branch", "foliage", "crown", "stand", "plot")
)

# This obviously has combinations that will never be used, this should be
# prevented at the administration phase
measure_component_def <- merge(measure_def, component_def)

setMethod(
  "get_measure_label",
  signature(x = "AllometricModel"),
  function(x) {
    response_name <- names(x@response_unit)[[1]]
    measure <- substr(response_name, 1, 1)
    measure_def[measure_def$measure == measure, "measure_label"]
  }
)

setMethod(
  "get_component_label",
  signature(x = "AllometricModel"),
  function(x) {
    response_name <- names(x@response_unit)[[1]]
    component <- substr(response_name, 2, 2)
    component_def[component_def$component == component, "component_label"]
  }
)


setMethod(
  "Cite",
  signature(x = "AllometricModel"),
  function(x) {
    RefManageR::Cite(x@citation)
  }
)



