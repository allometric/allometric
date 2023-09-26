#' @importFrom methods new
#' @importFrom rlang .data

setGeneric(
  "get_measure_name",
  function(x) standardGeneric("get_measure_name")
)

setGeneric(
  "get_component_name",
  function(x) standardGeneric("get_component_name")
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
#' string, e.g., "ft^3". The provided string must be compatible with the
#' `units::set_units()` function.
#' @return A vector of allometric model predictions
#' @rdname predict
#' @export
#' @examples
#' predict(brackett_rubra, 10, 50)
#' predict(brackett_rubra, 10, 50, output_units = "m^3")
setGeneric("predict", function(model, ...) standardGeneric("predict"),
  signature = "model"
)

setGeneric(
  "specification", function(object) standardGeneric("specification")
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
#' @param object The allometric model or model set object
#' @return A tibble:tbl_df of descriptors
#' @keywords internal
setGeneric("descriptors", function(object) standardGeneric("descriptors"))

#' Set the descriptors of a model.
#'
#' @param object The allometric model or model set object
#' @param value A tibble::tbl_df of descriptors
#' @keywords internal
setGeneric(
  "descriptors<-", function(object, value) standardGeneric("descriptors<-")
)

setGeneric("parameters", function(object) standardGeneric("parameters"))

setGeneric("get_model_str", function(object) standardGeneric("get_model_str"))

setGeneric(
  "get_variable_descriptions",
  function(object) standardGeneric("get_variable_descriptions")
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
#' covariates. Accessing the function call is important when determining the
#' order of the covariates given to the prediction function.
#'
#' @param object The allometric model or set for which a function call will be
#' retrieved
#' @return A string of the function call
#' @export
#' @examples
#' model_call(brackett_rubra)
setGeneric(
  "model_call",
  function(object) standardGeneric("model_call")
)

#' Convert a model or publication to a JSON representation
#'
#' This function converts an allometric model or publication into a JSON
#' representation. Primarily, this is used internally to populate a remotely
#' hosted MongoDatabase.
#'
#' @param object An allometric model or publication
#' @return A string containing the JSON representation of the object
#' @export
#' @examples
#' toJSON(brackett_rubra)
setGeneric(
  "toJSON",
  function(object) standardGeneric("toJSON")
)