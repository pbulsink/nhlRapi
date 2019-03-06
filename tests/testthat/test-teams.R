context("test-teams")

test_that("Team pulls team", {
  q <- getTeam()

  expect_type(q, "list")
  expect_equal(names(q), c("copyright", "teams"))

  q <- getTeam(1, modifier = "team.schedule.previous")
  expect_true("previousGameSchedule" %in% names(q$teams))

  q <- getTeam(1, "team.roster")
  expect_true("roster" %in% names(q$teams))

  q <- getTeam(1, "team.stats")
  expect_equal(names(q), c("copyright", "stats"))

  # Expect Failures
  expect_error(getTeam(team = 1, modifier = "bad"))
  expect_error(getTeam(c(1, 2)))
  expect_error(getTeam(team = 1, modifier = "teamRoster"))
  expect_error(getTeam(team = 1, modifier = c("bob",
    "bad")))
  expect_error(getTeam(modifier = "bad"))
  expect_error(getTeam(season = 20172018))

})

test_that("getTeamRoster", {
  q <- getTeamRoster(1)

  expect_equal(names(q), c("copyright", "teams"))
  expect_equal(names(q$teams$roster$roster[[1]]),
    c("person", "jerseyNumber", "position"))

  q <- getTeamRoster(1, season = 20102011)
  expect_true("Martin Brodeur" %in% q$teams$roster$roster[[1]]$person$fullName)

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

  expect_equal(names(q), c("copyright", "stats"))
  expect_equal(q$stats$type$displayName, c("statsSingleSeason",
    "regularSeasonStatRankings"))

  # Expect Failures
  expect_error(getTeamStats())
  expect_error(getTeamStat(steam = c(1, 2)))
  expect_error(getTeamStats(team = 1, season = c(20172018,
    20182019)))
  expect_error(getTeamStats(team = 1, season = "now"))
  expect_error(getTeamStats(team = 1, season = 2012))
})

test_that("get Team Players", {
  q<-getPlayersByTeam(1)
  expect_type(q, 'list')
})
