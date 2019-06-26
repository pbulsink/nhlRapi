#' Get Game Boxscore
#'
#' @description Get a NHL game boxscore. Includes goals, shots, PIMs, blocked, takeaways, giveaways and hits.
#'
#' @param game Required, get specific game boxscore. Gamecode in format YYYYTTNNNN, with:
#' \describe{
#'   \item{\code{YYYY}}{Season of game, 2017 for 20172018 season}
#'   \item{\code{TT}}{Type of game: Either 02 for regular season, or 03 for playoffs}
#'   \item{\code{NNNN}}{Game number: from 0001 to 1230 (prior to 2017) or 0001 to 1271 (2017 and onwards)}
#' }
#'
#' @return The boxscore API output of games
#' @export
#'
#' @examples
#' #Show boxscore from the first game of 2015-2016
#' boxscore <- getGameBoxscore(2015020001)
getGameBoxscore <- function(game) {
  # checks to prevent bad API calls from
  # progressing
  stopifnot(length(game) == 1)
  stopifnot(is.numeric(game))
  stopifnot(validateGameCode(game))

  query <- querybuilder("game", game, "boxscore")

  return(getStatAPI(query = query))
}


#' Get Game Linescore
#'
#' @description Get a NHL game linescore. Includes goals, shots on goal, powerplay and goalie pulled status, number of skaters and shootout information if applicable
#' @param game Required, get specific game boxscore. Gamecode in format YYYYTTNNNN, with:
#' \describe{
#'   \item{\code{YYYY}}{Season of game, 2017 for 20172018 season}
#'   \item{\code{TT}}{Type of game: Either 02 for regular season, or 03 for playoffs}
#'   \item{\code{NNNN}}{Game number: from 0001 to 1230 (prior to 2017) or 0001 to 1271 (2017 and onwards)}
#' }
#'
#' @return The linescore output of the API
#' @export
#'
#' @examples
#' #Get NHL game linescore from last game of regular season 20172018
#' linescore <- getGameLinescore(2017021271)
getGameLinescore <- function(game) {
  # checks to prevent bad API calls from
  # progressing
  stopifnot(length(game) == 1)
  stopifnot(is.numeric(game))
  stopifnot(validateGameCode(game))

  query <- querybuilder("game", game, "linescore")

  return(getStatAPI(query = query))
}


#' Get Game Feed
#'
#' @description Get a NHL game feed. Includes play by play data with event locations, and after-game info like 3 stars.
#' @param game Required, get specific game feed. Gamecode in format YYYYTTNNNN, with:
#' \describe{
#'   \item{\code{YYYY}}{Season of game, 2017 for 20172018 season}
#'   \item{\code{TT}}{Type of game: Either 02 for regular season, or 03 for playoffs}
#'   \item{\code{NNNN}}{Game number: from 0001 to 1230 (prior to 2017) or 0001 to 1271 (2017 and onwards)}
#' }
#' @param from Time from which to update, format yyyymmdd_hhmmss
#'
#' @return The feed API output of games
#' @export
#'
#' @examples
#' #Get the game feed from mid 20162017
#' feed <- getGameFeed(2016020758)
getGameFeed <- function(game, from = NULL) {
  # checks to prevent bad API calls from
  # progressing
  stopifnot(length(game) == 1)
  stopifnot(is.numeric(game))
  stopifnot(validateGameCode(game))

  if (!is.null(from)) {
    stopifnot(validateFromTimeCode(from))
    modifiers <- paste0("startTimecode=", from)
  } else {
    modifiers <- NULL
  }

  query <- querybuilder("game", game, "feed",
    "live")

  return(getStatAPI(query = query, modifiers = modifiers))
}
