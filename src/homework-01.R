###############################
# Házi feladat 1              #
# Programozás I.              #
# 2016/17. II. félév          #
# Nagy Daniella               #
# 2017.02.23.                 #
###############################

# ---II. feladat --------------------------------------------------------------

# 1. Package installálása
if (!("fivethirtyeight" %in% installed.packages())) {
  install.packages("fivethirtyeight")
}
library("fivethirtyeight")

# 2. Dataset megkeresése és beolvasása
data(package = "fivethirtyeight")
data("tarantino")
head("tarantino")

# 3. Új oszlop a filmek moziba kerülési évével
# új üres oszlop létrehozása
tarantino[year]<-NA
# az oszlop feltöltése
tarantino$year<-
  ifelse(tarantino$movie=="Reservoir Dogs", 1992,
    ifelse(tarantino$movie=="Pulp Fiction", 1994,
      ifelse(tarantino$movie=="Kill Bill: Vol. 1", 2003,
        ifelse(tarantino$movie=="Kill Bill: Vol. 2", 2004,
           ifelse(tarantino$movie=="Jackie Brown", 1997,
              ifelse(tarantino$movie=="Inglorious Basterds", 2009,
                ifelse (tarantino$movie=="Django Unchained", 2012,
                                      NA  )))))))

# 4. legkorábbi szitokszó
# melyik filmben?
tarantino$movie[
  which(
    tarantino$minutes_in==min(tarantino$minutes_in) & 
      tarantino$profane=="TRUE")
  ]
# melyik szó?
tarantino$word[
  which(
    tarantino$minutes_in==min(tarantino$minutes_in) & 
      tarantino$profane=="TRUE")
  ]
# mikor?
tarantino$minutes_in[
  which(
    tarantino$minutes_in==min(tarantino$minutes_in) & 
      tarantino$profane=="TRUE")
  ]

# 5. leggyakoribb szitokszó - csökkenő sorrend
# a leggyakoribb szó a "fucking"
tarantino_profane<-
  subset(tarantino, tarantino$profane=="TRUE")
sort(table(tarantino_profane$word), decreasing=T)

# 6. "shitless" szó melyik filmben
# a Kill Bill: Vol. 2 -ben
tarantino$movie[which(tarantino$word=="shitless")]

# 7. listázás, ahol a szó hiányos adat
tarantino_na<-
  subset(tarantino, is.na(tarantino$word))
tarantino_na
# vagy ha "lista" kell szó szerint (de ez kinézetre ugyanaz)
list(tarantino_na)
# hány ilyen sor van?
nrow(tarantino_na)

# 8. adattipusok + átalakítás factorrá
# először még "character" az adattípus
class(tarantino$movie)
class(tarantino$word)
# átállítom factor típusúvá
tarantino$movie<-as.factor(tarantino$movie)
tarantino$word<-as.factor(tarantino$word)

# 9. data frame szűrése: 3 leggyakoribb szitokszóhoz tartozó sorok
# 3 leggyakoribb szitokszó
tarantino_mostfreqent<-
  head(sort(table(tarantino_profane$word), decreasing=T), 3)
# data frame leszűrése
tarantino_freq<-
  subset(tarantino, tarantino$word=="fucking" |
           tarantino$word=="shit" |
           tarantino$word=="fuck" )
tarantino_freq

# 10. kereszttábla a filmekre és a 3 leggyakoribb szitokszóra
?table
?droplevels
table(tarantino_freq$movie,droplevels(tarantino_freq$word))

# 11. halál és szitokszavak száma
# nincs a halálról adat
# szitokszavak száma:
# ehhez felhasznalom a korábban létrehozott tarantino_profane subsetet
table(tarantino_profane$movie, tarantino_profane$profane)

# 12. tsv kiirása
write.table(
  tarantino,
  file = "data/tarantino.tsv",
  sep = "\t",
  row.names = F,
  fileEncoding = "utf-8"
)

# 13. Beolvasás, majd kitörlés
# beolvasás
tarantino2 <-
  read.table(
    file = "data/tarantino.tsv",
    header = T,
    sep = "\t",
    dec = ".",
    fileEncoding = "utf-8"
  )
# kitörlés
rm(tarantino2)