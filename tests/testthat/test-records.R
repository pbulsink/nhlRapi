context("test-records")

test_that("Get Records", {
  q<-getRecordsList()

  expect_s3_class(q, 'nhl_api')
  expect_equal(names(q$data), c("id", "description", "descriptionKey", "restUrl", "sequence", "videoId"))

  q<-getRecordsList(recordKey = 'most-shots-one-game')
  expect_s3_class(q, 'nhl_api')
  expect_equal(nrow(q$data), 1)
})
