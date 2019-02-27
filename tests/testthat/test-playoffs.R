context("test-playoffs")

test_that("playoff information works", {
  q<-getPlayoffDetails()
  expect_type(q, 'list')

  q1<-getPlayoffDetails(season = 20172018, series = 'Stanley Cup Final')
  q2<-getPlayoffDetails(season = 20172018, series = 4)

  expect_equal(q1, q2)

  #Expected Failures
  expect_error(getPlayoffDetails(season = 2, series = 4))
  expect_error(getPlayoffDetails(season = 2, series = 'Stanley Cup Finals'))
  expect_error(getPlayoffDetails(season = 20172018, series = 5))
  expect_error(getPlayoffDetails(season = 20172018, series = 'bad'))
})
