# Házi feladat 1
# Programozás I.
# 2016/17. II. félév
# Hering András
# 2017.02.25-26


if (!("fivethirtyeight" %in% installed.packages())){
  install.packages("fivethirtyeight")
}
library(fivethirtyeight)
data(package = "fivethirtyeight")




for (i in 1:nrow(tarantino)) {
  if      (tarantino[i,1] == "Reservoir Dogs")     {tarantino [i,5] <- "1992"}
  else if (tarantino[i,1] == "Pulp Fiction")       {tarantino [i,5] <- "1994"}
  else if (tarantino[i,1] == "Kill Bill: Vol. 1")  {tarantino [i,5] <- "2003"}
  else if (tarantino[i,1] == "Kill Bill: Vol. 2")  {tarantino [i,5] <- "2004"}
  else if (tarantino[i,1] == "Jackie Brown")       {tarantino [i,5] <- "1997"}
  else if (tarantino[i,1] == "Inglorious Basterds"){tarantino [i,5] <- "2009"}
  else if (tarantino[i,1] == "Django Unchained")   {tarantino [i,5] <- "2012"}
}
colnames(tarantino)[5] <- "year"



print(tarantino[which.min(subset(tarantino, tarantino$profane == TRUE)$minutes_in),c(3,4)])




print(which.max(table(tarantino$word)))
sort(table(tarantino$word), decreasing = TRUE)




subset(tarantino, tarantino$word == "shitless")




subset(tarantino, is.na(tarantino$word))
subset(tarantino, tarantino$profane == FALSE)
nrow(subset(tarantino, tarantino$profane == FALSE))
nrow(subset(tarantino, is.na(tarantino$word)))



class(tarantino$movie)
class(tarantino$word)
tarantino$movie <- as.factor(tarantino$movie)
tarantino$word  <- as.factor(tarantino$word)
class(tarantino$movie)
class(tarantino$word)

proftable <-sort(table(tarantino$word), decreasing = TRUE)
proftable <- as.data.frame(proftable)
szurttarantino<-subset(tarantino, tarantino$word == proftable$Var1[c(1:3)])
# nem értem pontosan, miért enged egyet vagy kettőt, de háromnál már warningot ad



table(szurttarantino$movie,szurttarantino$word)

table(tarantino$movie,tarantino$profane)
table(tarantino$movie,tarantino$profane)[,1]>table(tarantino$movie,tarantino$profane)[,2]
