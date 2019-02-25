#' Get Conference
#'
#' @description Get the NHL conferences, including historical conferences. Or, get one single conference
#' @param conference Optional, get specific conference information. Eastern = 6, Western = 5, World cup of Hockey = 7
#'
#' @return The API output of conferences
#' @export
getConference <- function(conference = NULL) {
  if (!is.null(conference)) {
    # checks to prevent bad API calls from
    # progressing
    stopifnot(length(conference) == 1)
    stopifnot(is.numeric(conference))

    query <- querybuilder("conferences", conference)
  } else {
    query <- "conferences"
  }
  return(getStatAPI(query = query))
}
