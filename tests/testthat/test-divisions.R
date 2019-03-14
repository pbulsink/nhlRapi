context("test-divisions")

test_that("Divisions scrape", {
  q <- getDivision()

  expect_s3_class(q, 'nhl_api')

  q <- getDivision(16)

  expect_s3_class(q, 'nhl_api')
  expect_match(q$data$name, "Central")

  # Expect Failures
  expect_error(getDivision(c(1, 2)))
  expect_error(getDivision("Central"))
})
