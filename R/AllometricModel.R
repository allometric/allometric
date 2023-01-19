setOldClass("units")
setOldClass("BibEntry")

# FIXME not working...too tired to finish
check_allometric_model_validity <- function(object) {
  errors <- c()
  errors <- c(errors, check_descriptor_validity(object@descriptors))
  if (length(errors) == 0) TRUE else errors
}

.AllometricModel <- setClass("AllometricModel",
  slots = c(
    response_unit = "list",
    covariate_units = "list",
    predict_fn = "function",
    descriptors = "tbl_df",
    set_descriptors = "tbl_df",
    pub_descriptors = "tbl_df",
    citation = "BibEntry",
    covariate_definitions = "list"
  ),
  validity = check_allometric_model_validity
)

#' Base class for allometric models
#'
#' This class is primarily used as a parent class for other model
#' implementations.
#'
#' @param response_unit
#'    A named list containing one element, with a name representing the response
#'    variable and a value representing the units of the response variable
#'    using the `units::as_units` function.
#' @param covariate_units
#'    A named list containing the covariate specifications, with names
#'    representing the covariate name and the values representing the units of
#'    the coavariate using the `units::as_units` function.
#' @param descriptors
#'    An optional list of descriptors that are specified at the model-level.
#' @param covariate_definitions
#'    A named list of covariate definitions that
#'    are used instead of the descriptions given by the variable naming system.
#' @export
#' @keywords internal
AllometricModel <- function(response_unit, covariate_units, predict_fn,
                            descriptors = list(),
                            covariate_definitions = list()) {
  # Coerce to tibble
  descriptors <- tibble::as_tibble(descriptors)

  allometric_model <- .AllometricModel(
    response_unit = response_unit,
    covariate_units = covariate_units,
    predict_fn = predict_fn,
    descriptors = descriptors,
    set_descriptors = tibble::tibble(),
    pub_descriptors = tibble::tibble(),
    citation = RefManageR::BibEntry(bibtype = "misc", title = "", author = "", year = 0),
    covariate_definitions = covariate_definitions
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
