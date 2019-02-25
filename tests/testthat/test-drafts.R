context("test-drafts")

test_that("Get Draft Works", {
  q<-getDraft(year = 2017)
  expect_equal(names(q), c('copyright', 'drafts'))
  expect_equal(q$drafts$draftYear, 2017)

  q<-getDraft()
  expect_equal(names(q), c('copyright', 'drafts'))
})

test_that("Get Prospect Works", {
  q<-getProspect()
  expect_equal(names(q), c('copyright', 'prospects'))

  q<-getProspect(1)
  expect_equal(names(q), c('copyright', 'prospects'))
})