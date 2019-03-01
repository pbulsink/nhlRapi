#' Get Franchise List
#'
#' @description The API has separate tables for Franchises and Teams. This allowed for teams that moved locations to have the same franchise, or locations with multiple teams to have different franchise histories (Winnipeg). This call returns franchises, which has a corresponding id to teams (see \code{output$data$mostRecentTeamID}).
#'
#' @param teamName Optional, filter by team name (e.g. "Golden Knights")
#' @param teamPlace Optional, filter by team place
#'
#' @return a list of all franchises in the NHL.
#' @export
#'
#' @examples
#' franchises<-getFranchiseList()
#'
#' #or, get specific franchise info:
#' franchise<-getFranchiseList(teamName = "Golden Knights")
#' franchise<-getFranchiseList(teamPlace = "Vegas")
getFranchiseList<-function(teamName = NULL, teamPlace = NULL){
  modifiers <- NULL
  if(!is.null(teamName)){
    stopifnot(is.character(teamName))
    modifiers <- c(modifiers, paste0('teamCommonName="',teamName,'"'))
  }
  if(!is.null(teamPlace)){
    stopifnot(is.character(teamPlace))
    modifiers <- c(modifiers, paste0('teamPlaceName="',teamPlace,'"'))
  }
  return(franchiseGeneric(query = 'franchise', modifier = modifiers))
}


#' Get Franchise Team Total Stats
#'
#' @description Gets team total stats (total goals scored, etc.). Results are split by 'gameType' (2 = regular season, 3 = playoff).
#'
#' @param franchiseID Optional franchise ID to filter results.
#' @param franchiseName Optional, only get results for team by name (e.g. "New Jersey Devils")
#' @param gameType Optional, numeric, filters to regular season (2) or playoffs (3) only. Otherwise returns both as separate sums.
#' @param active Optional, limit results to active franchises. Default: False
#'
#' @return total stats for every franchise.
#' @export
#'
#' @examples
#' #Get franchise totals for the Colorado Avalanche
#' avs_totals<-getFranchiseTeamTotal(franchiseName = "Colorado Avalanche")
#'
#' #Or, see all of the franchise's totals (franchise = 27), including Quebec Nordiques
#' avs_nordiques_totals<-getFranchiseTeamTotal(franchiseID = 27)
getFranchiseTeamTotal<-function(franchiseID = NULL, franchiseName = NULL, gameType=NULL, active = FALSE){
  modifiers<-NULL
  stopifnot(is.logical(active))
  if(active){
    modifiers<-c(modifiers, "lastSeasonId=null")
  }
  if(!is.null(franchiseName)){
    stopifnot(is.character(franchiseName))
    modifiers <- c(modifiers, paste0('teamName="',franchiseName,'"'))
  }
  if(!is.null(gameType)){
    stopifnot((gameType == 2 | gameType == 3))
    modifiers <- c(modifiers, paste0('gameTypeId=',gameType))
  }
  return(franchiseGeneric(query = 'franchise-team-totals', franchise = franchiseID, modifier = modifiers))
}


#' Get Franchise Record Stats
#'
#' @description Retrieves franchise records (best/worst seasons, most goals in a game, etc).
#'
#' @param franchiseID Optional franchise ID to filter results.
#' @param franchiseName Optional franchise name to filter results.
#'
#' @return Season record stats for every (filtered) franchise.
#' @export
#'
#' @examples
#' #See the records for franchise 23:
#' records<-getFranchiseRecords(franchiseID = 23)
#'
#' #Or, knowing that franchise 23 is New Jersey Devils:
#' records<-getFranchiseRecords(franchiseName = "New Jersey Devils")
getFranchiseRecords<-function(franchiseID = NULL, franchiseName = NULL){
  modifiers<-NULL
  if(!is.null(franchiseName)){
    stopifnot(is.character(franchiseName))
    modifiers <- c(modifiers, paste0('franchiseName="',franchiseName,'"'))
  }
  return(franchiseGeneric(query = 'franchise-season-records', franchise = franchiseID, modifier = modifiers))
}


#' Get Franchise Season Results Stats
#'
#' @param franchiseID Optional franchise ID to filter results.
#' @param franchiseName Optional franchise name to filter results.
#' @param gameType Optional, limit results to regular season (2) or playoffs (3). Accepts numerical input only
#'
#' @return Season record stats for every franchise.
#' @export
getFranchiseSeasonResults<-function(franchiseID = NULL, franchiseName = NULL, gameType=NULL){
  modifiers<-NULL
  if(!is.null(franchiseName)){
    stopifnot(is.character(franchiseName))
    modifiers <- c(modifiers, paste0('teamName="',franchiseName,'"'))
  }
  if(!is.null(gameType)){
    stopifnot((gameType == 2 | gameType == 3))
    modifiers <- c(modifiers, paste0('gameTypeId=',gameType))
  }
  return(franchiseGeneric(query = 'franchise-season-results', franchise = franchiseID, modifier = modifiers))
}


#' Get Franchise Detailed Information
#'
#' @param teamID Optional team ID to filter results.
#' @param franchiseID Optional franchise ID to filter results.
#'
#' @return detailed information for evey franchise, including captains, coaches, GMs, retired numbers, etc.
#' @export
getFranchiseDetail<-function(teamID = NULL, franchiseID = NULL){
  modifiers <- NULL
  if(!is.null(teamID)){
    stopifnot(is.numeric(teamID))
    modifiers<-paste0('mostRecentTeamId=', teamID)
  }
  if(!is.null(franchiseID)){
    stopifnot(is.numeric(franchiseID))
    modifiers<-paste0('id=', franchiseID)
  }
  return(getRecordAPI(query = 'franchise-detail', modifiers = modifiers))
}


#' Get Franchise Goalie Record Stats
#'
#' @description Returns goalie history and records. Includes career (with franchise) Win/Loss/Tie, shutouts, most goals against, etc.
#'
#' @param franchiseID Optional franchise ID to filter results.
#' @param franchiseName Optional franchise name to filter results.
#' @param firstName Optional, search for goalie by first name. Suggest using \code{lastName} to focus results.
#' @param lastName Optional, serach for a goalie by last name. Suggest using \code{firstName} to focus results.
#' @param active Optional, boolean, limit results to active players. Active can be on any team in the league.
#'
#' @return Goalie record stats for every franchise.
#' @export
#'
#' @examples
#' #Get active Ottawa Senators Goalies
#' goalies<-getFranchiseGoalieRecords(franchiseName = "Ottawa Senators", active = TRUE)
#'
#' #Search for a Goalie
#' lalime<-getFranchiseGoalieRecords(firstName = "Patrick", lastName = "Lalime")
getFranchiseGoalieRecords<-function(franchiseID = NULL, franchiseName = NULL, firstName = NULL, lastName = NULL, active = FALSE){
  stopifnot(is.logical(active))
  modifiers<-NULL
  if(!is.null(franchiseName)){
    stopifnot(is.character(franchiseName))
    modifiers <- c(modifiers, paste0('franchiseName="',franchiseName,'"'))
  }
  if(!is.null(firstName)){
    stopifnot(is.character(firstName))
    modifiers <- c(modifiers, paste0('firstName="',firstName,'"'))
  }
  if(!is.null(lastName)){
    stopifnot(is.character(lastName))
    modifiers <- c(modifiers, paste0('lastName="',lastName,'"'))
  }
  if(active){
    modifiers <- c(modifiers, 'activePlayer=TRUE')
  }
  return(franchiseGeneric(query = 'franchise-goalie-records', franchise = franchiseID, modifier = modifiers))
}


#' Get Franchise Season Record Stats
#'
#' @param franchiseID Optional franchise ID to filter results.
#'
#' @return Skater record stats for every franchise.
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
    modifier<-paste0('teamFranchiseId=', franchiseID)
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
    modifier<-paste0('teamFranchiseId=', franchiseID)
  } else {
    modifier<-NULL
  }
  return(getRecordAPI(query = 'playoff-franchise-vs-franchise', modifiers = modifier))
}


franchiseGeneric<-function(query, franchise = NULL, modifier = NULL){
  if(!is.null(franchise)){
    stopifnot(is.numeric(franchise))
    modifier<-c(modifier, paste0('franchiseId=', franchise))
  }
  return(getRecordAPI(query = query, modifiers = modifier))
}
