#' Get Venue
#'
#' @description Get the NHL venues, or, get one single venue. This is a very sparse endpoint, with very littel information available for only 16 venues. This may expand in the future.
#'
#' @param venue Optional, get specific venue information.
#'
#' @return The API output of venues
#' @export
#'
#' @examples
#' #See the league's venues
#' venues <- getVenue()
getVenue <- function(venue = NULL) {
  if (!is.null(venue)) {
    # checks to prevent bad API calls from
    # progressing
    stopifnot(length(venue) == 1)
    stopifnot(is.numeric(venue))

    query <- querybuilder("venues", venue)
  } else {
    query <- "venues"
  }
  return(getStatAPI(query = query))
}
