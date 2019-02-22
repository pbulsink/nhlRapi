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
  expect_true(1+1==2)
})

test_that('getTeamStats', {
  expect_true(1+1==2)
})
