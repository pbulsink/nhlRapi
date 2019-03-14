context("test-venues")

test_that("Venues scrape", {
  q <- getVenue()

  expect_s3_class(q, 'nhl_api')

  q <- getVenue(5017)

  expect_s3_class(q, 'nhl_api')
  expect_match(q$data$name, "Amalie Arena")

  # Expect Failures
  expect_error(getVenue(c(1, 2)))
  expect_error(getVenue("Scotiabank"))

})
