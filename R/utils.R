#' Query Builder
#'
#' @description Generic wrapper to build querys using paste0 collapsing on '/'
#'
#' @param ... all items to collapse to one query
#'
#' @return a string query of .../...
#' @export
#' @keywords internal
querybuilder <- function(...) {
  query <- list(...)
  return(paste0(query, collapse = "/"))
}

validSeason <- function(season) {
  year <- substr(getSeasonAtDate(), 1, 4)
  seasons <- c(1920:year)
  seasons <- as.numeric(paste0(seasons, seasons +
    1))
  return(season %in% seasons)
}

getSeasonAtDate <- function(date = Sys.Date()) {
  stopifnot(length(date) == 1)
  date <- as.Date(date)
  if (as.numeric(strftime(date, "%m")) < 8) {
    year <- as.numeric(strftime(date, "%Y")) -
      1
  } else {
    year <- as.numeric(strftime(date, "%Y"))
  }
  return(as.numeric(paste0(year, year + 1)))
}

validateGameCode <- function(game_code) {
  # YYYYNNGGGG YYYY = Year (2018 for 20182019
  # season) NN = Game Type 01=preseason,
  # 02=regular season, 03=postseason, 04=allstar
  # GGGG = Game number. 0001 to 1271 for regular
  # season,
  # 0[round1-4][series1-8,1-4,1-2,1][game1-7] for
  # playoffs

  yearregex <- "[1-2][0,9][0-9][0-9]"
  typeregex <- "0[1-4]"
  # playoffregex<-'0[1-4][1-8][1-7]'
  gameregex <- "[0-1][0-9][0-9][0-9]"

  totalregex <- paste0(yearregex, typeregex,
    gameregex)
  return(grepl(pattern = totalregex, x = game_code))
}

validateFromTimeCode <- function(time_code) {
  # yyyymmdd_hhmmss

  dateregex <- "[1-2][0,9][0-9][0-9][0,1][0-9][0-3][0-9]"
  timeregex <- "[0-2][0-9][0-5][0-9][0-5][0-9]"

  totalregex <- paste0(dateregex, "_", timeregex)
  return(grepl(pattern = totalregex, x = time_code))
}
