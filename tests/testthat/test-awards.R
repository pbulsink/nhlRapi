context("test-awards")

test_that("Awards scrape", {
  q <- getAward()

  expect_s3_class(q, 'nhl_api')

  q <- getAward(1)

  expect_s3_class(q, 'nhl_api')
  expect_match(q$data$name, "Stanley Cup")

  # Expect Failures
  expect_error(getAward(c(1, 2)))
  expect_error(getAward("Stanley Cup"))

})

test_that("Trophys scrape", {
  q <- getTrophy()

  expect_s3_class(q, 'nhl_api')
  expect_true('stanley-cup' %in% q$data$shortName)

  q <- getTrophy('Vezina Trophy')
  expect_s3_class(q, 'nhl_api')
  expect_equal(q$data$shortName, 'vezina')
})
