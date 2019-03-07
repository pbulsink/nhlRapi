#' Get Award
#'
#' @description Get the NHL awards, including historical awards. Or, get one single award
#'
#' @param award Optional, award ID to get specific award information. Notable awards include Stanley Cup = 1, Conn smythe = 7, Vezina = 18.
#'
#' @return The API output of awards
#' @export
#'
#' @examples
#' #See the list of all awards
#' awards <- getAward()
#'
#' #Only get stanley Cup info
#' getAward(award = 1)
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

#' Get Trophys
#'
#' @return trophy information from records api. Has ability to search by name
#'
#' @param name Optional, trophy name
#'
#' @export
#'
#' @examples
#' #See list of trophys
#' trophies <- getTrophy()
#'
#' #See only the Vezina trophy
#' vezina <- getTrophy('Vezina Trophy')
getTrophy<-function(name = NULL){
  modifiers <- NULL
  if(!is.null(name)){
    modifiers<-paste0('name="', name, '"')
  }
  return(getRecordAPI(query='trophy', modifiers = modifiers))
}
