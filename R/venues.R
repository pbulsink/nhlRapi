#' Get Venue
#'
#' @description Get the NHL venues, or, get one single venue
#' @param venue Optional, get specific venue information.
#'
#' @return The API output of venues
#' @export
getVenue <- function(venue = NULL) {
  if(!is.null(venue)) {
    #checks to prevent bad API calls from progressing
    stopifnot(length(venue) == 1)
    stopifnot(is.numeric(venue))

    query <- querybuilder('venues', venue)
  } else {
    query <- 'venues'
  }
  return(getAPI(query = query))
}
