#' Query Builder
#'
#' @description Generic wrapper to build querys using paste0 collapsing on '/'
#'
#' @param ... all items to collapse to one query
#'
#' @return a string query of .../...
#' @export
#' @keywords internal
querybuilder<-function(...) {
  query<-list(...)
  return(paste0(query, collapse = "/"))
}

validSeason<-function(season) {
  if(as.numeric(strftime(Sys.Date(), '%m'))<8){
    year<-as.numeric(strftime(Sys.Date(), '%Y'))-1
  } else {
    year<-as.numeric(strftime(Sys.Date(), '%Y'))
  }
  seasons<-c(1920:year)
  seasons<-as.numeric(paste0(seasons, seasons+1))
  return(season %in% seasons)
}

getCurrentSeason<-function(){
  if(as.numeric(strftime(Sys.Date(), '%m'))<8){
    year<-as.numeric(strftime(Sys.Date(), '%Y'))-1
  } else {
    year<-as.numeric(strftime(Sys.Date(), '%Y'))
  }
  return(as.numeric(paste0(year, year+1)))
}
