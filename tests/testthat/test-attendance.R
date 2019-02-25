context("test-attendance")

test_that("attendance works", {
  q<-getAttendance()
  expect_type(q, 'list')
  expect_equal(names(q$data), c("id", "playoffAttendance", "regularAttendance", "seasonId", "totalAttendance"))
})
