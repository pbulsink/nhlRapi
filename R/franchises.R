#' Get Franchise List
#'
#' @description The API has separate tables for Franchises and Teams. This allowed for teams that moved locations to have the same franchise, or locations with multiple teams to have different franchise histories (Winnipeg). This call returns franchises, which has a corresponding id to teams (see \code{output$data$mostRecentTeamID}).
#'
#' @return a list of all franchises in the NHL.
#' @export
getFranchiseList<-function(){
  return(franchiseGeneric(query = 'franchise'))
}

#' Get Franchise Team Total Stats
#'
#' @param franchiseID Optional franchise ID to filter results.
#'
#' @return total stats for every franchise.
#' @export
getFranchiseTeamTotal<-function(franchiseID = NULL){
  return(franchiseGeneric(query = 'franchise-team-totals', franchise = franchiseID))
}

#' Get Franchise Season Record Stats
#'
#' @param franchiseID Optional franchise ID to filter results.
#'
#' @return Season record stats for every franchise.
#' @export
getFranchiseSeasonRecords<-function(franchiseID = NULL){
  return(franchiseGeneric(query = 'franchise-season-records', franchise = franchiseID))
}

#' Get Franchise Season Results Stats
#'
#' @param franchiseID Optional franchise ID to filter results.
#'
#' @return Season record stats for every franchise.
#' @export
getFranchiseSeasonResults<-function(franchiseID = NULL){
  return(franchiseGeneric(query = 'franchise-season-results', franchise = franchiseID))
}

#' Get Franchise Detailed Information
#'
#' @param teamID Optional team ID to filter results.
#'
#' @return detailed information for evey franchise, including captains, coaches, GMs, retired numbers, etc.
#' @export
getFranchiseDetail<-function(teamID = NULL){
  if(!is.null(teamID)){
    stopifnot(is.numeric(teamID))
    modifier<-paste0('cayenneExp=mostRecentTeamId=', teamID)
  } else {
    modifier<-NULL
  }
  return(getRecordAPI(query = 'franchise-detail', modifiers = modifier))
}

#' Get Franchise Goalie Record Stats
#'
#' @param franchiseID Optional franchise ID to filter results.
#'
#' @return Season record stats for every franchise.
#' @export
getFranchiseGoalieRecords<-function(franchiseID = NULL){
  return(franchiseGeneric(query = 'franchise-goalie-records', franchise = franchiseID))
}

#' Get Franchise Season Record Stats
#'
#' @param franchiseID Optional franchise ID to filter results.
#'
#' @return Season record stats for every franchise.
#' @export
getFranchiseSkaterRecords<-function(franchiseID = NULL){
  return(franchiseGeneric(query = 'franchise-skater-records', franchise = franchiseID))
}

#' Get Franchise Head to Head record
#'
#' @param franchiseID Optional franchise ID to filter results.
#'
#' @return Head to head records for every franchise.
#' @export
getAllTimeRecordVsFranchise<-function(franchiseID = NULL){
  if(!is.null(franchiseID)){
    stopifnot(is.numeric(franchiseID))
    modifier<-paste0('cayenneExp=teamFranchiseId=', franchiseID)
  } else {
    modifier<-NULL
  }
  return(getRecordAPI(query = 'all-time-record-vs-franchise', modifiers = modifier))
}

#' Get Franchise Head to Head playoff record
#'
#' @param franchiseID Optional franchise ID to filter results.
#'
#' @return Head to head records for every franchise' playoff games.
#' @export
getPlayoffRecordVsFranchise<-function(franchiseID = NULL){
  if(!is.null(franchiseID)){
    stopifnot(is.numeric(franchiseID))
    modifier<-paste0('cayenneExp=teamFranchiseId=', franchiseID)
  } else {
    modifier<-NULL
  }
  return(getRecordAPI(query = 'playoff-franchise-vs-franchise', modifiers = modifier))
}

franchiseGeneric<-function(query, franchise = NULL){
  if(!is.null(franchise)){
    stopifnot(is.numeric(franchise))
    modifier<-paste0('cayenneExp=franchiseId=', franchise)
  } else {
    modifier<-NULL
  }
  return(getRecordAPI(query = query, modifiers = modifier))
}
