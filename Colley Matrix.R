data = data.frame(list(character(), character(), numeric(), character(), numeric(), character()))
names(data) = c("date", "away_team", "away_score", "home_team", "home_score", "location")

y = list()
  for (i in 1960:2010){
    y[[i]] = read.fwf(paste("http://homepages.cae.wisc.edu/~dwilson/rsfc/history/howell/cf",i,"gms.txt",sep=""), width = c(11, 28, 3, 29, 3, 20)) 
  }
data = rbind.data.frame(y[[1960]],y[[1961]],y[[1962]],y[[1963]],y[[1964]],y[[1965]],y[[1966]],y[[1967]],y[[1968]],y[[1969]],y[[1970]],y[[1971]],y[[1972]],y[[1973]],y[[1974]],y[[1975]],y[[1976]],y[[1977]],y[[1978]],y[[1979]],y[[1980]],y[[1981]],y[[1982]],y[[1983]],y[[1984]],y[[1985]],y[[1986]],y[[1987]],y[[1988]],y[[1989]],y[[1990]],y[[1991]],y[[1992]],y[[1993]],y[[1994]],y[[1995]],y[[1996]],y[[1997]],y[[1998]],y[[1999]],y[[2000]],y[[2001]],y[[2002]],y[[2003]],y[[2004]],y[[2005]],y[[2006]],y[[2007]],y[[2008]],y[[2009]],y[[2010]])

#data = rbind.data.frame(for(i in 1960:2010){(paste0(,y[[i]],","))})

names(data) = c("date", "away_team", "away_score", "home_team", "home_score", "location")

data$season = as.numeric(substr(data$date,7,10))
data$month = as.numeric(substr(data$date,1,2))

for(i in 1:length(data$date)){if(data$month[[i]] < 3){data$season[[i]] = data$season[[i]] - 1}}
for(i in 1:length(data$date)){if(data$away_score[[i]] < data$home_score[[i]]){data$winner[[i]] = as.character(paste(data$season[[i]],data$home_team[[i]],sep = ""))}}
for(i in 1:length(data$date)){if(data$away_score[[i]] > data$home_score[[i]]){data$winner[[i]] = as.character(paste(data$season[[i]],data$away_team[[i]],sep = " "))}}
for(i in 1:length(data$date)){if(data$away_score[[i]] == data$home_score[[i]]){data$winner[[i]] = as.character("NULL")}}
for(i in 1:length(data$date)){if(data$away_score[[i]] == data$home_score[[i]]){data$loser[[i]] = as.character("NULL")}}
for(i in 1:length(data$date)){if(data$away_score[[i]] < data$home_score[[i]]){data$loser[[i]] = as.character(paste(data$season[[i]],data$away_team[[i]],sep = " "))}}
for(i in 1:length(data$date)){if(data$away_score[[i]] > data$home_score[[i]]){data$loser[[i]] = as.character(paste(data$season[[i]],data$home_team[[i]],sep = ""))}}
for(i in 1:length(data$date)){data$AWAY[[i]] = as.character(paste(data$season[[i]],data$away_team[[i]],sep = " "))}
for(i in 1:length(data$date)){data$HOME[[i]] = as.character(paste(data$season[[i]],data$home_team[[i]],sep = ""))}
for(i in 1:length(data$date)){if(data$away_score[[i]] == data$home_score[[i]]){data$loser[[i]] = as.character("NULL")}}

df = data.frame(factor(8572),numeric(8572),numeric(8572),numeric(8572))
names(df) = c("Teams", "Wins", "Losses", "Games")

a = as.vector(rbind(data$HOME,data$AWAY))
df$Teams = unique(a)

df$Games = 0
for(i in 1:length(df$Teams)){
  for(j in 1:71906){
    if(df$Teams[[i]] == a[[j]]){
      df$Games[[i]] = df$Games[[i]] +1
    }
  }
}

for(i in 1:6060){
if(df$Games < 6){
    df = df[-i,]
  }
}

df$Wins = 0
df$Losses = 0
for(i in 1:6060){
  for(j in 1:length(data$date)){
    if(df$Teams[[i]] == data$winner[[j]]){
      df$Wins[[i]] = df$Wins[[i]] +1
      df$Opponents[[i]] = c(df$Opponents[[i]] , which(df$Teams == as.factor(data$loser[[j]])))
    }
    if(df$Teams[[i]] == data$loser[[j]]){
      df$Losses[[i]] = df$Losses[[i]] + 1
      df$Opponents[[i]] = c(df$Opponents[[i]] , which(df$Teams == as.factor(data$winner[[j]])))
    }
  }
}


A = matrix(diag(2+(df$Losses+df$Wins)), nrow=6060)
for(i in 1:6060){
  for(j in 1:6060){
    if(j %in% (df$Opponents)[[i]]){
      A[i,j] = -1*length(which(j == df$Opponents[[i]][]))
    }
  }
}


b= matrix(1 + (df$Wins - df$Losses)/2,nrow = 6060)


C = solve(A,b)

solution = data.frame(df$Teams,C)
solution = solution[order(-solution$C),]

year = function(x){
  for(i in 1:length(solution$df.Teams)){
    if(as.factor(" x.*") =! solution$df.teams[[i]]){
      solution = solution[-i,]
    }
    return(solution$df.Teams)
  }
}


