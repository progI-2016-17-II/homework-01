# Házi feladat 1
# Programozás I.
# 2016/17. II. félév
# Hering András
# 2017.02.25-26

# 2. feladat
#   2/1 package letöltés

if (!("fivethirtyeight" %in% installed.packages())){
  install.packages("fivethirtyeight")
}
library(fivethirtyeight)

#   2/2 dataset keresés

data(package = "fivethirtyeight")
# "tarantino" a keresett dataset

#   2/3 year oszlop bevezetés megfelelő adatokkal

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

#   2/4 legkorábbi szitokszó

tarantino[which.min(subset(tarantino, tarantino$profane == TRUE)$minutes_in),
          c(1,3,4)]
# profane == true-ra szűrni nem életbevágó

#   2/5 leggyakoribb szitokszó, csökkenő sorrend gyakoriság szerint

which.max(table(tarantino$word))
# a szám nem csinál semmit
sort(table(tarantino$word), decreasing = TRUE)

#   2/6 shitless hol fordul elő

subset( tarantino , tarantino$word == "shitless")

#   2/7 hiányos adatok

subset(tarantino, is.na(tarantino$word))
subset(tarantino, tarantino$profane == FALSE)
#ugyanaz az eredmény, mivel minden, ami nem profanitás, az halál
# subset(tarantino, is.na(tarantino$word)) == 
#subset(tarantino, tarantino$profane == FALSE)

nrow(subset(tarantino, tarantino$profane == FALSE))
nrow(subset(tarantino, is.na(tarantino$word)))

#   2/8 adattípusok

class(tarantino$movie)
class(tarantino$word)
# eddig character
tarantino$movie <- as.factor(tarantino$movie)
tarantino$word  <- as.factor(tarantino$word)
class(tarantino$movie)
class(tarantino$word)
# factor lett

#   2/9 szűrés top3 káromkodásra

proftable <-sort(table(tarantino$word), decreasing = TRUE)
proftable <- as.data.frame(proftable) #segéd df
proftable$Var1  <- as.factor(proftable$Var1)
szurttarantino<-subset(tarantino, tarantino$word == proftable$Var1[c(1:3)])
#nem értem pontosan, miért enged egyet vagy kettőt, de háromnál már warningot ad

#   2/10 film x top3 szitokszó

szurttarantino$word <- droplevels(szurttarantino$word,
                                  szurttarantino$word != proftable$Var1[c(1:3)] )
table(szurttarantino$movie,szurttarantino$word)

#   2/11 film x profán-e

table(tarantino$movie,tarantino$profane)
# TRUE = szitokszó, FALSE = halál
table(tarantino$movie,tarantino$profane)[,1]>
  table(tarantino$movie,tarantino$profane)[,2]
#Kill Bill: Vol. 1 a válasz

#   2/12 tsv írás
write.table(tarantino, file = "data/tarantino.tsv", sep = "\t", row.names = F,
            fileEncoding = "utf-8")

#   2/13 tsv olvas, töröl

tarantino2 <- read.table(file = "data/tarantino.tsv", header = T, sep = "\t",
                         dec = ".", fileEncoding = "utf-8")
remove(tarantino2)
