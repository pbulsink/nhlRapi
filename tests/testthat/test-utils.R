context("test-utils")

test_that("Query Builder builds properly", {
  expect_equal(querybuilder('a', 'b'), 'a/b')
})

test_that("Season Validator Works", {
  expect_true(validSeason(20182019))
  expect_false(validSeason('bob'))
  expect_false(validSeason('2018-2019'))
  expect_false(validSeason(20752076))
  expect_false(validSeason(1819))
})

test_that("Getting Current Season works", {
  expect_equal(nchar(getCurrentSeason()), 8)
  expect_type(getCurrentSeason(), 'double')
})
