#Play By Play

#getGamePBP<-function(season=20172018, gcode=20001){paste("http://www.nhl.com/scores/htmlreports/",season,"/PL0",gcode,".HTM",sep="")}

#getGameEventSummary<-function(season=20172018, gcode=20001){paste("http://www.nhl.com/scores/htmlreports/",season,"/ES0",gcode,".HTM",sep="")}

#getGameEventLocation<-function(season=20172018, gcode=20001){cat(paste0("http://live.nhl.com/GameData/",season,"/",substr(season,1,4),"0",gcode,"/PlayByPlay.json"))} # OR see live feed getGameFeed()

#getGameShifts<-function(season=20172018, gcode=20001){paste("http://www.nhl.com/scores/htmlreports/",season,"/TV0",gcode,".HTM",sep="")} or http://www.nhl.com/stats/rest/shiftcharts?cayenneExp=gameId=2010020001

