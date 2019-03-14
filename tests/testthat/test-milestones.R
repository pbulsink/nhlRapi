context("test-milestones")

test_that("milestones works", {
  q<-getMilestone('1000-point-career')
  expect_s3_class(q, 'nhl_api')
  expect_true(all(q$data$careerPoints >= 1000))

  #Expected Failures
  expect_error(getMilestone(milestone = 'bad'))
  expect_error(getMilestone(milestone = NULL))
})
