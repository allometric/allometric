setGeneric(
  "get_measure_label",
  function(x) standardGeneric("get_measure_label")
)

setGeneric(
  "get_component_label",
  function(x) standardGeneric("get_component_label")
)

setGeneric("Cite", function(x){standardGeneric("Cite")})


#' @export
setGeneric(
  "add_model",
  function(publication, model) standardGeneric("add_model")
)

setGeneric(
  "init_set_of_one",
  function(mod) standardGeneric("init_set_of_one")
)

setGeneric("n_models", function(publication) standardGeneric("n_models"))

setGeneric("n_sets", function(publication) standardGeneric("n_sets"))

setGeneric("summary", function(publication) standardGeneric("summary"))

#' @export
setGeneric("predict", function(mod, ...) standardGeneric("predict"),
  signature = "mod")

setGeneric("rd_model_equation", function(mod) standardGeneric("rd_model_equation"))

setGeneric("rd_variable_defs", function(mod) standardGeneric("rd_variable_defs"))

setGeneric("rd_parameter_table", function(mod) standardGeneric("rd_parameter_table"))


setGeneric("specification", function(mod) standardGeneric("specification"))
setGeneric("specification<-", function(mod, value) standardGeneric("specification<-"))

setGeneric("descriptors", function(mod) standardGeneric("descriptors"))

setGeneric("parameters", function(mod) standardGeneric("parameters"))

setGeneric("get_model_str", function(mod) standardGeneric("get_model_str"))

setGeneric("get_variable_descriptions", function(mod) standardGeneric("get_variable_descriptions"))