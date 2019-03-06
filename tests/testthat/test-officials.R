context("test-officials")

test_that("officials works", {
  q<-getOfficials()
  expect_type(q, 'list')
  expect_true('officialType' %in% names(q$data))

  q2<-getOfficials(active = TRUE)
  expect_gt(q$total, q2$total)
})
