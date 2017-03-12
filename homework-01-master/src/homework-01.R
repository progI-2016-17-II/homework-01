#####################
#Házi feladat 1     #
#Programozás I.     #
#2016/17. II. félév #
#Kelemen Kinga      #
#2017-02-25         #
#####################
# ----II. feladat--------------------------------------
#1.feladat
#A fivethirtyeight nevű package installálása és behívása

if (!("fivethirtyeight" %in% installed.packages())) {
  install.packages("fivethirtyeight")
}

library(fivethirtyeight)

#2.feladat
#Az leírásnak megfelelő dataset megkeresése és beolvasása 

data()

data(tarantino)
head(tarantino)

#3.feladat
#Egy új year nevű oszlop létrehozása
attach(tarantino)
tarantino$year[movie=="Reservoir Dogs"] <- as.numeric(1992)
tarantino$year[movie=="Pulp Fiction"] <- as.numeric(1994)
tarantino$year[movie=="Kill Bill: Vol. 1"] <- as.numeric(2003)
tarantino$year[movie=="Kill Bill: Vol. 2"] <- as.numeric(2004)
tarantino$year[movie=="Jackie Brown"] <- as.numeric(1997)
tarantino$year[movie=="Inglorious Basterds"] <- as.numeric(2009)
tarantino$year[movie=="Django Unchained"] <- as.numeric(2012)


#4.feladat
#A tarantino adathalmaz leszűrése azokra, ahol szitokszó van (profane=true).

mytarantino <- subset(tarantino, profane=="TRUE")

# Melyik filmben hangzott el legkorábban szitokszó?

mytarantino$movie[which.min(mytarantino$minutes_in)]

# Melyik szó ez?

mytarantino$word[which.min(mytarantino$minutes_in)]

#Hányadik percben? Integert használva, hogy egész szám legyen.

as.integer(mytarantino$minutes_in[which.min(mytarantino$minutes_in)])

#5.feladat
#leggyakoribb szitokszó

sort(table(mytarantino$word), decreasing = T)
names(sort(table(mytarantino$word), decreasing = T))[1]

#6.feladat
#Melyik filmben hangzott el a shitless szó?

shitless <- subset(mytarantino, word == "shitless")
shitless$movie

#7.feladat
#Azoknak a soroknak a száma, ahol a word oszlopban hiányos az adat.

hiany <- subset(tarantino, is.na(word)==TRUE)
nrow(hiany)

#8.feladat
#A word és movie adattípusai, majd factorrá alakítása.

class(tarantino$movie)
class(tarantino$word)

movie <- as.factor(movie)
word <- as.factor(word)

#9.feladat
#3 leggyakoribb szóhoz tartozó sorok.

leggyakoribb <- names(sort(table(mytarantino$word), decreasing = T))[1:3]
leggyakoribbak <- subset(tarantino, word == leggyakoribb)

#10.feladat
#3 leggyakoribb szó kereszttáblája.

table(leggyakoribbak$movie, leggyakoribbak$word)

#vagy

table(leggyakoribbak)
table(droplevels(leggyakoribbak)$word)

#11.feladat
#Melyik filmben hány halál és hány szitokszó volt?

halalok <- subset(tarantino, profane=="FALSE")
table(halalok$movie)

szitokszavak <- subset(tarantino, profane=="TRUE")
table(szitokszavak$movie)

#Az a film, ahol több halál volt, mint szitkozódás

which(table(halalok$movie)>table(szitokszavak$movie))

#12.feladat
#tarantino tvs formátumba való kiíratása

write.table(
  tarantino,
  file = "data/tarantino.tsv",
  sep = "\t",
  row.names = F,
  fileEncoding = "utf-8"
)

#13. feladat
#Kiírt tvs beolvasása.

tarantino2 <-
  read.table(
    file = "data/tarantino.tsv",
    header = T,
    sep = "\t",
    dec = ".",
    fileEncoding = "utf-8"
  )
rm(tarantino2)