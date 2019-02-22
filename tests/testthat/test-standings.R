context("test-standings")

test_that("Standings scape works", {
  q<-getStandings()
  expect_equal(names(q), c('copyright', 'records'))
  expect_true('regularSeason' %in% q$records$standingsType)

  q<-getStandings(standingsType = 'wildCard', season = 20172018)
  expect_equal(names(q), c('copyright', 'records'))
  expect_true('wildCard' %in% q$records$standingsType)
  expect_true('20172018' %in% q$records$season)
  expect_type(q$records$teamRecords, 'list')

  q<-getStandings(date = "2019-02-21")
  expect_equal(q$records$teamRecords[[1]]$points,
               c(77, 75, 71, 70, 69, 63, 60, 56))

  q<-getStandings(standingsType = 'wildCard', expand = TRUE)
  expect_true('records' %in% names(q$records$teamRecords[[1]]))


})

test_that("Standings Types scrape", {
  q<-getStandingsTypes()
  expect_gt(length(q), 1)
  expect_true('regularSeason' %in% q)
})
