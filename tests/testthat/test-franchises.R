context("test-franchises")

test_that("franchise scrapings work", {
  q<-getFranchiseList()

  expect_s3_class(q, 'nhl_api')
  expect_equal(names(q$data), c("id", "firstSeasonId", "lastSeasonId", "mostRecentTeamId", "teamCommonName", "teamPlaceName"))

  q<-getFranchiseList(teamName = 'Golden Knights')
  expect_s3_class(q, 'nhl_api')
  q2<-getFranchiseList(teamPlace = 'Vegas')
  expect_s3_class(q2, 'nhl_api')
  expect_equal(q$data, q2$data)

  q<-getFranchiseTeamTotal(franchiseID = 23, active = TRUE)
  q2<-getFranchiseTeamTotal(franchiseName = "New Jersey Devils")
  expect_s3_class(q, 'nhl_api')
  expect_s3_class(q2, 'nhl_api')
  expect_true('shutouts' %in% names(q$data))
  expect_equal(q$data, q2$data)
  q3<-getFranchiseTeamTotal(franchiseName = "New Jersey Devils", gameType = 2)
  expect_s3_class(q3, 'nhl_api')
  expect_equal(q3$data, q$data[q$data$gameTypeId == '2', ])

  q<-getFranchiseTeamTotal(38)
  expect_s3_class(q, 'nhl_api')
  expect_equal(q$data$teamName, c('Vegas Golden Knights', 'Vegas Golden Knights'))

  q<-getFranchiseRecords(franchiseID = 22)
  expect_s3_class(q, 'nhl_api')
  q2<-getFranchiseRecords(franchiseName = 'New York Islanders')
  expect_s3_class(q2, 'nhl_api')
  expect_equal(q$data, q2$data)

  q<-getFranchiseSeasonResults(franchiseID = 37, season = 20172018)
  expect_s3_class(q, 'nhl_api')
  q2<-getFranchiseSeasonResults(franchiseName = 'Minnesota Wild', season = 20172018)
  expect_s3_class(q2, 'nhl_api')
  #different orders supplied, reorganizing q & q2
  expect_equivalent(q$data[order(q$data$seasonId, q$data$gameTypeId),], q2$data[order(q2$data$seasonId, q2$data$gameTypeId),])
  q2<-getFranchiseSeasonResults(gameType = 2, franchiseID = 37, season = 20172018)
  expect_s3_class(q2, 'nhl_api')
  expect_equivalent(q2$data, q$data[q$data$gameTypeId == 2,])


  q<-getFranchiseDetail(teamID = 12)
  q2<-getFranchiseDetail(franchiseID = 26)
  expect_s3_class(q, 'nhl_api')
  expect_s3_class(q2, 'nhl_api')
  expect_equal(q$data, q2$data)

  q<-getFranchiseGoalieRecords(franchiseID = 30, active = TRUE)
  q2<-getFranchiseGoalieRecords(franchiseName = 'Ottawa Senators', active = TRUE)
  expect_s3_class(q, 'nhl_api')
  expect_s3_class(q2, 'nhl_api')
  expect_equal(q$data, q2$data)

  q<-getFranchiseGoalieRecords(franchiseID = 30, firstName = "Patrick", lastName = "Lalime")
  expect_s3_class(q, 'nhl_api')
  expect_equal(nrow(q$data), 1)

  q<-getFranchiseSkaterRecords(franchiseID = 27, active = TRUE)
  q2<-getFranchiseSkaterRecords(franchiseName = 'Colorado Avalanche', active = TRUE)
  expect_s3_class(q, 'nhl_api')
  expect_s3_class(q2, 'nhl_api')
  expect_equal(q$data, q2$data)

  q<-getFranchiseSkaterRecords(franchiseID = 27, firstName = "Joe", lastName = "Sakic")
  expect_s3_class(q, 'nhl_api')
  expect_equal(nrow(q$data), 1)

  q<-getAllTimeRecordVsFranchise(franchiseID = 11)
  expect_s3_class(q, 'nhl_api')
  q2<-getAllTimeRecordVsFranchise(franchiseName = "Chicago Blackhawks")
  expect_s3_class(q2, 'nhl_api')
  expect_equivalent(q$data[order(q$data$id),], q2$data[order(q2$data$id),])

  q<-getAllTimeRecordVsFranchise(opponentName = "Columbus Blue Jackets")
  expect_s3_class(q, 'nhl_api')
  q2<-getAllTimeRecordVsFranchise(opponentID = 36)
  expect_s3_class(q2, 'nhl_api')
  expect_equivalent(q$data, q2$data)

  q<-getPlayoffRecordVsFranchise(franchiseID = 12)
  expect_s3_class(q, 'nhl_api')
  q2<-getPlayoffRecordVsFranchise(franchiseName = "Detroit Red Wings")
  expect_s3_class(q2, 'nhl_api')
  expect_equivalent(q$data, q2$data)

  q<-getPlayoffRecordVsFranchise(opponentName = "Florida Panthers")
  expect_s3_class(q, 'nhl_api')
  q2<-getPlayoffRecordVsFranchise(opponentID = 33)
  expect_s3_class(q2, 'nhl_api')
  expect_equivalent(q$data, q2$data)

  #Expected Failures
  expect_error(q<-getFranchiseList(teamName = 123))

})
