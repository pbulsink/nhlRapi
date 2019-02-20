#' Base getAPI call
#'
#' @description Base API calling code for internal use. Use specific endpoints to build queries in recognized fasion.
#'
#' @param query base query
#' @param modifiers modifiers
#'
#' @return response parsed by jsonlite
#' @export
#' @keywords internal
getAPI <- function(query, modifiers = NULL){

  base_uri<-"https://statsapi.web.nhl.com/api/v1/"

  query_wrapper<-query

  if(!is.null(modifiers)){
    query_wrapper<-paste(query, paste0(modifiers, collapse = "&"), sep = "?")
  }

  call_url <- paste0(base_uri, query_wrapper)

  response<-httr::GET(call_url)

  httr::stop_for_status(response)

  response_content<-rawToChar(httr::content(response, 'raw'))

  json_response <- jsonlite::fromJSON(response_content)

  return(json_response)
}


