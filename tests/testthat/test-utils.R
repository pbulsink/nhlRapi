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

test_that('GameNumber Validation Works', {
  expect_true(validateGameCode('2018021234'))
  expect_true(validateGameCode(2018021234))
  expect_false(validateGameCode('1234567890'))
  expect_false(validateGameCode(1))
  expect_false(validateGameCode('qwerty'))
})

test_that('FromDateTime Validation Works', {
  expect_true(validateFromTimeCode('20190223_221459'))
  expect_false(validateFromTimeCode('00190278_421459'))
  expect_false(validateFromTimeCode(1))
  expect_false(validateFromTimeCode('qwerty'))
})
