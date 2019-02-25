#' Get Draft
#'
#' @description Get round by round data for draft years.
#' @param year Optional, get specific draft year information. If not set, returns current year's draft. First draft was 1963, so any year prior will result in error
#'
#'
#' @return The API output of draft
#' @export
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
  return(getAPI(query = query))
}

#' Get Prospect
#'
#' @description Get the NHL draft prospects for the current year, or get one single prospect
#'
#' @param prospect Optional, get specific prospect information.
#'
#' @return The API output of prospects
#' @export
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
  return(getAPI(query = query))
}
