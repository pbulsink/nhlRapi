context("test-conferences")

test_that("Conferences scrape", {
  q<-getConference()

  expect_equal(names(q), c('copyright', 'conferences'))

  q<-getConference(5)

  expect_equal(names(q), c('copyright', 'conferences'))
  expect_match(q$conferences$name, "Western")

})
