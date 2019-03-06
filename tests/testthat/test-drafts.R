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

test_that("Draft Records work", {
  q <- getDraftRecords()
  expect_type(q, 'list')

  q <- getDraftRecords(draftYear = 2016, overallPickNumber = 1, roundNumber = 1, country = 'USA', position = 'C')
  q2 <- getDraftRecords(firstName = "Auston", lastName = "Matthews", height = 74, weight = 216, amateurLeague = 'SWISS', draftTeamID = 10)
  q3 <- getDraftRecords(playerID = 8479318)
  expect_type(q, 'list')
  expect_type(q2, 'list')
  expect_type(q3, 'list')
  expect_equal(q, q2)
  expect_equal(q, q3)
  expect_equal(q2,q3)
})
