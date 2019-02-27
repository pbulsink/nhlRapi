context("test-attendance")

test_that("attendance works", {
  q<-getAttendance()
  expect_type(q, 'list')
  expect_equal(names(q$data), c("id", "playoffAttendance", "regularAttendance", "seasonId", "totalAttendance"))

  q<-getAttendance(20172018)
  expect_type(q, 'list')
  expect_equal(q$data$seasonId, 20172018)
})
