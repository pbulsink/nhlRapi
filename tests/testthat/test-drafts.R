context("test-drafts")

test_that("Get Draft Works", {
  q <- getDraft(year = 2017)
  expect_equal(names(q), c("copyright", "drafts"))
  expect_equal(q$drafts$draftYear, 2017)
  
  q <- getDraft()
  expect_equal(names(q), c("copyright", "drafts"))
  
  # Expect Failures
  expect_error(getDraft(year = 1))
  expect_error(getDraft(year = c(2017, 2018)))
  expect_error(getDraft(year = 20172018))
  expect_error(getDraft(year = 2050))
  expect_error(getDraft(year = "now"))
})

test_that("Get Prospect Works", {
  q <- getProspect()
  expect_equal(names(q), c("copyright", "prospects"))
  
  q <- getProspect(1)
  expect_equal(names(q), c("copyright", "prospects"))
  
  # Expect Failures
  expect_error(getProspect("Bob"))
  expect_error(getProspect(c(1, 2)))
})
