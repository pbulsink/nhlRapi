#' Get Team
#'
#' @description Get the NHL teams, including historical teams. Or, get one single team
#' @param team Optional, get specific team information.
#' @param modifier Optional, if team is supplied, get specific info about a team. Options are:
#'  - 'person.names' Basic roster info.
#'  - 'team.schedule.next' Returns details of the upcoming game for a team
#'  - 'team.schedule.previous' Same as above but for the last game played
#' @param season Optional, if looking for season specific information on team
#'
#' @return The API output of teams
#' @export
getTeam <- function(team = NULL, modifier = NULL,
  season = NULL) {
  if (!is.null(team)) {
    # checks to prevent bad API calls from
    # progressing
    stopifnot(length(team) == 1)
    stopifnot(is.numeric(team))
    stopifnot(length(modifier) < 2)
    if (modifier == "team.roster") {
      return(getTeamRoster(team = team, season = season))
    } else if (modifier == "team.stats") {
      return(getTeamStats(team = team, season = season))
    } else if (!is.null(modifier)) {
      stopifnot(length(modifier) == 1)
      stopifnot(modifier %in% c("person.names",
        "team.schedule.next", "team.schedule.previous"))
      modifier <- paste0("expand=", modifier)
    }
    query <- querybuilder("teams", team)
  } else {
    # No modifiers or season for all teams call.

    stopifnot(is.null(modifier))
    stopifnot(is.null(season))

    query <- "teams"
  }
  return(getStatAPI(query = query, modifiers = modifier))
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
#' @param team Team id
#'
#' @return the players (from records api) on the team
#' @export
getPlayersByTeam<-function(team) {
  stopifnot(is.numeric(team))
  query<-querybuilder('player', 'byTeam', team)
  return(getRecordAPI(query = query))
}
