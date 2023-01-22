setOldClass("units")
setOldClass("BibEntry")

check_allometric_model_validity <- function(object) {
  errors <- c()
  errors <- c(errors, check_descriptor_validity(object@descriptors))
  if (length(errors) == 0) TRUE else errors
}

model_types_defined <- read.csv(
  system.file(
  "variable_defs", "model_types_defined.csv",
  package="allometric"
))

.AllometricModel <- setClass("AllometricModel",
  slots = c(
    response_unit = "list",
    covariate_units = "list",
    predict_fn = "function",
    descriptors = "tbl_df",
    set_descriptors = "tbl_df",
    pub_descriptors = "tbl_df",
    citation = "BibEntry",
    covariate_definitions = "list",
    model_type = "character"
  ),
  validity = check_allometric_model_validity
)

# TODO these feel like extra work, since they could just be defined in the csvs
measure_def <- data.frame(
  measure = c("d", "v", "g", "h", "b", "r"),
  measure_label = c(
    "diameter", "volume", "basal area", "height", "biomass",
    "ratio"
  )
)

component_def <- data.frame(
  component = c("s", "b", "f", "c", "n", "p", "t", "k", "r", "u"),
  component_label = c("stem", "branch", "foliage", "crown", "stand", "plot", "tree", "bark", "root", "stump")
)

# This obviously has combinations that will never be used, this should be
# prevented at the administration phase
measure_component_def <- merge(measure_def, component_def)

#' Gets the model type for a response name.
#'
#' From the variable naming system, return the model type. Model types are
#' custom names that are easier to understand than the usual component-measure
#' pairing. For example, site index models would be called "stem height models"
#' hecause the component is the stem and the measure is the height. However,
#' site index models need a special name. Model types are these names. If a
#' model type is not defined, the component-measure pairing is used instead.
#'
#' @param response_name The response_name from the variable naming system.
#' @keywords internal
get_model_type <- function(response_name) {

  # the defined model types are meant to be starting strings only, in some
  # cases they will be exact matches
  matches <- startsWith(response_name, model_types_defined$response_name_start)

  if(all(!matches)) { # no matches
    measure <- substr(response_name, 1, 1)
    component <- substr(response_name, 2, 2)

    measure_label <- measure_def[measure_def$measure == measure, "measure_label"]
    component_label <- component_def[component_def$component == component, "component_label"]
    model_type <- paste(component_label, measure_label)

  } else { # at least one match, return the exact match if more than one row
    matched <- model_types_defined[matches,]
    if(nrow(matched) == 1) {
      model_type <- matched$model_type
    } else {
      model_type <- matched[matched$response_name_start == response_name, 'model_type']
    }
  }

  model_type
}

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

  # Retrieve the model type
  model_type <- get_model_type(names(response_unit)[[1]])

  allometric_model <- .AllometricModel(
    response_unit = response_unit,
    covariate_units = covariate_units,
    predict_fn = predict_fn,
    descriptors = descriptors,
    set_descriptors = tibble::tibble(),
    pub_descriptors = tibble::tibble(),
    citation = RefManageR::BibEntry(bibtype = "misc", title = "", author = "", year = 0),
    covariate_definitions = covariate_definitions,
    model_type = model_type
  )

  allometric_model
}


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
