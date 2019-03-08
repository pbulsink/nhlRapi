context("test-nhlrapi")

test_that("query queries", {
  q <- getStatAPI(query = "teams")
  expect_s3_class(q, 'nhl_api')
  expect_type(q$copyright, "character")
  expect_equal(Encoding(q$copyright), "UTF-8")
  expect_match(q$copyright, "NHL and the NHL Shield are registered trademarks of the National Hockey League. NHL and NHL team marks are the property of the NHL and its teams.")

  p<-capture.output(print(q))
  expect_true(any(grepl('NHL venues', p)))
})

test_that("copyright works", {
  q <- getCopyright()
  expect_match(q, "NHL and the NHL Shield are registered trademarks of the National Hockey League. NHL and NHL team marks are the property of the NHL and its teams.")
})
