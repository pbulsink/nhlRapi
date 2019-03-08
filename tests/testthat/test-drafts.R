context("test-drafts")

test_that("Get Draft Works", {
  q <- getDraft(year = 2017)
  expect_s3_class(q, 'nhl_api')
  expect_equal(q$data$draftYear, 2017)

  q <- getDraft()
  expect_s3_class(q, 'nhl_api')

  # Expect Failures
  expect_error(getDraft(year = 1))
  expect_error(getDraft(year = c(2017, 2018)))
  expect_error(getDraft(year = 20172018))
  expect_error(getDraft(year = 2050))
  expect_error(getDraft(year = "now"))
})

test_that("Get Prospect Works", {
  q <- getProspect()
  expect_s3_class(q, 'nhl_api')

  q <- getProspect(1)
  expect_s3_class(q, 'nhl_api')

  # Expect Failures
  expect_error(getProspect("Bob"))
  expect_error(getProspect(c(1, 2)))
})

test_that("Draft Records work", {
  q <- getDraftRecords()
  expect_s3_class(q, 'nhl_api')

  q <- getDraftRecords(draftYear = 2016, overallPickNumber = 1, roundNumber = 1, country = 'USA', position = 'C')
  q2 <- getDraftRecords(firstName = "Auston", lastName = "Matthews", height = 74, weight = 216, amateurLeague = 'SWISS', draftTeamID = 10)
  q3 <- getDraftRecords(playerID = 8479318)
  expect_s3_class(q, 'nhl_api')
  expect_s3_class(q2, 'nhl_api')
  expect_s3_class(q3, 'nhl_api')
  expect_equal(q$data, q2$data)
  expect_equal(q$data, q3$data)
  expect_equal(q2$data,q3$data)
})
