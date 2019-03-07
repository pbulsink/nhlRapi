#' Get Officials
#'
#' @param active Whether to limit to active officials only. Optional, default False
#' @return Officials information
#' @export
#'
#' @examples
#' #Get all past officials
#' officials <- getOfficials()
#'
#' #To pull only active officials:
#' officials_active <- getOfficials(active = TRUE)
getOfficials<-function(active = FALSE){
  stopifnot(is.logical(active))
  if(active){
    return(getRecordAPI(query='officials', modifiers = 'active=true'))
  } else {
    return(getRecordAPI(query='officials'))
  }
}
