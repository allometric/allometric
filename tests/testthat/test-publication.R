
pub <- Publication(
    citation = RefManageR::BibEntry(
        bibtype = "article",
        author = "test",
        title = "test",
        journal = "test",
        year = 2000,
        volume = 0
    ),
    descriptors = list(
        region = 'US-WA'
    )
)

mod_dup_descriptor <- FixedEffectsModel(
    response_unit = list(vsa = units::as_units('ft^3')),
    covariate_units = list(dsob = units::as_units('in')),
    predict_fn <- function(dsob) {a * dsob},
    descriptors = list(region = 'test_region'),
    parameters = list(a=1)
)

test_that("Publication add_model errors on duplicated descriptor", {
    expect_error(add_model(pub, mod_dup_descriptor), "Duplicated descriptors:")
})