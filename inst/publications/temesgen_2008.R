library(units)

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
        region = "US-OR",
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
    parameters = list(
        b_0 = 51.9954,
        b_1 = -0.0208,
        b_2 = 1.0182
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
    parameters = list(
        b_0 = 40.4218,
        b_1 = -0.0276,
        b_2 = 0.936
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
    parameters = list(
        b_0 = 41.8199,
        b_1 = -0.0241,
        b_2 = 0.8604
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
    parameters = list(
        b_00 = 43.7195,
        b_01 = 0.0644,
        b_02 = 0.128,
        b_1 = -0.0194,
        b_2 = 1.0805
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
    parameters = list(
        b_00 = 32.4635,
        b_01 = 0.0363,
        b_02 = 0.2585,
        b_1 = -0.021,
        b_2 = 0.9906
    ),
    predict_fn = function(ccfl, gn, dsob) {
        1.37 + (b_00 + b_01 * ccfl + b_02 * gn) *
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
    parameters = list(
        b_00 = 35.7419,
        b_01 = 0.0431,
        b_02 = 0.2447,
        b_1 = -0.0184,
        b_2 = 0.961
    ),
    predict_fn = function(ccfl, gn, dsob) {
        1.37 + (b_00 + b_01 * ccfl + b_02 * gn) *
            (1 - exp(b_1 * dsob)^b_2)
    }
))
