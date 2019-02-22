context("test-nhlrapi")

test_that("query queries", {
  q<-getAPI(query='teams')
  expect_type(q, 'list')
  expect_match(q$copyright, 'NHL and the NHL Shield are registered trademarks of the National Hockey League. NHL and NHL team marks are the property of the NHL and its teams. © NHL 20[0-9][0-9]. All Rights Reserved.')
})
