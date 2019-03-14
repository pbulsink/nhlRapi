context("test-conferences")

test_that("Conferences scrape", {
  q <- getConference()

  expect_s3_class(q, 'nhl_api')

  q <- getConference(5)

  expect_s3_class(q, 'nhl_api')
  expect_match(q$data$name, "Western")

  # Expect Failures
  expect_error(getConference(c(1, 2)))
  expect_error(getConference("Western"))

})
