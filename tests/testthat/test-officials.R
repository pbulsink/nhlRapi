context("test-officials")

test_that("officials works", {
  q<-getOfficials()
  expect_s3_class(q, 'nhl_api')
  expect_true('officialType' %in% names(q$data))

  q2<-getOfficials(active = TRUE)
  expect_gt(nrow(q$data), nrow(q2$data))
})
