context("test-standings")

test_that("Standings scape works", {
  q <- getStandings()
  expect_s3_class(q, 'nhl_api')
  expect_true("regularSeason" %in% q$data$standingsType)

  q <- getStandings(standingsType = "wildCard",
    season = 20172018)
  expect_s3_class(q, 'nhl_api')
  expect_true("wildCard" %in% q$data$standingsType)
  expect_true("20172018" %in% q$data$season)
  expect_type(q$data$teamRecords, "list")

  q <- getStandings(date = "2019-02-21")
  expect_s3_class(q, 'nhl_api')
  expect_equal(q$data$teamRecords[[1]]$points,
    c(77, 75, 71, 70, 69, 63, 60, 56))

  q <- getStandings(standingsType = "wildCard",
    expand = TRUE)
  expect_s3_class(q, 'nhl_api')
  expect_true("records" %in% names(q$data$teamRecords[[1]]))

  # Expected Failures
  expect_error(getStandings(standingsType = c("wildCard",
    "regularSeason")))
  expect_error(getStandings(standingsType = "bad"))
  expect_error(getStandings(season = "bad"))
  expect_error(getStandings(season = 1))
  expect_error(getStandings(season = c(20172018,
    20182019)))
  expect_error(getStandings(date = "bad"))
  expect_error(getStandings(date = c("2018-02-01",
    "2018-02-02")))
})

test_that("Standings Types scrape", {
  q <- getStandingsTypes()
  expect_gt(length(q), 1)
  expect_true("regularSeason" %in% q)
})
