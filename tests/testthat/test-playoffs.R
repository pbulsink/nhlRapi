context("test-playoffs")

test_that("playoff information works", {
  q<-getPlayoffDetails()
  expect_s3_class(q, 'nhl_api')

  q<-getPlayoffDetails(season = 20172018, series = 'Stanley Cup Final')
  q2<-getPlayoffDetails(season = 20172018, series = 4)

  expect_s3_class(q, 'nhl_api')
  expect_s3_class(q2, 'nhl_api')
  expect_equal(q$data, q2$data)

  #Expected Failures
  expect_error(getPlayoffDetails(season = 2, series = 4))
  expect_error(getPlayoffDetails(season = 2, series = 'Stanley Cup Finals'))
  expect_error(getPlayoffDetails(season = 20172018, series = 5))
  expect_error(getPlayoffDetails(season = 20172018, series = 'bad'))
})
