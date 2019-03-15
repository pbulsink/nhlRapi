# Convenience Functions ---------------

# Get person info by name
# Searches prospects, players, officials for name

#' Get Season Schedule
#'
#' @description This function returns a nicely formattd season schedule dataframe including home and away teams, date & start time, venue information, and game code.
#'
#' @param season Season's schedule to pull up.
#'
#' @return a data frame
#' @export
#' @examples
#' \dontrun{
#' #See the 20182019 schedule:
#' schedule <- getSeasonSchedule(20182019)
#'
#' #See only preseason games from 20182019
#' schedule[schedule$gameType == 1, ]
#' }
#'
getSeasonSchedule<-function(season){
  stopifnot(length(season) == 1)
  stopifnot(is.numeric(season))
  stopifnot(validSeason(season))

  startyear <- as.numeric(substr(season, 1, 4))

  sched <- getSchedule(startDate = paste0(startyear, "-09-01"),
                          endDate = paste0(startyear+1, "-07-31"))

  if(class(sched) != 'nhl_api'){
    stop("Unknown error in downloding schedule.")
  }

  schedule<-data.frame(date = character(),
                       gamePk = integer(),
                       link = character(),
                       gameType = character(),
                       gameDate = character(),
                       teams.home.team.name = character(),
                       teams.home.team.id = integer(),
                       teams.away.team.name = character(),
                       teams.away.team.id = integer(),
                       venue.name = character(),
                       venue.id = numeric(),
                       status.detailedState = character()
                       )

  for (i in 1:nrow(sched$data$dates)){
    gameDate <- sched$data$dates[i,]
    date <- gameDate$date
    games <- jsonlite::flatten(gameDate$games[[1]])

    games$date <- date
    if(!"venue.id" %in% colnames(games)){
      games$venue.id <- NA
    }
    games<-subset(games, select = c(date, gamePk, link, gameType, gameDate, teams.home.team.name, teams.home.team.id, teams.away.team.name, teams.away.team.id, venue.name, venue.id, status.detailedState))
    schedule<-rbind(schedule, games)
  }

  colnames(schedule) <- c("Date", "gameId", "gameLink", "gameType", "gameStartDateTime", "homeTeamName", "homeTeamId", "awayTeamName", "awayTeamId", "venueName", "venueId", "gameStatus")

  schedule$gameType <- as.numeric(ifelse(schedule$gameType == "PR", 1,
                                  ifelse(schedule$gameType == 'R', 2,
                                  ifelse(schedule$gameType == 'P', 3, 4))))

  return(schedule)
}


#' Get Season Scores
#'
#' @description Gets season scores (or scores for all games in a schedule), including OT & SO status, shots, goals, and shootout attempts & goals if applicable
#'
#' @param season Season's scores to get. Ignored if schedule provided, otherwise gets schedule from \code{getSeasonSchedule()}.
#' @param schedule Optional, if season provided. Season schedule from \code{getSeasonSchedule()}.
#' @param progress_bar Optional, logical, if progress bar as scores are retrieved.
#'
#' @return a data frame
#' @export
#'
#' @seealso getSeasonSchedule
getSeasonScores<-function(season = NULL, schedule = NULL, progress_bar = TRUE){
  if(!is.null(season) & is.null(schedule)){
    message('Retrieving schedule for ', season)
    schedule<-getSeasonSchedule(season)
  } else if(is.null(season) & is.null(schedule)){
    stop("Must provide season or schedule.")
  }

  stopifnot(colnames(schedule) == c("Date", "gameId", "gameLink", "gameType", "gameStartDateTime", "homeTeamName", "homeTeamId", "awayTeamName", "awayTeamId", "venueName", "venueId"))

  scores<-schedule

  scores[,c('gameType, venueName, venueID')] <- NULL

  if(progress_bar){
    pb<-dplyr::progress_estimated(n = nrow(scores[scores$Date <= Sys.Date() + 1, ]))
    pb$print()
  }

  scores$homeGoals<-NA
  scores$homeShots<-NA
  scores$awayGoals<-NA
  scores$awayShots<-NA
  scores$OT<-NA
  scores$SO<-NA
  scores$homeSOAttempts<-NA
  scores$homeSOGoals<-NA
  scores$awaySOAttempts<-NA
  scores$awaySOGoals<-NA

  for(game in 1:nrow(scores[scores$Date <= Sys.Date() + 1, ])){
    linescore<-getGameLinescore(scores[game, 'gameId'])
    if(class(linescore) != 'nhl_api'){
      stop("Error downloading score(s) for date ", scores$Date[i], ".")
    }
    linescore<-linescore$data
    if(linescore$currentPeriod != 0){
      scores[game, 'homeGoals'] <- linescore$teams$home$goals
      scores[game, 'homeShots'] <- linescore$teams$home$shotsOnGoal
      scores[game, 'awayGoals'] <- linescore$teams$away$goals
      scores[game, 'awayShots'] <- linescore$teams$away$shotsOnGoal
      scores[game, 'OT'] <- 'OVERTIME' %in% linescore$periods$periodType
      scores[game, 'SO'] <- as.logical(linescore$hasShootout)
      if(as.logical(linescore$hasShootout)){
        scores[game, 'homeSOAttempts'] <- linescore$shootoutInfo$home$attempts
        scores[game, 'homeSOGoals']    <- linescore$shootoutInfo$home$scores
        scores[game, 'awaySOAttempts'] <- linescore$shootoutInfo$away$attempts
        scores[game, 'awaySOGoals']    <- linescore$shootoutInfo$away$scores
      }
    }

    Sys.sleep(1)
    if(progress_bar){
      pb$tick()$print()
    }
  }

  return(scores)
}
