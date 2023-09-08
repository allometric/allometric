# This script runs the package variables that are global

component_defs <- get_component_defs()
measure_defs <- get_measure_defs()

var_defs_pre <- list(
  d = utils::read.csv(
    system.file("variable_defs/d.csv", package = "allometric")
  ),
  v = utils::read.csv(
    system.file("variable_defs/v.csv", package = "allometric")
  ),
  h = utils::read.csv(
    system.file("variable_defs/h.csv", package = "allometric")
  ),
  b = utils::read.csv(
    system.file("variable_defs/b.csv", package = "allometric")
  ),
  e = utils::read.csv(
    system.file("variable_defs/e.csv", package = "allometric")
  ),
  r = utils::read.csv(
    system.file("variable_defs/r.csv", package = "allometric")
  ),
  a = utils::read.csv(
    system.file("variable_defs/a.csv", package = "allometric")
  ),
  g = utils::read.csv(
    system.file("variable_defs/g.csv", package = "allometric")
  )
)

prefixes <- utils::read.csv(
  system.file("variable_defs/prefix.csv", package = "allometric")
)

suffixes <- utils::read.csv(
  system.file("variable_defs/suffix.csv", package = "allometric")
)

var_defs <- prepare_var_defs(var_defs_pre, measure_defs, component_defs)