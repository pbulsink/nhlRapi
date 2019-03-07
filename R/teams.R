#' Get Team
#'
#' @description Get the NHL teams, including historical teams. Or, get one single team
#' @param team Optional, get specific team information.
#' @param info Optional, if team is supplied, get specific info about a team. Options are:
#' \describe{
#'   \item{\code{person.names}}{Basic roster info}
#'   \item{\code{team.schedule.next}}{Returns details of the upcomgin game for a team}
#'   \item{\code{team.schedule.previous}}{Returns details of a teams' last game}
#' }
#' @param season Optional, if looking for season specific information on team
#'
#' @return The API output of teams
#' @export
#'
#' @examples
#' #See info on Washing Capitals (ID = 15)
#' caps <- getTeam(15)
#'
#' #See the Capitals' past game
#' caps_last <- getTeam(15, info = 'team.schedule.previous')
getTeam <- function(team = NULL, info = NULL, season = NULL) {
  modifiers<-NULL
  if (!is.null(team)) {
    # checks to prevent bad API calls from
    # progressing
    stopifnot(length(team) == 1)
    stopifnot(is.numeric(team))
    stopifnot(length(info) < 2)
    if(is.null(info)){
      query <- 'teams'
    } else if (info == "team.roster") {
      return(getTeamRoster(team = team, season = season))
    } else if (info == "team.stats") {
      return(getTeamStats(team = team, season = season))
    } else {
      stopifnot(length(info) == 1)
      stopifnot(info %in% c("person.names",
        "team.schedule.next", "team.schedule.previous"))
      modifiers <- c(modifiers, paste0("expand=", info))
    }
    query <- querybuilder("teams", team)
  } else {
    # No modifiers or season for all teams call.

    stopifnot(is.null(info))
    stopifnot(is.null(season))

    query <- "teams"
  }
  return(getStatAPI(query = query, modifiers = modifiers))
}


#' Get Team Roster
#'
#' @description Returns the team roster, configurable for season. Convenience wrapper around \code{\link{getTeam}(team = team, modifier = team.roster, season = season)}.
#'
#' @param team The team roster to get. Required
#' @param season Which season's roster to get. Optional, will get the current roster if not supplied.
#'
#' @return the API output of teams' rosters
#' @export
#'
#' @examples
#' #See the Carolina Hurricane's roster (ID = 12)
#' canes <- getTeamRoster(12)
#'
#' #Get their roster a few years ago
#' canes_past <- getTeamRoster(12, season = 20152016)
getTeamRoster <- function(team, season = NULL) {
  stopifnot(length(team) == 1)
  modifier <- "expand=team.roster"
  if (!is.null(season)) {
    stopifnot(length(season) == 1)
    stopifnot(is.numeric(season))
    stopifnot(validSeason(season))
    modifier <- c(modifier, paste0("season=",
      season))
  }
  query <- querybuilder("teams", team)
  return(getStatAPI(query = query, modifiers = modifier))
}


#' Get Team Stats
#'
#' @description Returns the team stats, both single season numbers and league ranking. Convenience wrapper around \code{\link{getTeam}(team = team, modifier = team.stats, season = season)}.
#'
#' @param team The team stats to get. Required.
#' @param season Which season's stats to get. Optional, will get the current years' stats if not supplied
#'
#' @return Team stats from the API
#' @export
#'
#' @examples
#' #See stats from the Philadelphia Flyers (ID = 4)
#' flyers <- getTeamStats(4)
#'
#' #See their stats from 20112012
#' flyers_past <- getTeamStats(4, season = 20112012)
getTeamStats <- function(team, season = NULL) {
  stopifnot(length(team) == 1)
  if (!is.null(season)) {
    stopifnot(length(season) == 1)
    stopifnot(is.numeric(season))
    stopifnot(validSeason(season))
    modifier <- paste0("season=", season)
  } else {
    modifier <- NULL
  }
  query <- querybuilder("teams", team, "stats")
  return(getStatAPI(query = query, modifiers = modifier))
}

#' Get Players per team
#'
#' @description This uses a different API endpoint from the other team gets. Pulls players on a team currently.
#'
#' @param team required, team id
#'
#' @return the players (from records api) on the team
#' @export
#'
#' @examples
#' #See the active players on Edmonton Oilers (ID = 22)
#' players <- getPlayersByTeam(22)
getPlayersByTeam<-function(team) {
  stopifnot(is.numeric(team))
  query<-querybuilder('player', 'byTeam', team)
  return(getRecordAPI(query = query))
}
