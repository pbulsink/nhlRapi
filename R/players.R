#' Get Players
#'
#' @description Get NHL players basic info & stats, including historical players.
#' @param player Mandatory, get a specific player's information.
#'
#' @return The API output of player
#' @export
getPlayers <- function(player = NULL) {
  stopifnot(length(player) == 1)
  stopifnot(is.numeric(player))

  query <- querybuilder("people", player)

  return(getStatAPI(query = query))
}

#' Get Player's Stats
#'
#' @description get specific stats for a provided player
#'
#' @param player The player ID to get stats
#' @param stat The speific stats to get. Many options exist, see \code{\link{getPlayerStatTypes}()} for full list
#' @param season a season, if required or desired, for querying stats. Format: 20172018 for the 2017-2018 season
#'
#' @return The API output of player
#' @export
getPlayerStats <- function(player, stat = NULL,
  season = NULL) {
  stopifnot(length(player) == 1)
  stopifnot(is.numeric(player))
  if (is.null(stat)) {
    # have to specify stat type. if basic stats
    # wanted, use getPlayers only.
    return(getPlayers(player = player))
  }

  stopifnot(stat %in% c("yearByYear", "yearByYearRank",
    "yearByYearPlayoffs", "yearByYearPlayoffsRank",
    "careerRegularSeason", "careerPlayoffs",
    "gameLog", "playoffGameLog", "vsTeam",
    "vsTeamPlayoffs", "vsDivision", "vsDivisionPlayoffs",
    "vsConference", "vsConferencePlayoffs",
    "byMonth", "byMonthPlayoffs", "byDayOfWeek",
    "byDayOfWeekPlayoffs", "homeAndAway", "homeAndAwayPlayoffs",
    "winLoss", "winLossPlayoffs", "onPaceRegularSeason",
    "regularSeasonStatRankings", "playoffStatRankings",
    "goalsByGameSituation", "goalsByGameSituationPlayoffs",
    "statsSingleSeason", "statsSingleSeasonPlayoffs"))

  if (!is.null(season)) {
    stopifnot(validSeason(season))
  }

  query <- querybuilder("people", player, "stats")

  modifier <- paste0("stats=", stat)
  if (!is.null(season)) {
    modifier <- c(modifier, paste0("season=",
      season))
  }

  return(getStatAPI(query = query, modifiers = modifier))
}

#' Get Player Stat Types
#'
#' @description Only certain stat types are accepted for players. This returns the full valid list.
#'
#' @return a list of player stat types to call with \code{\link{getPlayerStats}()}
#' @export
getPlayerStatTypes <- function() {
  return(unname(unlist(getStatAPI("statTypes"))))
}

#' Get Player Information
#'
#' Returns lots of metadata on players. Search by ID, first, middle & last name, position, country,
#'
#' @param playerID Optional, numeric player id
#' @param firstName Optional, filter by first name
#' @param lastName Optional, filter by last name
#' @param middleName Optional, filter by middle name
#' @param position Optional, filter by position
#' @param nationality Optional, filter by nationality
#'
#' @return Player info from API, filtered with selected filters
#' @export
#' @examples
#' #Pull up Dave Andreychuk's information
#' getPlayerRecord(firstName = 'Dave', lastName = 'Andreychuk')
getPlayerRecord<- function(firstName = NULL, lastName = NULL, middleName = NULL, position = NULL, playerID = NULL, nationality = NULL) {
  modifiers <- NULL
  if(!is.null(firstName)){
    stopifnot(is.character(firstName))
    modifiers <- c(modifiers, paste0('firstName="',firstName,'"'))
  }
  if(!is.null(lastName)){
    stopifnot(is.character(lastName))
    modifiers <- c(modifiers, paste0('lastName="',lastName,'"'))
  }
  if(!is.null(middleName)){
    stopifnot(is.character(middleName))
    modifiers <- c(modifiers, paste0('middleName="',middleName,'"'))
  }
  if(!is.null(nationality)){
    stopifnot(is.character(nationality))
    modifiers <- c(modifiers, paste0('nationality="',nationality,'"'))
  }
  if(!is.null(playerID)){
    stopifnot(is.numeric(playerID))
    modifiers <- c(modifiers, paste0('id=', playerID))
  }
  if(!is.null(position)){
    stopifnot(is.character(position))
    stopifnot(position %in% c('G','D','F','RW','LW','C','D/F','LW/D','C/RW','LW/RW','C/LW','RW/D','C/D', 'L', 'R'))
    modifiers <- c(modifiers, paste0('position="',position,'"'))
  }
  return(getRecordAPI(query='player', modifiers = modifiers))
}
