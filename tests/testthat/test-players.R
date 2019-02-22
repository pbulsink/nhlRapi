context("test-players")

test_that("Player Scrapes", {
  q<-getPlayers(8475791)

  expect_equal(names(q), c('copyright', 'people'))
  expect_match(q$people$fullName, "Taylor Hall")

  q<-getPlayerStats(8475791)
  expect_equal(names(q), c('copyright', 'people'))
  expect_match(q$people$fullName, "Taylor Hall")

  q<-getPlayerStats(8475791, stat = 'careerRegularSeason')
  expect_equal(names(q), c('copyright', 'stats'))
  expect_match(as.character(q$stats$type), 'careerRegularSeason')

})

test_that("PlayerStatTypes come", {
  q<-getPlayerStatTypes()
  expect_gte(length(q), 29)
  expect_true('yearByYear' %in% q)
})
