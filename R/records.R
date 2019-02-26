#' Get Records List
#'
#' @return a list of all records maintained by the NHL. The return is the API URL to call for the current record result.
#' @export
getRecordsList<-function(){
  return(getRecordAPI(query = 'record-detail'))
}
