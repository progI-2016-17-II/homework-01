# 1. feladat

## Házi feladat 1
## Programozás I.
## 2016/17. II. félév
## Szilágyi Ádám
## 2017.02.28

# 1. feladat kész (fejléc + commitolás)

# 2. feladat  Package installálása, behívása
install.packages("fivethirtyeight")
library(fivethirtyeight)
data(package="fivethirtyeight")

#data-set beolvasása
data(fivethirtyeight$tarantino)

#Bekerülési év beírása
tarantino$year <- 0

tarantino$year[tarantino$movie == "Reservoir Dogs"] <- 1992

## Legkorábban
tarantino$movie[which.min(tarantino$minutes_in)]
tarantino$word[which.min(tarantino$minutes_in)]
tarantino$minutes_in[which.min(tarantino$minutes_in)]

## Leggyakoribb szitokszó
tarantino[1,1:5]
countwords <-summary(as.factor(tarantino$word))
sort(countwords, decreasing=TRUE)[1]

## Shitless
tarantino$movie[which(tarantino$word =="shitless")]

## Szó hiányos adat
which(is.na(tarantino$word)) #sor
tarantino[which(is.na(tarantino$word)),] 
(tarantino[which(is.na(tarantino$word)),])

length(which(is.na(tarantino$word))) #ezajó


## Milyen típusúak
class(tarantino$word)
tarantino$word = as.factor(tarantino$word)

class(tarantino$movie)
tarantino$movie = as.factor(tarantino$movie)

## Leggyakoribb 3 szó
sort(countwords, decreasing=TRUE)[1:3]

elsleggyak <- subset(tarantino, tarantino$word == "fucking")
masleggyak <- subset(tarantino, tarantino$word == "shit")
harleggyak <- subset(tarantino, tarantino$word == "fuck")

topszavak <- rbind(elsleggyak, masleggyak, harleggyak)

rm(elsleggyak, masleggyak, harleggyak)

## 10. feladat

levels(prtopszavak$word)

topszavak$word <- droplevels(topszavak$word)
levels(topszavak$word)

table(topszavak$movie, topszavak$word)

## Nézd meg, melyik filmben hány halál történt és hány szitokszó hangzott el!
##Volt olyan film, ahol több halál volt, mint szitkozódás?

table(tarantino$movie, tarantino$profane)

#Ellenőrzöm a profane típusát, majd átírom numericre.
class(tarantino$profane)
tarantino$profane = as.numeric(tarantino$profane) 
is.numeric(tarantino$profane)

 #Felcímkézem
tarantino$profane <- factor(tarantino$profane,
                            levels = c(0,1),
                            labels = c("halal", "szitokszo")
                            )
 #Kereszttábla
table(tarantino$movie, tarantino$profane)

 #Van-e olyan, ahol több a halál, mint a szitokszó? 
#M: Kill Bill: Vol. 1

## Fájlok kiírása 11. fel.

write.table(tarantino, file = "data/tarantino.tsv", sep = "\t", row.names = F, fileEncoding = "utf-8")

## TSV olvasása, majd törlése

tarantinotsv <- read.table(file = "data/tarantino.tsv", header = T, sep = "\t", dec = ".", fileEncoding = "utf-8")

rm(tarantinotsv)

