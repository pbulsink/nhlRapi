context("test-teams")

test_that("Team pulls team", {
  q <- getTeam()

  expect_s3_class(q, 'nhl_api')

  q<-getTeam(1)
  expect_s3_class(q, 'nhl_api')
  expect_equal(q$data$name, "New Jersey Devils")

  q <- getTeam(1, info = "team.schedule.previous")
  expect_s3_class(q, 'nhl_api')
  expect_true("previousGameSchedule" %in% names(q$data))

  q <- getTeam(1, info = "team.roster")
  expect_s3_class(q, 'nhl_api')
  expect_true("roster" %in% names(q$data))

  q <- getTeam(1, info = "team.stats")
  expect_s3_class(q, 'nhl_api')

  # Expect Failures
  expect_error(getTeam(team = 1, info = "bad"))
  expect_error(getTeam(c(1, 2)))
  expect_error(getTeam(team = 1, info = "teamRoster"))
  expect_error(getTeam(team = 1, info = c("bob",
    "bad")))
  expect_error(getTeam(info = "bad"))
  expect_error(getTeam(season = 20172018))

})

test_that("getTeamRoster", {
  q <- getTeamRoster(1)

  expect_s3_class(q, 'nhl_api')
  expect_equal(names(q$data$roster$roster[[1]]),
    c("person", "jerseyNumber", "position"))

  q <- getTeamRoster(1, season = 20102011)
  expect_s3_class(q, 'nhl_api')
  expect_true("Martin Brodeur" %in% q$data$roster$roster[[1]]$person$fullName)

  # Expect Failures
  expect_error(getTeamRoster())
  expect_error(getTeamRoster(team = c(1, 2)))
  expect_error(getTeamRoster(team = 1, season = c(20172018,
    20182019)))
  expect_error(getTeamRoster(team = 1, season = "now"))
  expect_error(getTeamRoster(team = 1, season = 2012))
})

test_that("getTeamStats", {
  q <- getTeamStats(1, 20172018)

  expect_s3_class(q, 'nhl_api')
  expect_equal(q$data$type$displayName, c("statsSingleSeason",
    "regularSeasonStatRankings"))

  # Expect Failures
  expect_error(getTeamStats())
  expect_error(getTeamStats(team = c(1, 2)))
  expect_error(getTeamStats(team = 1, season = c(20172018,
    20182019)))
  expect_error(getTeamStats(team = 1, season = "now"))
  expect_error(getTeamStats(team = 1, season = 2012))
})

test_that("get Team Players", {
  q<-getPlayersByTeam(1)
  expect_s3_class(q, 'nhl_api')
})
