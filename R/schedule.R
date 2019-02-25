#' Get Schedule
#'
#' @description Get the NHL schedule for a team, a date (range) or with additional information.
#' @param team Specific team's schedule to retrieve. optional, numeric
#' @param startDate A single date or a date range may be entered, optional, must be coercable with as.Date()
#' @param endDate If a date range is requested, the end date. For a single date, this may be left out.
#' @param scheduleType additional schedule information may be requested:
#'  - broadcasts - show a list of broadcasts for the game(s)
#'  - linescore - show a linescore for completed game(s)
#'  - ticket - show different ticket purchase options for upcoming game(s)
#'
#' @return The API output of schedules
#' @export
getSchedule <- function(team = NULL, startDate = NULL, endDate = NULL, scheduleType = NULL) {
  modifier<-NULL

  if(!is.null(team)){
    stopifnot(is.numeric(team))
    modifier <- c(modifier, paste0('teamId=', team))
  }

  if(!is.null(scheduleType)){
    stopifnot(length(scheduleType) == 1)
    stopifnot(scheduleType %in% c('broadcasts', 'linescore', 'ticket'))
    modifier <- c(modifier, paste0('expand=schedule.', scheduleType))
  }

  if(!is.null(endDate)){
    stopifnot(!is.null(startDate))
    startDate<-as.Date(startDate)
    endDate<-as.Date(endDate)
    stopifnot(endDate > startDate)
    modifier <- c(modifier, paste0('startDate=', strftime(startDate, '%Y-%m-%d')))
    modifier <- c(modifier, paste0('endDate=', strftime(endDate, '%Y-%m-%d')))
  } else if (!is.null(startDate)){
    startDate<-as.Date(startDate)
    modifier <- c(modifier, paste0('date=', strftime(startDate, '%Y-%m-%d')))
  }

  query <- 'schedule'

  return(getAPI(query = query, modifiers = modifier))
}
