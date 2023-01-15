setGeneric(
  "get_measure_label",
  function(x) standardGeneric("get_measure_label")
)

setGeneric(
  "get_component_label",
  function(x) standardGeneric("get_component_label")
)

setGeneric("Cite", function(x){standardGeneric("Cite")})



setGeneric(
  "init_set_of_one",
  function(mod) standardGeneric("init_set_of_one")
)

setGeneric("n_models", function(publication) standardGeneric("n_models"))

setGeneric("n_sets", function(publication) standardGeneric("n_sets"))

setGeneric("summary", function(publication) standardGeneric("summary"))

#' Predict with an allometric model
#'
#' @param mod The allometric model used for prediction
#' @param ... Additional arguments passed to the `predict_fn` of the input model
#' @rdname predict
#' @export
setGeneric("predict", function(mod, ...) standardGeneric("predict"),
  signature = "mod")

setGeneric("rd_model_equation", function(set) standardGeneric("rd_model_equation"))
setGeneric("rd_variable_defs", function(set) standardGeneric("rd_variable_defs"))
setGeneric("rd_parameter_table", function(set) standardGeneric("rd_parameter_table"))


setGeneric("specification", function(mod) standardGeneric("specification"))
setGeneric("specification<-", function(mod, value) standardGeneric("specification<-"))

#' @export
setGeneric("descriptors", function(mod) standardGeneric("descriptors"))

setGeneric("parameters", function(mod) standardGeneric("parameters"))

setGeneric("get_model_str", function(mod) standardGeneric("get_model_str"))

setGeneric("get_variable_descriptions", function(mod) standardGeneric("get_variable_descriptions"))


#' Add a set of models to a publication
#'
#' This function adds objects of class `FixedEffectsSet` or `MixedEffectsSet` to
#' a publication.
#'
#' @param publication The publication for which a set will be added.
#' @param model_set The set of models to add to the publication
#'
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
#' a set containing only one model.
#'
#' @param publication The publication for which a set will be added.
#' @param model The model to add to the publication
#'
#' @rdname add_model
#' @export
setGeneric(
  "add_model",
  function(publication, model) standardGeneric("add_model")
)

#' Get the function call for a model
#'
#' This function allows a user to see the structure of the function call for 
#' a given model in an easy-to-read format.
#'
#' @param model The allometric model for which a function call will be
#' retrieved.
#'
#' @export
setGeneric(
  "model_call",
  function(model) standardGeneric("model_call")
)