context("test-divisions")

test_that("Divisions scrape", {
  q <- getSeasonInfo()

  expect_s3_class(q, 'nhl_api')

  q <- getSeasonInfo(20182019)

  expect_s3_class(q, 'nhl_api')
  expect_equal(q$data$regularSeasonEndDate, "2019-04-06")

  q <- getSeasonInfo('current')

  expect_s3_class(q, 'nhl_api')
  # expect_gte(as.Date(q$data$regularSeasonStartDate), as.Date('2018-10-03'))

  # Expect Failures
  expect_error(getSeasonInfo(c(1, 2)))
  expect_error(getSeasonInfo("now"))
})
