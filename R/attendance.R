#' Get Attendance Records
#'
#' @param season Optional, to pull attendance from given season. Format: 20172018
#'
#' @return season attendance records from the API
#' @export
#'
#' @examples
#' getAttendance()
#' getAttendance(20152016)
getAttendance<-function(season = NULL){
  if(!is.null(season)){
    stopifnot(is.numeric(season))
    stopifnot(validSeason(season))
    modifier = paste0('seasonId=', season)
  } else {
    modifier = NULL
  }
  return(getRecordAPI(query='attendance', modifiers = modifier))
}
