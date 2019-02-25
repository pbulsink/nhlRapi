context("test-games")

test_that("Game boxscore works", {
  q<-getGameBoxscore(2018020100)

  expect_equal(names(q), c('copyright', 'teams', 'officials'))
})

test_that("Game linescore works", {
  q<-getGameLinescore(2018020100)

  expect_equal(names(q), c("copyright", "currentPeriod", "currentPeriodOrdinal",
                           "currentPeriodTimeRemaining", "periods", "shootoutInfo",
                           "teams", "powerPlayStrength", "hasShootout",
                           "intermissionInfo", "powerPlayInfo"))
})

test_that("Game linescore works", {
  q<-getGameLinescore(2018020100)

  expect_equal(names(q), c("copyright", "currentPeriod", "currentPeriodOrdinal",
                           "currentPeriodTimeRemaining", "periods", "shootoutInfo",
                           "teams", "powerPlayStrength", "hasShootout",
                           "intermissionInfo", "powerPlayInfo"))
})

test_that("Game feed works", {
  q<-getGameFeed(2018020100)

  expect_equal(names(q), c("copyright", "gamePk", "link", "metaData", "gameData", "liveData"))
  expect_equal(q$link, "/api/v1/game/2018020100/feed/live")

  q<-getGameFeed(2018020100, from = '20181019_201500')
  expect_equal(names(q), c("copyright", "gamePk", "link", "metaData", "gameData", "liveData"))
  expect_equal(q$link, "/api/v1/game/2018020100/feed/live")
})
