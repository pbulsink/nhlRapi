context("test-nhlrapi")

test_that("query queries", {
  q<-getAPI(query='teams')
  expect_type(q, 'list')
  expect_type(q$copyright, 'character')
  expect_equal(Encoding(q$copyright), 'UTF-8')
  expect_match(q$copyright, 'NHL and the NHL Shield are registered trademarks of the National Hockey League. NHL and NHL team marks are the property of the NHL and its teams.')
})

test_that('copyright works', {
  q<-getCopyright()
  expect_match(q, 'NHL and the NHL Shield are registered trademarks of the National Hockey League. NHL and NHL team marks are the property of the NHL and its teams.')
})
