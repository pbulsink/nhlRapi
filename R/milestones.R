#' Get Milestones Records
#'
#' @description The NHL tracks a few milestones of public interest. This allows calling up the milestones achieved by plyaers. See the milestone parameter for milestones tracked.
#'
#' @param milestone Required, one of:
#' \itemize{
#'   \item \code{1000-point-career}
#'   \item \code{500-goal-career}
#'   \item \code{100-point-season}
#'   \item \code{50-goal-season}
#'   \item \code{5-goal-game}
#' }
#'
#' @return milestones from the API of a requested type
#' @export
#'
#' @examples
#' #see all 5 goal games:
#' five_goal_games <- getMilestone('5-goal-game')
getMilestone<-function(milestone){
  stopifnot(is.character(milestone))

  stopifnot(milestone %in% c('1000-point-career', '500-goal-career', '100-point-season', '50-goal-season', '5-goal-game'))

  query<-paste0('milestone-', milestone)

  return(getRecordAPI(query=query))
}
