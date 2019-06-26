#' Get Season Info
#'
#' @description Get season information, such as start/end dates, Olympics participation, use of ties, etc.
#'
#' @param season Optional, get specific season information. Season as 20172018 format, or 'current' for current season
#'
#' @return The API output of seasons
#' @export
#'
#' @examples
#' #See information on NHL Season 20172018:
#' season1718 <- getSeasonInfo(20172018)
#' #See the current season info
#' currentSeason <- getSeasonInfo('current')
getSeasonInfo <- function(season = NULL) {
  if (!is.null(season)) {
    # checks to prevent bad API calls from
    # progressing
    stopifnot(length(season) == 1)
    if(season == 'current'){
      query <- querybuilder('seasons', 'current')
    } else if (validSeason(season))
      query <- querybuilder("seasons", season)
  } else {
    query <- "seasons"
  }
  return(getStatAPI(query = query))
}
