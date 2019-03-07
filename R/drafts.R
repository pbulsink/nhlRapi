#' Get Draft
#'
#' @description Get round by round data for draft year(s).
#'
#' @param year Optional, get specific draft year information. If not set, returns current year's draft. First draft was 1963, so any year prior will result in error
#'
#' @return The API output of draft
#' @export
#'
#' @examples
#' #Get draft data for 2002 entry draft
#' getDraft(2002)
getDraft <- function(year = NULL) {
  if (!is.null(year)) {
    # checks to prevent bad API calls from
    # progressing
    stopifnot(length(year) == 1)
    stopifnot(is.numeric(year))
    stopifnot(year >= 1963, year <= as.numeric(strftime(Sys.Date(),
      "%Y")))

    query <- querybuilder("draft", year)
  } else {
    query <- "draft"
  }
  return(getStatAPI(query = query))
}

#' Get Prospect
#'
#' @description Get the NHL draft prospects for the current year, or get one single prospect
#'
#' @param prospect Optional, get specific prospect information.
#'
#' @return The API output of prospects
#' @export
#'
#' @examples
#' #See prospects
#' getProspect()
getProspect <- function(prospect = NULL) {
  if (!is.null(prospect)) {
    # checks to prevent bad API calls from
    # progressing
    stopifnot(length(prospect) == 1)
    stopifnot(is.numeric(prospect))

    query <- querybuilder("draft", "prospects",
      prospect)
  } else {
    query <- querybuilder("draft", "prospects")
  }
  return(getStatAPI(query = query))
}

#' getDraftRecords
#'
#' Pull up information on specific draft picks. Many filters to chose from.
#'
#' @param firstName Optional, drafted player first name
#' @param lastName Optional, drafted player last name
#' @param draftYear Optional, drafted player drafted year
#' @param overallPickNumber Optional, drafted player overall pick number
#' @param weight Optional, drafted player weight
#' @param height Optional, drafted player height
#' @param position Optional, drafted player position (LW, C, RW, D, G, F)
#' @param roundNumber Optional, round in which player was drafterd
#' @param draftTeamID Optional, drafting TEAM ID
#' @param amateurLeague Optional, drafted player previous amateur league. Many NA values in API database
#' @param country Optional, drafted player country
#' @param playerID Optional, player ID
#'
#' @return API results from the drafts endpoint, filtered using any parameters
#' @export
#'
#' @examples
#' #See all goaltenders drafted in 2006:
#' getDraftRecords(position="G", draftYear = 2006)
getDraftRecords<-function(firstName = NULL, lastName = NULL, draftYear = NULL, overallPickNumber = NULL, weight = NULL, height = NULL, position = NULL, roundNumber = NULL, draftTeamID = NULL, amateurLeague = NULL, country = NULL, playerID = NULL){
  modifiers<-NULL
  if(!is.null(firstName)){
    stopifnot(is.character(firstName))
    modifiers <- c(modifiers, paste0('firstName="',firstName,'"'))
  }
  if(!is.null(lastName)){
    stopifnot(is.character(lastName))
    modifiers <- c(modifiers, paste0('lastName="',lastName,'"'))
  }
  if(!is.null(draftYear)){
    stopifnot(is.numeric(draftYear))
    stopifnot(draftYear>=1963)
    modifiers <- c(modifiers, paste0('draftYear=', draftYear))
  }
  if(!is.null(overallPickNumber)){
    stopifnot(is.numeric(overallPickNumber))
    modifiers <- c(modifiers, paste0('overallPickNumber=', overallPickNumber))
  }
  if(!is.null(weight)){
    stopifnot(is.numeric(weight))
    modifiers <- c(modifiers, paste0('weight=', weight))
  }
  if(!is.null(height)){
    stopifnot(is.numeric(height))
    modifiers <- c(modifiers, paste0('height=', height))
  }
  if(!is.null(position)){
    stopifnot(is.character(position))
    stopifnot(position %in% c('G','D','F','RW','LW','C','D/F','LW/D','C/RW','LW/RW','C/LW','RW/D','C/D', 'L', 'R'))
    modifiers <- c(modifiers, paste0('position="',position,'"'))
  }
  if(!is.null(roundNumber)){
    stopifnot(is.numeric(roundNumber))
    modifiers <- c(modifiers, paste0('roundNumber=', roundNumber))
  }
  if(!is.null(playerID)){
    stopifnot(is.numeric(playerID))
    modifiers <- c(modifiers, paste0('playerId=', playerID))
  }
  if(!is.null(draftTeamID)){
    stopifnot(is.numeric(draftTeamID))
    modifiers <- c(modifiers, paste0('draftedByTeamId=', draftTeamID))
  }
  if(!is.null(amateurLeague)){
    stopifnot(is.character(amateurLeague))
    modifiers <- c(modifiers, paste0('amateurLeague="',amateurLeague,'"'))
  }
  if(!is.null(country)){
    stopifnot(is.character(country))
    modifiers <- c(modifiers, paste0('countryCode="',country,'"'))
  }
  return(getRecordAPI(query = 'draft', modifiers = modifiers))
}
