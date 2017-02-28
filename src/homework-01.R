### I. feladat: Fejléckészítés
## Házi feladat 1
## Programozás I.
## 2016/17. II. félév
## Szilágyi Ádám
## 2017.02.28

### I. feladat: kész

###II. feladat
#II.1 feladat: Package installálása, behívása

install.packages("fivethirtyeight")
library(fivethirtyeight)
data(package = "fivethirtyeight")
#II.1 feladat: kész

#II.2 feladat: Beolvasni a tarantino datasetet

data(fivethirtyeight$tarantino)
#II.2 feladat: kész


#II.3 feladat: Mozikba kerülés évének beírása

tarantino$year <- "evszam"

tarantino$year[tarantino$movie == "Reservoir Dogs"] <- 1992
tarantino$year[tarantino$movie == "Kill Bill: Vol. 1"] <- 2003
tarantino$year[tarantino$movie == "Kill Bill: Vol. 2"] <- 2004
tarantino$year[tarantino$movie == "Jackie Brown"] <- 1997
tarantino$year[tarantino$movie == "Inglorious Basterds"] <- 2009
tarantino$year[tarantino$movie == "Django Unchained"] <- 2012
#II.3 feladat: kész


#II.4 feladat: Melyik filmben? - szitokszó legkorábban

tarantino$movie[which.min(tarantino$minutes_in)] #Melyik film?

tarantino$word[which.min(tarantino$minutes_in)] #Melyik szó?

tarantino$minutes_in[which.min(tarantino$minutes_in)] #Hanyadik percben?
#II.4 feladat: kész


#II.5 feladat: Leggyakoribb szitokszó

countwords <- summary(as.factor(tarantino$word))

sort(countwords, decreasing = TRUE)[1]
#II.5 feladat: kész


#II.6 feladat: Melyik filmben - shitless?

tarantino$movie[which(tarantino$word == "shitless")]
#II.6 feladat: kész


#II.7 feladat: Hiányzó adatokat tartalmazó sorok, darabszám

tarantino[which(is.na(tarantino$word)), ] #sorok adattal

length(which(is.na(tarantino$word))) # Hány darab?
#II.7 feladat: kész


#II.8 feladat: Adattípus megállapítása (word, movie), átalakítás

class(tarantino$word) #adattípus
tarantino$word = as.factor(tarantino$word) #átalakítás

class(tarantino$movie) #adattípus
tarantino$movie = as.factor(tarantino$movie) #átalakítás
#II.8 feladat: kész


#II.9 Szűrés a leggyakoribb 3 szóhoz tartozó sorokra

sort(countwords, decreasing = TRUE)[1:3] # top3 szó

elsleggyak <- subset(tarantino, tarantino$word == "fucking")
masleggyak <- subset(tarantino, tarantino$word == "shit")
harleggyak <- subset(tarantino, tarantino$word == "fuck")

topszavak <- rbind(elsleggyak, masleggyak, harleggyak) #összekapcsolás

rm(elsleggyak, masleggyak, harleggyak) #felesleges subsetek törlése
#II.9 feladat: kész


#II.10 feladat: Kereszttábla a top3 szóval és a filmekkel

help("table")
help("droplevels")

levels(prtopszavak$word) #jelenlegi faktorszint

topszavak$word <- droplevels(topszavak$word) #módisított faktoszint

levels(topszavak$word) #eredmény ell.

table(topszavak$movie, topszavak$word) #kereszttábla
#II.10 feladat: kész


#II.11 feladat:

table(tarantino$movie, tarantino$profane)

#Ellenőrzöm a profane típusát, majd átírom numericre.
class(tarantino$profane)
tarantino$profane = as.numeric(tarantino$profane)
is.numeric(tarantino$profane)

#Felcímkézem
tarantino$profane <- factor(
  tarantino$profane,
  levels = c(0, 1),
  labels = c("halal", "szitokszo")
)
#Kereszttábla
table(tarantino$movie, tarantino$profane)

#Van-e olyan, ahol több a halál, mint a szitokszó?
#M: Kill Bill: Vol. 1

## Fájlok kiírása 11. fel.

write.table(
  tarantino,
  file = "data/tarantino.tsv",
  sep = "\t",
  row.names = F,
  fileEncoding = "utf-8"
)

## TSV olvasása, majd törlése

tarantinotsv <-
  read.table(
    file = "data/tarantino.tsv",
    header = T,
    sep = "\t",
    dec = ".",
    fileEncoding = "utf-8"
  )

rm(tarantinotsv)
