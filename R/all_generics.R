#' @importFrom methods new
#' @importFrom rlang .data

setGeneric(
  "get_measure_label",
  function(x) standardGeneric("get_measure_label")
)

setGeneric(
  "get_component_label",
  function(x) standardGeneric("get_component_label")
)

setGeneric("Cite", function(x) {
  standardGeneric("Cite")
})


setGeneric(
  "init_set_of_one",
  function(model) standardGeneric("init_set_of_one")
)

setGeneric("n_models", function(publication) standardGeneric("n_models"))

setGeneric("n_sets", function(publication) standardGeneric("n_sets"))

setGeneric("summary", function(publication) standardGeneric("summary"))

#' Predict with an allometric model
#'
#' @param model The allometric model used for prediction
#' @param ... Additional arguments passed to the `predict_fn` of the input model
#' @param output_units Optionally specify the output units of the model as a
#' string, e.g., "ft^3"
#' @return A vector of allometric model predictions
#' @rdname predict
#' @export
setGeneric("predict", function(model, ...) standardGeneric("predict"),
  signature = "model"
)

setGeneric(
  "rd_model_equation", function(set) standardGeneric("rd_model_equation")
)

setGeneric(
  "rd_variable_defs", function(set) standardGeneric("rd_variable_defs")
)

setGeneric(
  "rd_parameter_table", function(set) standardGeneric("rd_parameter_table")
)

setGeneric(
  "specification", function(model) standardGeneric("specification")
)

setGeneric(
  "specification<-", function(model, value) standardGeneric("specification<-")
)

#' Get the descriptors of a model
#'
#' The model descriptors describe the context of an allometric model as it is
#' situated within a publication, and contain information like family, genus,
#' species, geographic region, etc. This function returns this information for
#' a given model.
#'
#' @param model The allometric model object
#' @return A tibble:tbl_df of descriptors
#' @keywords internal
setGeneric("descriptors", function(model) standardGeneric("descriptors"))

#' Set the descriptors of a model.
#'
#' @param value A tibble::tbl_df of descriptors
#' @keywords internal
setGeneric(
  "descriptors<-", function(model, value) standardGeneric("descriptors<-")
)

setGeneric("parameters", function(model) standardGeneric("parameters"))

setGeneric("get_model_str", function(model) standardGeneric("get_model_str"))

setGeneric(
  "get_variable_descriptions",
  function(model) standardGeneric("get_variable_descriptions")
)

#' Add a set of models to a publication
#'
#' This function adds objects of class `FixedEffectsSet` or `MixedEffectsSet` to
#' a publication. This operation is not done in-place.
#'
#' @param publication The publication for which a set will be added
#' @param model_set The set of models to add to the publication
#' @return A publication with the added set
#' @rdname add_set
#' @export
setGeneric(
  "add_set",
  function(publication, model_set) standardGeneric("add_set")
)

#' Add a model to a publication
#'
#' This function adds objects of class `FixedEffectsModel` or
#' `MixedEffectsModel` to a publication. Models added in this way are added as
#' a set containing only one model. This operation is not done in-place.
#'
#' @param publication The publication for which a set will be added
#' @param model The model to add to the publication
#' @return A publication with the added model
#' @rdname add_model
#' @export
setGeneric(
  "add_model",
  function(publication, model) standardGeneric("add_model")
)

#' Get the function call for a model
#'
#' The function call is the allometric model expressed as a function of its
#' covariates. This function allows the user to see the function call.
#'
#' @param model The allometric model for which a function call will be
#' retrieved
#' @return A string of the function call
#' @export
setGeneric(
  "model_call",
  function(model) standardGeneric("model_call")
)
