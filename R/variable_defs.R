d_defs <- utils::read.csv(system.file("variable_defs/d.csv", package = "allometric"))
v_defs <- utils::read.csv(system.file("variable_defs/v.csv", package = "allometric"))
h_defs <- utils::read.csv(system.file("variable_defs/h.csv", package = "allometric"))
b_defs <- utils::read.csv(system.file("variable_defs/b.csv", package = "allometric"))
e_defs <- utils::read.csv(system.file("variable_defs/e.csv", package = "allometric"))
r_defs <- utils::read.csv(system.file("variable_defs/r.csv", package = "allometric"))
component_defs <- utils::read.csv(system.file("variable_defs/components.csv", package = "allometric"))
measure_defs <- utils::read.csv(system.file("variable_defs/measures.csv", package = "allometric"))

# TODO a lot of repetition in these functions, is there a safe way to simplify?

get_vol_def <- function(response_name) {
  measure_char <- substr(response_name, 1, 1)
  component_char <- substr(response_name, 2, 2)
  stem_char <- substr(response_name, 3, 3)


  matching_measure <- v_defs[
    v_defs$measure == measure_char &
      v_defs$component == component_char &
      v_defs$stem_modifier == stem_char,
  ]

  add_component <- merge(matching_measure, component_defs)
  add_measure <- merge(add_component, measure_defs)

  add_measure
}

get_biomass_def <- function(response_name) {
  measure_char <- substr(response_name, 1, 1)
  component_char <- substr(response_name, 2, 2)

  matching_measure <- b_defs[
    b_defs$measure == measure_char &
      b_defs$component == component_char,
  ]

  add_component <- merge(matching_measure, component_defs)
  add_measure <- merge(add_component, measure_defs)
  add_measure
}

get_height_def <- function(response_name) {
  measure_char <- substr(response_name, 1, 1)
  component_char <- substr(response_name, 2, 2)
  height_char <- substr(response_name, 3, 3)

  matching_measure <- h_defs[
    h_defs$measure == measure_char &
      h_defs$component == component_char &
      h_defs$height_modifier == height_char,
  ]

  add_component <- merge(matching_measure, component_defs)
  add_measure <- merge(add_component, measure_defs)
  add_measure
}

get_diameter_def <- function(response_name) {
  measure_char <- substr(response_name, 1, 1)
  component_char <- substr(response_name, 2, 2)
  bark_char <- substr(response_name, 3, 3)
  height_char <- substr(response_name, 4, 4)


  matching_measure <- d_defs[
    d_defs$measure == measure_char &
      d_defs$component == component_char &
      d_defs$bark_modifier == bark_char &
      d_defs$height_modifier == height_char,
  ]


  add_component <- merge(matching_measure, component_defs)
  add_measure <- merge(add_component, measure_defs)

  add_measure
}

get_density_def <- function(response_name) {
  measure_char <- substr(response_name, 1, 1)
  component_char <- substr(response_name, 2, 2)

  matching_measure <- e_defs[
    e_defs$measure == measure_char &
      e_defs$component == component_char,
  ]

  add_component <- merge(matching_measure, component_defs)
  add_measure <- merge(add_component, measure_defs)
  add_measure
}

get_ratio_def <- function(response_name) {
  measure_char <- substr(response_name, 1, 1)
  component_char <- substr(response_name, 2, 2)

  matching_measure <- r_defs[
    r_defs$measure == measure_char &
      r_defs$component == component_char,
  ]

  add_component <- merge(matching_measure, component_defs)
  add_measure <- merge(add_component, measure_defs)
  add_measure
}

#' @export
get_variable_def <- function(response_name) {
  measure_char <- substr(response_name, 1, 1)

  if (measure_char == "v") {
    def <- get_vol_def(response_name)
  } else if (measure_char == "b") {
    def <- get_biomass_def(response_name)
  } else if (measure_char == "h") {
    def <- get_height_def(response_name)
  } else if (measure_char == "d") {
    def <- get_diameter_def(response_name)
  } else if (measure_char == "e") {
    def <- get_density_def(response_name)
  } else if(measure_char == "r") {
    def <- get_ratio_def(response_name)
  } else {
    def <- list(description = character(0))
  }

  def
}
