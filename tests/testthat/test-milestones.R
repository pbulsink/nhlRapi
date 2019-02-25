context("test-milestones")

test_that("multiplication works", {
  q<-getMilestone('1000-point-career')
  expect_type(q, 'list')
  expect_true(all(q$data$careerPoints > 1000))

  #Expected Failures
  expect_error(getMilestone(milestone = 'bad'))
  expect_error(getMilestone(milestone = NULL))
})
