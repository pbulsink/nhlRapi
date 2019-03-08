context("test-attendance")

test_that("attendance works", {
  q<-getAttendance()
  expect_s3_class(q, 'nhl_api')
  expect_equal(names(q$data), c("id", "playoffAttendance", "regularAttendance", "seasonId", "totalAttendance"))

  q<-getAttendance(20172018)
  expect_s3_class(q, 'nhl_api')
  expect_equal(q$data$seasonId, 20172018)
})
