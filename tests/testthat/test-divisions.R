context("test-divisions")

test_that("Divisions scrape", {
  q<-getDivision()

  expect_equal(names(q), c('copyright', 'divisions'))

  q<-getDivision(16)

  expect_equal(names(q), c('copyright', 'divisions'))
  expect_match(q$divisions$name, "Central")

})
