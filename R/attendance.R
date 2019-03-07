#' Get Attendance Records
#'
#' @description Returns league-wide season attendance totals (no game-by-game or team-by-team breakdown available)
#'
#' @param season Optional, to filter attendance to a given season. Format: 20172018
#'
#' @return season attendance records from the API
#' @export
#'
#' @examples
#' #See all attendance records
#' getAttendance()
#'
#' #Only see attendance from a certain year
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
