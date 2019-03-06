context("test-players")

test_that("Player Scrapes", {
  q <- getPlayers(8475791)

  expect_equal(names(q), c("copyright", "people"))
  expect_match(q$people$fullName, "Taylor Hall")

  q <- getPlayerStats(8475791)
  expect_equal(names(q), c("copyright", "people"))
  expect_match(q$people$fullName, "Taylor Hall")

  q <- getPlayerStats(8475791, stat = "careerRegularSeason")
  expect_equal(names(q), c("copyright", "stats"))
  expect_match(as.character(q$stats$type), "careerRegularSeason")

  q <- getPlayerStats(8475791, stat = "statsSingleSeason",
    season = 20162017)
  expect_equal(q$stats$splits[[1]]$season, "20162017")

  q <- getPlayerStats(8475791, stat = "statsSingleSeason",
    season = 20172018)
  expect_equal(q$stats$splits[[1]]$season, "20172018")

  # Expected Failures
  expect_error(getPlayers(c(1, 5)))
  expect_error(getPlayers("Taylor Hall"))

  expect_error(getPlayerStats(c(1, 5)))
  expect_error(getPlayerStats("Taylor Hall"))
  expect_error(getPlayerStats(8475791, stat = "bad.stats"))
  expect_error(getPlayerStats(8475791, stat = "yearByYear",
    season = 1))
})

test_that("PlayerStatTypes come", {
  q <- getPlayerStatTypes()
  expect_gte(length(q), 29)
  expect_true("yearByYear" %in% q)
})

test_that("Player Records work", {
  q<-getPlayerRecord(firstName = 'Dave', lastName = 'Andreychuk')
  q2<-getPlayerRecord(middleName = 'John', position = 'L', nationality = 'CAN', playerID = 8445000)

  expect_type(q, 'list')
  expect_type(q2, 'list')

  expect_equal(q, q2)
})
