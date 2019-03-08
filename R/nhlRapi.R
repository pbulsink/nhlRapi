#' Base getStatAPI call
#'
#' @description Base API calling code for stat queries (for internal use). Use specific endpoints to build queries in recognized fasion.
#'
#' @param query base query
#' @param modifiers modifiers
#'
#' @return response parsed by jsonlite
#' @keywords internal
getStatAPI <- function(query, modifiers = NULL) {

  base_uri <- "https://statsapi.web.nhl.com/api/v1/"

  query_wrapper <- query

  if (!is.null(modifiers)) {
    query_wrapper <- paste(query, paste0(modifiers,
      collapse = "&"), sep = "?")
  }

  call_url <- paste0(base_uri, query_wrapper)

  return(baseAPI(call_url, query_wrapper, type = 'stat'))
}

#' Base getRecordAPI call
#'
#' @description Base API calling code for record queries (for internal use). Use specific endpoints to build queries in recognized fasion.
#'
#' @param query base query
#' @param modifiers modifiers
#'
#' @return response parsed by jsonlite
#' @keywords internal
getRecordAPI <- function(query, modifiers = NULL) {

  base_uri <- "https://records.nhl.com/site/api/"

  query_wrapper <- query

  if (!is.null(modifiers)) {
    modifiers[1]<-paste0('cayenneExp=', modifiers[1])
    query_wrapper <- paste(query, paste0(modifiers,
                                         collapse = "%20and%20"), sep = "?")
  }

  call_url <- paste0(base_uri, query_wrapper)
  return(baseAPI(call_url, query_wrapper, type = 'record'))
}

#' Ultimate BASE api call.
#'
#' @param call_url the generated url to get
#' @param query_wrapper specific query to api endpoint
#' @param type stat or record, for S3 generation
#'
#' @return json response
baseAPI<-function(call_url, query_wrapper, type){
  ua <- httr::user_agent("http://github.com/pbulsink/nhlRapi")

  call_url<-gsub(' ', '%20', call_url)

  response <- httr::GET(call_url, ua)

  # Stop if not 200 ((OK)) returned
  httr::stop_for_status(response)

  # Stops if not json returned.
  stopifnot(httr::http_type(response) == "application/json")

  response_content <- rawToChar(httr::content(response,
                                              "raw"))

  json_response <- jsonlite::fromJSON(response_content)

  copyright <- NULL
  if ('copyright' %in% names(json_response)){
    content<-json_response[names(json_response)!='copyright']
    if(length(content) == 1) {
      content<-content[[1]]
    }
    copyright <- json_response$copyright
  } else if ('data' %in% names(json_response)){
    content<-json_response$data

  } else {
    content<-json_response
  }

  if(is.null(copyright)){
    copyright <- sprintf("NHL and the NHL Shield are registered trademarks of the National Hockey League. NHL and NHL team marks are the property of the NHL and its teams. \u00A9 NHL %s. All Rights Reserved.",
                         strftime(Sys.Date(), format = '%Y'))
  }

  #Return S3 object nhl_api.
  structure(
    list(
      data = content,
      path = query_wrapper,
      response = response,
      copyright = copyright
    ),
    class = "nhl_api"
  )
}


#' Get Copyright Statement
#'
#' @description return the copyright statement from the API calls
#'
#' @return The copyright statement from the API calls
#' @export
getCopyright <- function() {
  response <- getAward()$copyright
  return(response)
}

# Overload print when S3 object generated
print.nhl_api <- function(x, ...) {
  cat("<NHL ", x$path, ">\n", sep = "")
  utils::str(x$content)
  invisible(x)
}

#TODO: Handle this bug error:
#Sometimes happens for this call, but isn't call specific:
#getAllTimeRecordVsFranchise(franchiseName = "Philadelphia Flyers")
#
#Error in curl::curl_fetch_memory(url, handle = handle) :
#  LibreSSL SSL_read: SSL_ERROR_SYSCALL, errno 54
#8. curl::curl_fetch_memory(url, handle = handle)
#7. request_fetch.write_memory(req$output, req$url, handle)
#6. request_fetch(req$output, req$url, handle)
#5. request_perform(req, hu$handle$handle)
#4. httr::GET(call_url, ua) at nhlRapi.R#63
#3. baseAPI(call_url, query_wrapper, type = "record") at nhlRapi.R#50
#2. getRecordAPI(query = "all-time-record-vs-franchise", modifiers = modifiers) at franchises.R#253
#1. getAllTimeRecordVsFranchise(franchiseName = "Philadelphia Flyers")
#
