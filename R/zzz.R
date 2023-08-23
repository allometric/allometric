attempt_load_models <- function(pkgname) {
  rds_path <- system.file("extdata/allometric_models.RDS", package = pkgname)

  if (rds_path == "") {
    warning(
      "Install allometric models with install_models() before beginning.",
      call. = FALSE
    )
  } else {
    .GlobalEnv$allometric_models <- readRDS(rds_path)
  }
}

load_var_defs <- function() {
  component_defs <- utils::read.csv(system.file("variable_defs/components.csv", package = "allometric"))
  measure_defs <- utils::read.csv(system.file("variable_defs/measures.csv", package = "allometric"))

  var_defs.pre <- list(
    d = utils::read.csv(system.file("variable_defs/d.csv", package = "allometric")),
    v = utils::read.csv(system.file("variable_defs/v.csv", package = "allometric")),
    h = utils::read.csv(system.file("variable_defs/h.csv", package = "allometric")),
    b = utils::read.csv(system.file("variable_defs/b.csv", package = "allometric")),
    e = utils::read.csv(system.file("variable_defs/e.csv", package = "allometric")),
    r = utils::read.csv(system.file("variable_defs/r.csv", package = "allometric")),
    a = utils::read.csv(system.file("variable_defs/a.csv", package = "allometric")),
    g = utils::read.csv(system.file("variable_defs/g.csv", package = "allometric"))
  )

  prefixes <- utils::read.csv(system.file("variable_defs/prefix.csv", package = "allometric"))
  suffixes <- utils::read.csv(system.file("variable_defs/suffix.csv", package = "allometric"))


  var_defs <- prepare_var_defs(var_defs.pre, measure_defs, component_defs)


  .GlobalEnv$prefixes <- prefixes
  .GlobalEnv$suffixes <- suffixes
  .GlobalEnv$var_defs <- var_defs
}

.onLoad <- function(libname, pkgname) {
  load_var_defs()
  attempt_load_models(pkgname)
}
