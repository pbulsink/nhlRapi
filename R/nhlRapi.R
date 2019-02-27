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
    query_wrapper <- paste(query, paste0(modifiers,
                                         collapse = "%20and%20"), sep = "?")
  }

  call_url <- paste0(base_uri, query_wrapper)
  return(baseAPI(call_url, query_wrapper, type = 'record'))
}

#' Ultimate BASE api call.
#'
#' @param call_url the generated url to get
#' @param query specific query to api endpoint
#' @param type stat or record, for S3 generation
#'
#' @return json response
baseAPI<-function(call_url, query_wrapper, type){
  ua <- httr::user_agent("http://github.com/pbulsink/nhlRapi")

  response <- httr::GET(call_url, ua)

  # Stop if not 200 ((OK)) returned
  httr::stop_for_status(response)

  # Stops if not json returned.
  stopifnot(httr::http_type(response) == "application/json")

  response_content <- rawToChar(httr::content(response,
                                              "raw"))

  json_response <- jsonlite::fromJSON(response_content)

  #TODO: return S3. Need to rewrite tests?
  # structure(
  #   list(
  #     content = json_response,
  #     path = query_wrapper,
  #     response = resp,
  #     copywrite = json_response$copyright
  #   ),
  #   class = "nhl_api"
  # )

  return(json_response)
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

#TODO: Overload print when S3 object generated
# print.nhl_api <- function(x, ...) {
#   cat("<NHL ", x$path, ">\n", sep = "")
#   str(x$content)
#   invisible(x)
# }

