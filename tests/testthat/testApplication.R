test_that("basic run", {
    app <- CustomApplicationExample$new(KBC_DATA_DIR)
    app$run()

    # verify the results
    dfResult <- read.csv(file = file.path(KBC_DATA_DIR, 'out/tables/results.csv'), stringsAsFactors = FALSE)
    expect_equal(50, nrow(dfResult))
    expect_equal(14, ncol(dfResult))
})
