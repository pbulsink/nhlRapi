#' Get Records List
#'
#' @description The NHL maintains a sizeable list of records. Mosts, longests, fewests, youngests, etc.
#'
#'  @param recordName optional, filter result by record name
#'
#' @return a list of all records maintained by the NHL. The return is the API URL to call for the current record result.
#' @export
#'
#' @examples
#' records<-getRecordsList(recordName = "Most Consecutive Stanley Cups Won")
getRecordsList<-function(recordName = NULL){
  modifiers <- NULL
  if(!is.null(recordName)){
    modifiers<-paste0('description=',recordName)
  }
  return(getRecordAPI(query = 'record-detail', modifiers = modifiers))
}
