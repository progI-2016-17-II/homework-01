#########################
#                       #
#     Házi feladat 1    #
#     Programozás I.    #
#   2016/17. II. félév  #
#                       #
#     Verba Zoltán      #
#      2016-02-22       #
#                       #
#########################

# II. feladat

# 1. A "fivethirtyeight" package installálása és behívása

install.packages("fivethirtyeight")
require(fivethirtyeight)

################################################################################
################################################################################

# 2. Dataset keresése és beolvasása

data(package = "fivethirtyeight")
data(tarantino)
View(tarantino)

################################################################################
################################################################################

# 3. year nevű oszlopba írjuk be a filmek moziba kerülési évét

# Először ellenőrzöm, hogy van-e hiányzó elem
which(is.na(tarantino$movie) == "TRUE")

# Mivel nincs hiányzó hiányzó elem az oszlopban és most ránézésre nincsenek 
# összekeveredve a filmcímek, ezért az alábbi módszer alkalmazható, azonban
# egy összekevert adatbázisnál először sorba kellene rendezni és utána elvégezni
# ezt a műveletsort:

# először megkeresen az egyes filmcímekhez tartozó minimum és maximum sorszámot

y1_min <- min(which(tarantino$movie == "Reservoir Dogs"))
y1_max <-max(which(tarantino$movie == "Reservoir Dogs"))
y1_min
y1_max

y2_min <- min(which(tarantino$movie == "Pulp Fiction"))
y2_max <-max(which(tarantino$movie == "Pulp Fiction"))
y2_min
y2_max

y3_min <- min(which(tarantino$movie == "Kill Bill: Vol. 1"))
y3_max <-max(which(tarantino$movie == "Kill Bill: Vol. 1"))
y3_min
y3_max

y4_min <- min(which(tarantino$movie == "Kill Bill: Vol. 2"))
y4_max <-max(which(tarantino$movie == "Kill Bill: Vol. 2"))
y4_min
y4_max

y5_min <- min(which(tarantino$movie == "Jackie Brown"))
y5_max <-max(which(tarantino$movie == "Jackie Brown"))
y5_min
y5_max

y6_min <- min(which(tarantino$movie == "Inglorious Basterds"))
y6_max <-max(which(tarantino$movie == "Inglorious Basterds"))
y6_min
y6_max

y7_min <- min(which(tarantino$movie == "Django Unchained"))
y7_max <-max(which(tarantino$movie == "Django Unchained"))
y7_min
y7_max

# ha megvannak a sorszámok, akkor az egyes min és max értékek által behatárolt
# intervallumokat felhasználva feltöltöm a year oszlopot a megfelelő évszámokkal

year <- c()
year[y1_min:y1_max] <- 1992
year[y2_min:y2_max] <- 1994
year[y3_min:y3_max] <- 2003
year[y4_min:y4_max] <- 2004
year[y5_min:y5_max] <- 1997
year[y6_min:y6_max] <- 2009
year[y7_min:y7_max] <- 2012

# a végeredmény az újonnan létrehozott tarantino2 adattáblában ellenőrizhető

tarantino2 <- cbind(tarantino, year)

# utána ezt a segédtáblát törlöm is

rm(tarantino2)

################################################################################
################################################################################

# 4. Legkorábban elhangzó szitokszó:

# először szűrjünk rá azokra az esetekre, melyekben van szitokszó

tarantino2 <- subset(tarantino, tarantino$profane == "TRUE")

# melyik filmben?

tarantino2$movie[which.min(tarantino2$minutes_in)]

# hányadik percben?

min(tarantino2$minutes_in)

################################################################################
################################################################################

# 5. Melyik a leggyakoribb szitokszó?

# ehhez először csinálok egy gyakoriságtáblázatot

szitok <- as.data.frame(table(tarantino2$word))

# ezután kiíratom, melyik volt a leggyakoribb

szitok$Var1[which.max(szitok$Freq)]

################################################################################
################################################################################

# 6. Melyik filmben hangzott el a "shitless" szó?

tarantino2$movie[which(tarantino2$word == "shitless")]

################################################################################
################################################################################

# 7. Szitok nélküli sorok

noszitok <- tarantino[which(tarantino$profane == "FALSE"), ]
View(noszitok)

# 190 ilyen sor van.

################################################################################
################################################################################

# 8. A "movie" és a "word" oszlopok adattípusa és átalakítása

# a jelenlegi adattípusok:

class(tarantino$word)
class(tarantino$movie)

# átalakítás faktor típusúvá:

tarantino$movie <- as.factor(tarantino$movie)
tarantino$word <- as.factor(tarantino$word)

################################################################################
################################################################################

# 9. A data frame szűrése a 3 leggyakoribb szóhoz tartozó esetekre

# ehhez letöltöm a plyr package-t, amivel freq táblázatot tudok könnyen készíteni

install.packages("plyr")
library(plyr)

# elkészítem a szitokszavak gyakoriságtáblázatát (ezt már megcsináltam egyébként
# másik módszerrel az 5. feladatban)
# a tarantino2-ből csinálom, mivel abban már ki vannak szűrve a szitokszó nélküli
# esetek

szitok2 <- count(tarantino2, "word")

# csökkenő sorrendbe állítom gyakoriág szerint a szavakat

szitok2 <- szitok2[order(szitok2$freq, decreasing = "TRUE"), ]

# ezeket is faktor típusúvá teszem

szitok2$word <- as.factor(szitok2$word)

# a 3 leggyakoribb szitokszót tartalmazó esetekre való szűrés

tarantino3 <- tarantino2[which(tarantino2$word 
                              == szitok2$word[1] | tarantino2$word
                              == szitok2$word[2] | tarantino2$word 
                              == szitok2$word[3]), ]

################################################################################
################################################################################

# 10. Table fgv és filmek - 3 leggyakoribb szó kereszttáblája

?table
?droplevels

# tegyük faktorokká ebben az adatbázisban is a word és movie oszlopok értékeit

tarantino2$movie <- as.factor(tarantino2$movie)
tarantino2$word <- as.factor(tarantino2$word)

# a droplevels leírásánál használt példát felhasználva csinálok egy subset-et
# a nem kívánatos esetekről
torlendo <- subset(tarantino2, word != "fuck" & word != "fucking" & word != "shit")

# ezt felhasználva pedig a kereszttáblát úgy szűkítem, hogy az exclude 
# feltétellel kihagyom belőle a törlendő eseteket

table(tarantino2$movie, tarantino2$word, exclude = torlendo$word)

################################################################################
################################################################################

# 11. Ebben az adatbázisban nincsenek halálra vonatkozó adatok, de azt megnézem,
# hogy melyik filmben hány szitokszó hangzott el

# Ehhez a "profane" változót használom fel

table(tarantino2$movie, tarantino2$profane)

# A Ponyvaregényben hangzott el a legtöbb és a Kill Bill első részében a 
# legkevesebb (tudom, hogy nem ez volt a kérdés, 
# de csak ezt tudom megnézni a halálesetek változó hiányában).

################################################################################
################################################################################

# 12. A dataset kiírása .tsv formátumba:
write.table(
  tarantino,
  file = "data/tarantino.tsv",
  sep = "\t",
  row.names = F,
  fileEncoding = "utf-8"
)

################################################################################
################################################################################

# 13. Beolvasása a tsv fájlnak, majd törlése

# mivel én az előzőekben használtam a tarantino2 és -3 dataset neveket, ezért
# tarantino4-ként fogom beolvasni, majd törölni

tarantino4 <-
  read.table(
    file = "data/tarantino.tsv",
    header = T,
    sep = "\t",
    dec = ".",
    fileEncoding = "utf-8"
  )

# most pedig törlés

rm(tarantino4)

################################################################################
################################################################################
#                                                                              #
#                                   VÉGE                                       #     
#                                                                              #
################################################################################
################################################################################

