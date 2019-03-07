context("test-records")

test_that("Get Records", {
  q<-getRecordsList()

  expect_type(q, 'list')
  expect_equal(names(q$data), c("id", "description", "descriptionKey", "restUrl", "sequence", "videoId"))

  q<-getRecordsList(recordKey = 'most-shots-one-game')
  expect_type(q, 'list')
  expect_equal(q$total, 1)
})
