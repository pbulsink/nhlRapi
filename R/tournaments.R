#' Get Tournament
#'
#' @description Get the NHL tournaments (playoffs)
#'
#' @param season Optional, get specific season's playoff information
#' @param expand Optional, boolean, get expanded information
#'
#' @return The API output of tournaments/playoffs
#' @export
#'
#' @examples
#' #Get info on the 2017-2018 playoffs
#' playoff20172018<-getTournament(season = 20172018, expand = TRUE)
getTournament <- function(season = NULL, expand = FALSE) {
  modifier <- NULL
  if(!is.null(season)){
    stopifnot(validSeason(season))
    modifier<-c(modifier, paste0('season=', season))
  }
  if(expand){
    stopifnot(is.logical(expand))
    modifier<-c(modifier, 'expand=round.series')
  }

  return(getStatAPI(query = 'tournaments/playoffs', modifiers = modifier))
}
