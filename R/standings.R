#' Get Standing
#'
#' @description Get the NHL standings, including historical standings. Or, get one single standing
#' @param standingsType Optional, get specific standing type. See \code{\link{getStandingsTypes}()} for allowed values
#' @param season Get statndings for a specific season. If null, current season returned. Season should be in format 20172018. Overrides date specification.
#' @param expand Whether to return detailed information from each team.
#'
#' @return The API output of standings
#' @export
#'
#' @examples
#' # get standings
#' standings <- getStandings()
#'
#' #Get standings from 20182009
#' standings <- getStandings(season = 20082009)
getStandings <- function(standingsType = NULL, season = NULL, expand = FALSE) {
  if (!is.null(standingsType)) {
    # checks to prevent bad API calls from
    # progressing
    stopifnot(length(standingsType) == 1)

    stopifnot(standingsType %in% c("regularSeason",
      "wildCard", "divisionLeaders", "wildCardWithLeaders",
      "preseason", "postseason", "byDivision",
      "byConference", "byLeague"))

    query <- querybuilder("standings", standingsType)
  } else {
    query <- "standings"
  }

  modifier <- NULL
  if (expand) {
    modifier <- c(modifier, "expand=standings.record")
  }
  if (!is.null(season)) {
    stopifnot(length(season) == 1)
    stopifnot(validSeason(season))
    modifier <- c(modifier, paste0("season=",
      season))
  }

  if (!is.null(modifier)) {
    modifier <- modifier[!is.null(modifier)]
  }

  return(getStatAPI(query = query, modifiers = modifier))
}

#' Get Standings Types
#'
#' @description Only certain standings display types are accepted. This returns the full valid list.
#'
#' @return a list of standings types to call with \code{\link{getStandings}()}
#' @export
#'
#' @examples
#' #Show the accepted standings types
#' standingTypes <- getStandingsTypes()
getStandingsTypes <- function() {
  return(unname(unlist(getStatAPI("standingsTypes"))))
}
