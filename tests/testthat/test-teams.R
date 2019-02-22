context("test-teams")

test_that("Team pulls team", {
  q<-getTeam()

  expect_type(q, 'list')
  expect_equal(names(q), c('copyright', 'teams'))

  expect_error(getTeam(modifier = 'bob'))
  expect_error(getTeam(c(1,2)))
  expect_error(getTeam(team = 1, modifier = 'teamRoster'))

  q<-getTeam(1, 'team.roster')
  expect_true('roster' %in% names(q$teams))
})

test_that('getTeamRoster', {
  q<-getTeamRoster(1)

  expect_equal(names(q), c('copyright', 'teams'))
  expect_equal(names(q$teams$roster$roster[[1]]),
               c("person", "jerseyNumber", "position"))

  q<-getTeamRoster(1, season=20102011)
  expect_true('Martin Brodeur' %in% q$teams$roster$roster[[1]]$person$fullName)
})

test_that('getTeamStats', {
  q <- getTeamStats(1, 20172018)

  expect_equal(names(q), c('copyright', 'stats'))
  expect_equal(q$stats$type$displayName, c('statsSingleSeason', 'regularSeasonStatRankings'))
})
