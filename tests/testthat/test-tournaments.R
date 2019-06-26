context("test-tournaments")

test_that("Tournaments scrape", {
  q <- getTournament()

  expect_s3_class(q, 'nhl_api')

  q <- getTournament(season = 20172018, expand = TRUE)

  expect_s3_class(q, 'nhl_api')
  expect_match(q$data$rounds$series[[1]]$names$matchupShortName[1], "TBL v NJD")

  # Expect Failures
  expect_error(getTournament(season=2017))
  expect_error(getTournament(expand='all'))

})
