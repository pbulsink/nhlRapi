context("test-franchises")

test_that("franchise scrapings work", {
  q<-getFranchiseList()

  expect_type(q, 'list')
  expect_equal(names(q$data), c("id", "firstSeasonId", "lastSeasonId", "mostRecentTeamId", "teamCommonName", "teamPlaceName"))

  q<-getFranchiseList(teamName = 'Golden Knights')
  q2<-getFranchiseList(teamPlace = 'Vegas')
  expect_equal(q, q2)

  q<-getFranchiseTeamTotal(franchiseID = 23, active = TRUE)
  q2<-getFranchiseTeamTotal(franchiseName = "New Jersey Devils")
  expect_type(q, 'list')
  expect_true('shutouts' %in% names(q$data))
  expect_equal(q, q2)
  q3<-getFranchiseTeamTotal(franchiseName = "New Jersey Devils", gameType = 2)
  expect_equal(q3$data, q$data[q$data$gameTypeId == '2', ])

  q<-getFranchiseTeamTotal(38)
  expect_type(q, 'list')
  expect_equal(q$data$teamName, c('Vegas Golden Knights', 'Vegas Golden Knights'))

  q<-getFranchiseRecords(38)
  expect_type(q, 'list')
  q<-getFranchiseSeasonResults(38)
  expect_type(q, 'list')
  q<-getFranchiseDetail()
  expect_type(q, 'list')
  q<-getFranchiseDetail(54)
  expect_type(q, 'list')
  expect_equal(q$total, 1)
  q<-getFranchiseGoalieRecords(38)
  expect_type(q, 'list')
  q<-getFranchiseSkaterRecords(38)
  expect_type(q, 'list')
  q<-getAllTimeRecordVsFranchise()
  expect_type(q, 'list')
  q<-getAllTimeRecordVsFranchise(38)
  expect_type(q, 'list')
  q<-getPlayoffRecordVsFranchise()
  expect_type(q, 'list')
  q<-getPlayoffRecordVsFranchise(38)
  expect_type(q, 'list')

  #Expected Failures
  expect_error(q<-getFranchiseList(teamName = 123))

})
