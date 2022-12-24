temesgen_2008_citation <- RefManageR::BibEntry(
    bibtype = 'article',
    key = 'temesgen_2008',
    title = 'Analysis and comparison of nonlinear tree height prediction
        strategies for Douglas-fir forests',
    author = 'Temesgen, Hailemariam and Monleon, Vicente J. and Hann, David W.',
    journal = 'Canadian Journal of Forest Research',
    year = 2008,
    volume = 38,
    number = 3,
    pages = '553-565',
    year = 2008
)

temesgen_2008 <- Publication(
    citation = temesgen_2008_citation
)

descriptors <- list(
    country = 'US',
    region = 'OR',
    family = 'Pinaceae',
    genus = 'Pseudotsuga',
    species = 'menziesii'
)

temesgen_2008 <- add_model(temesgen_2008, ParametricModel(
    response_unit = list(
        hst = as_units('m')
    ),
    covariate_units = list(
        dsob = as_units('cm')
    ),
    model_description = c(
        descriptors,
        b0 = 51.9954,
        b1 = -0.0208,
        b2 = 1.0182,
        sigma_epsilon = 4.029
    ),
    predict_fn = function(p, x) {
        1.37 + p$b0 * (1 - exp(p$b1 * x$dsob)^p$b2)
    }
))

temesgen_2008 <- add_model(temesgen_2008, ParametricModel(
    response_unit = list(
       hst = as_units('m')
    ),
    covariate_units = list(
        dsob = as_units('cm')
    ),
    model_description = c(
        descriptors,
        b0 = 40.4218,
        b1 = -0.0276,
        b2 = 0.936,
        sigma_b = 6.544,
        sigma_epsilon = 2.693
    ),
    predict_fn = function(p, x) {
        # FIXME add random effects?
        1.37 + p$b0 * (1 - exp(p$b1 * x$dsob)^p$b2)
    }
))

temesgen_2008 <- add_model(temesgen_2008, ParametricModel(
    response_unit = list(
       hst = as_units('m')
    ),
    covariate_units = list(
        dsob = as_units('cm')
    ),
    model_description = c(
        descriptors,
        b0 = 41.8199,
        b1 = -0.0241,
        b2 = 0.8604,
        sigma_b0 = 6.409,
        sigma_b2 = 0.165,
        sigma_b0b2 = 0.31,
        sigma_epsilon = 2.574
    ),
    predict_fn = function(p, x) {
        # FIXME add random effects?
        1.37 + p$b0 * (1 - exp(p$b1 * x$dsob)^p$b2)
    }
))

temesgen_2008 <- add_model(temesgen_2008, ParametricModel(
    response_unit = list(
       hst = as_units('m')
    ),
    covariate_units = list(
        ccfl  = as_units('m2 / ha'),
        ba    = as_units('m2 / ha'),
        dsob = as_units('cm')
    ),
    model_description = c(
        descriptors,
        b00 = 43.7195,
        b01 = 0.0644,
        b02 = 0.128,
        b1 = -0.0194,
        b2 = 1.0805,
        sigma_epsilon = 3.519
    ),
    predict_fn = function(p, x) {
        1.37 + (p$b00 + p$b01 * x$ccfl + p$b02 * x$ba) *
            (1 - exp(p$b1 * x$dsob)^p$b2)
    }
))

temesgen_2008 <- add_model(temesgen_2008, ParametricModel(
    response_unit = list(
       hst = as_units('m')
    ),
    covariate_units = list(
        ccfl = as_units('m2 / ha'),
        gn = as_units('m2 / ha'),
        dsob = as_units('cm')
    ),
    model_description = c(
        descriptors,
        b00 = 32.4635,
        b01 = 0.0363,
        b02 = 0.2585,
        b1 = -0.021,
        b2 = 0.9906,
        sigma_b = 4.635,
        sigma_epsilon = 2.641
    ),
    predict_fn = function(p, x) {
        1.37 + (p$b00 + p$b01 * x$ccfl + p$b02 * x$ba) *
            (1 - exp(p$b1 * x$dsob)^p$b2)
    }
))

temesgen_2008 <- add_model(temesgen_2008, ParametricModel(
    response_unit = list(
       hst= as_units('m')
    ),
    covariate_units = list(
        ccfl = as_units('m2 / ha'),
        gn = as_units('m2 / ha'),
        dsob = as_units('cm')
    ),
    model_description = c(
        descriptors,
        b00 = 35.7419,
        b01 = 0.0431,
        b02 = 0.2447,
        b1 = -0.0184,
        b2 = 0.961,
        sigma_b0 = 4.743,
        sigma_b2 = 0.098,
        sigma_b0b2 = 0.125,
        sigma_epsilon = 2.566
    ),
    predict_fn = function(p, ccfl, bast, dsob) {
        1.37 + (p$b_00 + p$b_01 * ccfl + p$b_02 * bast) *
            (1 - exp(p$b_1 * dsob)^p$b_2)
    }
))
