#' Get Award
#'
#' @description Get the NHL awards, including historical awards. Or, get one single award
#' @param award Optional, get specific award information. Notable awards include Stanley Cup = 1, Conn smythe = 7, Vezina = 18.
#'
#' @return The API output of awards
#' @export
getAward <- function(award = NULL) {
  if (!is.null(award)) {
    # checks to prevent bad API calls from
    # progressing
    stopifnot(length(award) == 1)
    stopifnot(is.numeric(award))

    query <- querybuilder("awards", award)
  } else {
    query <- "awards"
  }
  return(getStatAPI(query = query))
}
