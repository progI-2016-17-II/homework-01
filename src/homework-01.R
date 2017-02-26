# Házi Feladat
# prog 1
# 16-17/2
# Károlyi
# 17-02-26

# letölt, behív, 538
install.packages("fivethirtyeight")
library(fivethirtyeight)

#dataset beolvasása
??fivethirtyeight
tarantino <- tarantino

#Egy új year nevű oszlopba írd be a filmek moziba kerülési évét
tarantino$year <- NA

?which
which(tarantino$movie=="Reservoir Dogs")

tarantino$year[which(tarantino$movie=="Reservoir Dogs")] <- "1992" 
tarantino$year[which(tarantino$movie=="Pulp Fiction")] <- "1994" 
tarantino$year[which(tarantino$movie=="Kill Bill: Vol. 1")] <- "2003" 
tarantino$year[which(tarantino$movie=="Kill Bill: Vol. 2")] <- "2004" 
tarantino$year[which(tarantino$movie=="Jackie Brown")] <- "1997" 
tarantino$year[which(tarantino$movie=="Inglorious Basterds")] <- "2009" 
tarantino$year[which(tarantino$movie=="Django Unchained")] <- "2012" 

tarantino$year

#Melyik filmben hangzott el a legkorábban szitokszó? 
#Melyik szó volt ez és hányadik percben hangzott el?
which.min(tarantino$minutes_in)
tarantino[1,1:5]

#Melyik a Tarantino filmek leggyakoribb szitokszava? 
#Tedd csökkenő sorrendbe a szavakat gyakoriság szerint!
tarantino$word <- as.factor(tarantino$word)
sort(summary(tarantino$word), decreasing = T)

#Melyik filmben hangzott el a shitless szó?
which(tarantino$word == "shitless")
tarantino[1098, 1:5]

#Listázd ki azokat a sorokat, ahol a szó hiányos adat! Hány ilyen sor van?
which(is.na(tarantino$word))
tarantino[which(is.na(tarantino$word)), 1:5]
nrow(tarantino[which(is.na(tarantino$word)), 1:5])

#Nézd meg, milyen adattípusúak a movie és word oszlopok! 
#Alakítsd át őket factor típusúvá, 
summary(tarantino$movie)
tarantino$movie <- as.factor(tarantino$movie)

#Szűrd le a data frame-et úgy, hogy csak a 3 leggyakoribb szóhoz tartozó 
#sorok maradjanak benne!
top3 <- subset(tarantino, tarantino$word == "fucking" | tarantino$word == "shit" 
       | tarantino$word == "fuck")

#Nézd meg az R dokumentációban a table függvényt! 
#Csináld meg vele a filmek és a 3 leggyakoribb szó kereszttábláját! 
#Szükség lesz még a droplevel függvényre is, amivel a felesleges faktorszinteket 
#tudod törölni. Ennek is nézz utána a dokumentációban!
?table
?droplevels
top3$word<-droplevels(top3$word)
table(top3$movie, top3$word)

#Nézd meg, melyik filmben hány halál történt és hány szitokszó hangzott el! 
#Volt olyan film, ahol több halál volt, mint szitkozódás?
table(tarantino$movie, tarantino$profane)

#Írd ki tsv formátumba a datasetet egy data nevű mappába datasetneve.tsv néven 
#(értelemszerűen a dataset neve szerepeljen a tsv nevében)!

write.table(
  tarantino,
  file = "data/tarantino.tsv",
  sep = "\t",
  row.names = F,
  fileEncoding = "utf-8"
)

#A most kiírt tsv-t olvasd be egy új változóba datasetneve2 néven, majd töröld ki!
tarantino2 <-
  read.table(
    file = "data/tarantino.tsv",
    header = T,
    sep = "\t",
    dec = ".",
    fileEncoding = "utf-8"
  )

rm(tarantino2)
