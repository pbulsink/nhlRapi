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
  seasons<-c(1920:getCurrentSeason())
  seasons<-as.numeric(paste0(seasons, seasons+1))
  return(season %in% seasons)
}

getCurrentSeason<-function(){
  if(as.numeric(strftime(Sys.Date(), '%m'))<8){
    return(as.numeric(strftime(Sys.Date(), '%Y'))-1)
  } else {
    return(as.numeric(strftime(Sys.Date(), '%Y')))
  }
}
