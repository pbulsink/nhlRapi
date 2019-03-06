#' Get Playoff Details
#'
#' @param season optional, the season of playoff info you wish to get
#' @param series optional, either series number (1-4) or name ('Conference Quarterfinals', 'Conference Semifinals', 'Conference Finals', 'Stanley Cup Final').
#'
#' @return a list of all playoffs result matching provided season and series
#' @export
#' @examples
#' #Get all playoff series in 20172018
#' playoffs_1718<-getPlayoffDetails(season = 20172018)
#'
#' #Get all Stanley Cup Finals series:
#' playoffs_finals<-getPlayoffDetails(series = 'Stanley Cup Final')
#'
#' #alternativly, with a series code:
#' playoffs_finals<-getPlayoffDetails(series = 4)
getPlayoffDetails<-function(season = NULL, series = NULL){
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
    modifiers<-c(modifiers, paste0('seriesTitle="',series,'"'))
  }

  if(!is.null(season)){
    stopifnot(is.numeric(season))
    stopifnot(validSeason(season))
    modifiers<-c(modifiers, paste0('seasonId=',season))
  }

  if(length(modifiers) > 1){
    modifiers<-modifiers[!is.null(modifiers)]
  }

  return(getRecordAPI(query = 'playoff-series', modifiers = modifiers))
}
