#' Query Builder
#'
#' @description Generic wrapper to build querys using paste0 collapsing on '/'
#'
#' @param ... all items to collapse to one query
#'
#' @return a string query of .../...
#' @export
#' @keywords internal
querybuilder<-function(...) {
  query<-list(...)
  return(paste0(query, collapse = "/"))
}
