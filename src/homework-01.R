#
#                    Házi feladat 1     
#                    Programozás I.     
#                  2016/17. II. félév 
#                     Farsang Bence      
#                      2017.02.26
#
#------------------------------------------------------
#                       I.feladat #
#------------------------------------------------------

# clear console & environment
cat("\014")    
rm(list=ls(all=TRUE))


#------------------------------------------------------
#                       II.feladat #
#------------------------------------------------------
#------------------------------------------------------
# 1.
#------------------------------------------------------

# package telepítés, ha még nincs telepítve
# install.packages('fivethirtyeight')

# package behívása
library(fivethirtyeight)

#------------------------------------------------------
# 2.
#------------------------------------------------------

# adat megnyitása
data(package ="fivethirtyeight")
data(tarantino)
head(tarantino)


#------------------------------------------------------
# 3.
#------------------------------------------------------

# memória pre-allokáció

tarantino$year <- c(0)

# feltöltés az évekkel az adott filmek esetén

tarantino$year[which(tarantino$movie == "Reservoir Dogs")]      <-  1992
tarantino$year[which(tarantino$movie == "Pulp Fiction")]        <-  1994
tarantino$year[which(tarantino$movie == "Kill Bill: Vol. 1")]   <-   2003
tarantino$year[which(tarantino$movie == "Kill Bill: Vol. 2")]   <- 	2004
tarantino$year[which(tarantino$movie == "Jackie Brown")]        <- 	1997
tarantino$year[which(tarantino$movie == "Inglorious Basterds")] <- 	2009
tarantino$year[which(tarantino$movie == "Django Unchained")]    <- 	2012

#------------------------------------------------------
# 4.
#------------------------------------------------------

# filmcím, amely a legkorábban elhangzott szitokszóhoz tartozik
tarantino$movie[which(tarantino$minutes_in == min(tarantino$minutes_in))]

# legkorábban elhangzott szitokszóhoz ideje
min(tarantino$minutes_in)

#------------------------------------------------------
# 5.
#------------------------------------------------------

# a leggyakrabban elhangzott szitokszó és annak gyakorisága
sort(table(tarantino$word), decreasing = TRUE)[1]

# a szitokszavak gyakoriság szerint csökkenő sorrendben
sort(table(tarantino$word), decreasing = TRUE)

#------------------------------------------------------
# 6.
#------------------------------------------------------

# shitless szitokszóhoz tartozó film
tarantino$movie[which( tarantino$word == 'shitless')]

#------------------------------------------------------
# 7.
#------------------------------------------------------

# ezekben a sorokban a szó hiányos adat
which(is.na(tarantino$word) == TRUE)

# összeses hiányos adat a word-ben
length(which(is.na(tarantino$word) == TRUE))

#------------------------------------------------------
# 8.
#------------------------------------------------------

# a változó típusa
typeof(tarantino$movie)
typeof(tarantino$word)

# factor-rá konvertálás
tarantino$movie <- factor(tarantino$movie)
tarantino$word  <- factor(tarantino$word)

#------------------------------------------------------
# 9.
#------------------------------------------------------

# 3 leggyakoribb szó
print(sort(table(tarantino$word), decreasing = TRUE)[1:3])

# leszűrés
tarantino_b <- tarantino[tarantino$word %in% c("fucking", "shit", "fuck"),]

#------------------------------------------------------
# 10.
#------------------------------------------------------

# a filmek és a 3 leggyakoribb szó kereszttáblája
table(tarantino_b$movie, droplevels(tarantino_b)$word)

#------------------------------------------------------
# 11.
#------------------------------------------------------

#  hány halál történt és hány szitokszó hangzott el
tarantino$profane[which(tarantino$profane == 1)]      <-  'word'
tarantino$profane[which(tarantino$profane == 0)]      <-  'death'
table(tarantino$movie, tarantino$profane)


# Volt-e olyan film, ahol több halál volt, mint szitkozódás?
z<-table(tarantino$movie, tarantino$profane)
print("Volt-e olyan film, ahol több halál volt, mint szitkozódás?")
print(TRUE %in% (z[1:7]>z[8:14]))

#------------------------------------------------------
# 12.
#------------------------------------------------------

# .tsv kiírása

write.table(
  tarantino,
  file = "data/tarantino.tsv",
  sep = "\t",
  row.names = F,
  fileEncoding = "utf-8"
)

#------------------------------------------------------
# 13.
#------------------------------------------------------

# .tsv beolvasása

tarantino2 <-
  read.delim2(
    file = "data/tarantino.tsv",
    header = T,
    sep = "\t",
    dec = ".",
    fileEncoding = "UTF-8",
    colClasses=c("character","factor")
  )

# törlés

rm(tarantino2)