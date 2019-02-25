#' Get Milestones Records
#'
#' @param milestone Required, one of:
#'   - 1000-point-career
#'   - 500-goal-career
#'   - 100-point-season
#'   - 50-goal-season
#'   - 5-goal-game
#'
#' @return milestones from the API
#' @export
getMilestone<-function(milestone){
  stopifnot(is.character(milestone))

  stopifnot(milestone %in% c('1000-point-career', '500-goal-career', '100-point-season', '50-goal-season', '5-goal-game'))

  query<-paste0('milestone-', milestone)

  return(getRecordAPI(query=query))
}
