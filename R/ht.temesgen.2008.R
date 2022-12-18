ht.temesgen.2008.1 <- ParametricModel(
    response_unit = list(
        ht = as_units('m')
    ),
    covariate_units = list(
        dobbh = as_units('cm')
    ),
    parameters = c(
        b0 = 51.9954,
        b1 = -0.0208,
        b2 = 1.0182,
        sigma_epsilon = 4.029
    ),
    predict_fn = function(p, x) {
        1.37 + p$b0 * (1 - exp(p$b1 * x$dobbh)^p$b2)
    }
)
