#' Get Playoff Details
#'
#' @param season optional, the season of playoff info you wish to get
#' @param series optional, either series number (1-4) or name ('Conference Quarterfinals', 'Conference Semifinals', 'Conference Finals', 'Stanley Cup Final').
#'
#' @return a list of all playoffs result matching provided season and series
#' @export
getPlayoffDetails<-function(season = NULL, series = NULL){
  #/playoff-series?cayenneExp=seriesTitle="Stanley Cup Final" and seasonId=20172018

  modifiers<-NULL

  if(!is.null(series)){
    if(!is.numeric(series)){
      stopifnot(is.character(series))
      stopifnot(series %in% c('Conference Quarterfinals', 'Conference Semifinals',
                              'Conference Finals', 'Stanley Cup Final'))
    } else {
      stopifnot(0<series, series<5)
      series <- c('Conference Quarterfinals', 'Conference Semifinals',
                  'Conference Finals', 'Stanley Cup Final')[series]
    }
    modifiers<-c(modifiers, paste0('cayenneExp=seriesTitle="',series,'"'))
  }

  if(!is.null(season)){
    stopifnot(is.numeric(season))
    stopifnot(validSeason(season))
    modifiers<-c(modifiers, paste0('seasonId=',season))
  }

  if(length(modifiers) > 1){
    modifiers<-modifiers[!is.null(modifiers)]
  }

  return(getRecordAPI(query = 'playoff-series', modifier = modifiers))
}
