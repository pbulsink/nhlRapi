context("test-awards")

test_that("Awards scrape", {
  q<-getAward()

  expect_equal(names(q), c('copyright', 'awards'))

  q<-getAward(1)

  expect_equal(names(q), c('copyright', 'awards'))
  expect_match(q$awards$name, "Stanley Cup")

})