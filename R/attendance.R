#' Get Attendance Records
#'
#' @return season attendance records from the API
#' @export
getAttendance<-function(){
  return(getRecordAPI(query='attendance'))
}
