#' Get Team
#'
#' @description Get the NHL teams, including historical teams. Or, get one single team
#' @param team Optional, get specific team information.
#' @param modifier Optional, if team is supplied, get specific info about a team. Options are:
#'  - 'team.roster' Shows roster of active players for the specified team
#'  - 'person.names' Same as above, but gives less info.
#'  - 'team.schedule.next' Returns details of the upcoming game for a team
#'  - 'team.schedule.previous' Same as above but for the last game played
#'  - 'team.stats' Returns the teams stats for the season
#'  - list('team.roster', 'season=20142015') Adding the season identifier shows the roster for that season
#'  - list('team.stats', 'stats=statsSingleSeasonPlayoffs') Specify which stats to get.
#'  @param season Optional, if looking for season specific information on team
#'
#' @return The API output of teams
#' @export
getTeam <- function(team = NULL, modifier = NULL, season = NULL) {
  if(!is.null(team)) {
    #checks to prevent bad API calls from progressing
    stopifnot(length(team) == 1)
    stopifnot(is.numeric(team))
    if(!is.null(modifier)){
      if(!is.list(modifier)){
        stopifnot(modifier %in% c('team.roster', 'person.names', 'team.schedule.next',
                                  'team.schedule.previous', 'team.stats'))
        modifier<-paste0('expand=',modifier)
      } else {
        stopifnot((('team.roster' %in% modifier) | ('team.stats' %in% modifier)))
        modifier[modifier == 'team.roster']<-'expand=team.roster'
        modifier[modifier == 'team.stats']<-'expand=team.stats'
      }
    }
    query <- querybuilder('teams', team)
  } else {
    #No modifiers or season for all teams call.

    stopifnot(is.null(modifier))
    stopifnot(is.null(season))

    query <- 'teams'
  }
  return(getAPI(query = query, modifiers = modifier))
}
