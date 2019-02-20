#' Get Players
#'
#' @description Get NHL players basic info, including historical players.
#' @param player Mandatory, get a specific player's information.
#'
#' @return The API output of player
#' @export
getPlayers <- function(player = NULL) {
  stopifnot(length(player) == 1)
  stopifnot(is.numeric(player))

  query <- querybuilder('people', player)

  return(getAPI(query = query))
}

#' Get Player's Stats
#'
#' @description get specific stats for a provided player
#'
#' @param player The player ID to get stats
#' @param stat The speific stats to get. Many options exist:
#'  - statsSingleSeason - Also provide a season
#'  - homeAndAway - Split by home and away games
#'  - winLoss - Split stats by win/loss/tie outcome
#'  - byMonth -
#'  - byDayOfWeek -
#'  - vsDivision - split stats by division of opponent
#'  - vsConference - split stats by conference of opponent
#'  - vsTeam - split stats by opponent team
#'  - gameLog - provides game by game log of stats
#'  - regularSeasonStatRankings - provides ranking of each stat in season
#'  - goalsByGameSituation
#'  - onPaceRegularSeason - only works for current season, shows pace projected
#'  @param season a season, if required or desired, for querying stats
#'
#' @return The API output of player
#' @export
getPlayerStats <- function(player, stat = NULL, season = NULL) {
  stopifnot(length(player) == 1)
  stopifnot(is.numeric(player))
  stopifnot(stat %in% c(NULL, 'statsSingleSeason', 'homeAndAway', 'winLoss', 'byMonth',
                        'byDayOfWeek', 'vsDivision', 'vsConference', 'vsTeam', 'gameLog',
                        'regularSeasonStatRankings', 'goalsByGameSituation', 'onPaceRegularSeason'))

  if(!is.null(season)){
    stopifnot(validSeason(season))
  }

  query <- querybuilder('people', player, 'stats')

  ##TODO Write stat to modifier
  modifier <- NULL
  return(getAPI(query = query, modifiers = modifier))
}
