context("test-games")

test_that("Game boxscore works", {
  q<-getGameBoxscore(2018020100)

  expect_equal(names(q), c('copyright', 'teams', 'officials'))

  #Expect Failures
  expect_error(getGameBoxscore(1))
  expect_error(getGameBoxscore('bad'))
  expect_error(getGameBoxscore(c(2018020100, 2018020101)))
})

test_that("Game linescore works", {
  q<-getGameLinescore(2018020100)

  expect_equal(names(q), c("copyright", "currentPeriod", "currentPeriodOrdinal",
                           "currentPeriodTimeRemaining", "periods", "shootoutInfo",
                           "teams", "powerPlayStrength", "hasShootout",
                           "intermissionInfo", "powerPlayInfo"))

  #Expect Failures
  expect_error(getGameLinescore(1))
  expect_error(getGameLinescore('bad'))
  expect_error(getGameLinescore(c(2018020100, 2018020101)))
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

  #Expect Failures
  expect_error(getGameFeed(1))
  expect_error(getGameFeed('bad'))
  expect_error(getGameFeed(c(2018020100, 2018020101)))
  expect_error(getGameFeed(2018020100, from = '20181019:201500'))
  expect_error(getGameFeed(2018020100, from = 'now'))

})
