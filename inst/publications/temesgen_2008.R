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
    citation = temesgen_2008_citation,
    descriptors = list(
        country = 'US',
        region = 'OR',
        family = 'Pinaceae',
        genus = 'Pseudotsuga',
        species = 'menziesii'
    )
)

temesgen_2008 <- add_model(temesgen_2008, ParametricModel(
    response_unit = list(
        hst = as_units('m')
    ),
    covariate_units = list(
        dsob = as_units('cm')
    ),
    model_description = list(
        b_0 = 51.9954,
        b_1 = -0.0208,
        b_2 = 1.0182,
        sigma_epsilon = 4.029
    ),
    predict_fn = function(dsob) {
        1.37 + b_0 * (1 - exp(b_1 * dsob)^b_2)
    }
))

temesgen_2008 <- add_model(temesgen_2008, ParametricModel(
    response_unit = list(
       hst = as_units('m')
    ),
    covariate_units = list(
        dsob = as_units('cm')
    ),
    model_description = list(
        b_0 = 40.4218,
        b_1 = -0.0276,
        b_2 = 0.936,
        sigma_b = 6.544,
        sigma_epsilon = 2.693
    ),
    predict_fn = function(dsob) {
        # FIXME add random effects?
        1.37 + b_0 * (1 - exp(b_1 * dsob)^b_2)
    }
))

temesgen_2008 <- add_model(temesgen_2008, ParametricModel(
    response_unit = list(
       hst = as_units('m')
    ),
    covariate_units = list(
        dsob = as_units('cm')
    ),
    model_description = list(
        b_0 = 41.8199,
        b_1 = -0.0241,
        b_2 = 0.8604,
        sigma_b_0 = 6.409,
        sigma_b_2 = 0.165,
        sigma_b_0_b_2 = 0.31,
        sigma_epsilon = 2.574
    ),
    predict_fn = function(dsob) {
        # FIXME add random effects?
        1.37 + b_0 * (1 - exp(b_1 * dsob)^b_2)
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
    model_description = list(
        b_00 = 43.7195,
        b_01 = 0.0644,
        b_02 = 0.128,
        b_1 = -0.0194,
        b_2 = 1.0805,
        sigma_epsilon = 3.519
    ),
    predict_fn = function(ccfl, ba, dsob) {
        1.37 + (b_00 + b_01 * ccfl + b_02 * ba) *
            (1 - exp(b_1 * dsob)^b_2)
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
    model_description = list(
        b_00 = 32.4635,
        b_01 = 0.0363,
        b_02 = 0.2585,
        b_1 = -0.021,
        b_2 = 0.9906,
        sigma_b = 4.635,
        sigma_epsilon = 2.641
    ),
    predict_fn = function(ccfl, ba, dsob) {
        1.37 + (b_00 + b_01 * ccfl + b_02 * ba) *
            (1 - exp(b_1 * dsob)^b_2)
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
    model_description = list(
        b_00 = 35.7419,
        b_01 = 0.0431,
        b_02 = 0.2447,
        b_1 = -0.0184,
        b_2 = 0.961,
        sigma_b_0 = 4.743,
        sigma_b2 = 0.098,
        sigma_b_0b2 = 0.125,
        sigma_epsilon = 2.566
    ),
    predict_fn = function(ccfl, bast, dsob) {
        1.37 + (b_00 + b_01 * ccfl + b_02 * bast) *
            (1 - exp(b_1 * dsob)^b_2)
    }
))
