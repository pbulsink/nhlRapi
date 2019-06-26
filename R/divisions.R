#' Get Division
#'
#' @description Get the NHL divisions, including historical divisions. Or, get one single division
#' @param division Optional, get specific division information. Pacific = 15, Central = 16, Atlantic = 17, Metropolitan = 18.
#'
#' @return The API output of divisions
#' @export
#'
#' @examples
#' #See information on NHL Divisions:
#' divisions <- getDivision()
getDivision <- function(division = NULL) {
  if (!is.null(division)) {
    # checks to prevent bad API calls from
    # progressing
    stopifnot(length(division) == 1)
    stopifnot(is.numeric(division))

    query <- querybuilder("divisions", division)
  } else {
    query <- "divisions"
  }
  return(getStatAPI(query = query))
}
