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

  q<-getFranchiseRecords(franchiseID = 22)
  expect_type(q, 'list')
  q2<-getFranchiseRecords(franchiseName = 'New York Islanders')
  expect_type(q2, 'list')
  expect_equal(q, q2)

  q<-getFranchiseSeasonResults(franchiseID = 37)
  expect_type(q, 'list')
  q2<-getFranchiseSeasonResults(franchiseName = 'Minnesota Wild')
  expect_type(q2, 'list')
  #different orders supplied, reorganizing q & q2
  expect_equivalent(q$data[order(q$data$seasonId, q$data$gameTypeId),], q2$data[order(q2$data$seasonId, q2$data$gameTypeId),])
  q2<-getFranchiseSeasonResults(gameType = 2, franchiseID = 37)

  expect_equivalent(q2$data, q$data[q$data$gameTypeId == 2,])


  q<-getFranchiseDetail(teamID = 12)
  q2<-getFranchiseDetail(franchiseID = 26)
  expect_type(q, 'list')
  expect_type(q2, 'list')
  expect_equal(q, q2)

  q<-getFranchiseGoalieRecords(franchiseID = 30, active = TRUE)
  q2<-getFranchiseGoalieRecords(franchiseName = 'Ottawa Senators', active = TRUE)
  expect_type(q, 'list')
  expect_type(q2, 'list')
  expect_equal(q, q2)

  q<-getFranchiseGoalieRecords(franchiseID = 30, firstName = "Patrick", lastName = "Lalime")
  expect_type(q, 'list')
  expect_equal(nrow(q$data), 1)


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
