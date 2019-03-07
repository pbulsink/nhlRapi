#' Get Records List
#'
#' @description The NHL maintains a sizeable list of records. Mosts, longests, fewests, youngests, etc.
#'
#' @param recordKey optional, filter result by record key
#'
#' @return a list of all records maintained by the NHL. The return is the API URL to call for the current record result.
#' @export
#'
#' @examples
#' records <- getRecordsList(recordKey = "most-shots-one-game")
getRecordsList<-function(recordKey = NULL){
  modifiers <- NULL
  if(!is.null(recordKey)){
    modifiers<-paste0('descriptionKey="', recordKey, '"')
  }
  return(getRecordAPI(query = 'record-detail', modifiers = modifiers))
}
