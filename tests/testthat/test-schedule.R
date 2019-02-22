context("test-schedule")

test_that("multiplication works", {
  q <- getSchedule(team = 1, startDate = '2019-02-21', scheduleType = 'broadcasts')

  expect_equal(names(q), c("copyright", "totalItems", "totalEvents", "totalGames", "totalMatches", "wait", "dates"))

  expect_equal(q$dates$date, '2019-02-21')

  expect_true('broadcasts' %in% names(q$dates$games[[1]]))

  q<-getSchedule(startDate = '2019-02-01', endDate = '2019-02-03')

  expect_equal(length(q$dates$date), 3)

})
