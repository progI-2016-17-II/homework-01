
#########################
# Házi feladat 1        #
# Programozás I.        #
# 2016/17. II. félév    #
# Mogyorósi Pálma       #
# 2017.02.27.           #
#########################

#---------------------------II.01 feladat---------------------------

# Installáld a fivethirtyeight package-et, majd hívd be!
install.packages("fivethirtyeight")
# Package behívása
require("fivethirtyeight")

#---------------------------II.02 feladat---------------------------

# Help-ben kikeresni a megfelelő datasetet
data(tarantino)
tarantino

#---------------------------II.03 feladat---------------------------

# Új oszlop létrehozása
tarantino["year"] <- NA

# A "year" oszlop feltöltése adatokkal
tarantino$year[tarantino$movie =="Reservoir Dogs"] <- 1992
tarantino$year[tarantino$movie =="Pulp Fiction"] <- 1994
tarantino$year[tarantino$movie =="Kill Bill: Vol. 1"] <- 2003
tarantino$year[tarantino$movie =="Kill Bill: Vol. 2"] <- 2004
tarantino$year[tarantino$movie =="Jackie Brown"] <- 1997
tarantino$year[tarantino$movie =="Inglorious Basterds"] <- 2009
tarantino$year[tarantino$movie =="Django Unchained"] <- 2012

#---------------------------II.04 feladat---------------------------
# Melyik filmben hangzott el a legkorábban szitokszó? 
# Melyik szó volt ez és hányadik percben hangzott el?

which.min(tarantino$minutes_in)
legkorabban <- tarantino$movie[which.min(tarantino$minutes_in)]
legkorabban

melyikszo <- tarantino$word[which.min(tarantino$minutes_in)]
melyikszo

hanyadikperc <- tarantino$minutes_in[which.min(tarantino$minutes_in)]
hanyadikperc

#---------------------------II.05 feladat---------------------------
# Melyik a Tarantino filmek leggyakoribb szitokszava? 
# Tedd csökkenő sorrendbe a szavakat gyakoriság szerint!

freqszavak <- table(tarantino$word)
freqszavak
which.max(freqszavak)
freqszavak[29]
leggyakoribb <- freqszavak[29]
leggyakoribb

sort(freqszavak, decreasing = T)

#---------------------------II.06 feladat---------------------------
# Melyik filmben hangzott el a shitless szó?

shitlessfilmcim <- tarantino$movie[which(tarantino$word == "shitless")]
shitlessfilmcim

#---------------------------II.07 feladat---------------------------
# Listázd ki azokat a sorokat, ahol a szó hiányos adat! Hány ilyen sor van?

is.na(tarantino$word)
list(which(is.na(tarantino$word)))

#---------------------------II.08 feladat---------------------------
# Nézd meg, milyen adattípusúak a movie és word oszlopok!
# Alakítsd át őket factor típusúvá, ha eddig nem tetted valamelyik lépésben (ami nem volt kötelező)!

class(tarantino$movie)
class(tarantino$word)

tarantino$movie <- as.factor(tarantino$movie)
tarantino$word <- as.factor(tarantino$word)
# Megcsinálta-e? Igen.
class(tarantino$movie)
class(tarantino$word)

#---------------------------II.09 feladat---------------------------
# Szűrd le a data frame-et úgy, hogy csak a 3 leggyakoribb szóhoz tartozó sorok maradjanak benne!

gyaksorrend <- sort(freqszavak, decreasing = T)
gyaksorrend
head(gyaksorrend, n=3)
top3 <- head(gyaksorrend, n=3)
top3

top3freq <- subset(tarantino, tarantino$word == "fucking" | tarantino$word == "shit" | tarantino$word == "fuck")
top3freq


#---------------------------II.10 feladat---------------------------
# Nézd meg az R dokumentációban a table függvényt! 
# Csináld meg vele a filmek és a 3 leggyakoribb szó kereszttábláját! 
# Szükség lesz még a droplevel függvényre is, amivel a felesleges faktorszinteket tudod törölni. 
# Ennek is nézz utána a dokumentációban!

# Új oszlop létrehozása, hogy a filmek és a leggyakoribb szavak argumentumok egyforma hosszúak legyenek
tarantino["szo"] <- NA

# A "szo" oszlop feltöltése csak azokkal az adatokkal, amik most kellenek:
# azaz, ha a filhez tartozik a top3 szó közül valamelyik
# így a többi érték NA marad és nem veszi figyelembe a kereszttábla
tarantino$szo[tarantino$word =="fucking"] <- "fucking"
tarantino$szo[tarantino$word =="shit"] <- "shit"
tarantino$szo[tarantino$word =="fuck"] <- "fuck"

table(tarantino$movie, tarantino$szo)


#---------------------------II.11 feladat---------------------------
# Nézd meg, melyik filmben hány halál történt és hány szitokszó hangzott el! 
# Volt olyan film, ahol több halál volt, mint szitkozódás?


tarantino["halal"] <- NA
tarantino$halal[tarantino$profane =="FALSE"] <- "FALSE"
table(tarantino$movie, tarantino$halal)


tarantino["szitokszo"] <- NA
tarantino$szitokszo[tarantino$profane =="TRUE"] <- "TRUE"
table(tarantino$movie, tarantino$szitokszo)

halaltabla <- table(tarantino$movie, tarantino$halal)
halaltabla
szitokszotabla <- table(tarantino$movie, tarantino$szitokszo)
szitokszotabla

tobbhalal <- halaltabla > szitokszotabla
tobbhalal

#---------------------------II.12 feladat---------------------------
# Írd ki tsv formátumba a datasetet egy data nevű mappába datasetneve.tsv néven 

write.table(tarantino, file = "data/tarantino.tsv", sep = "\t", 
            row.names = F, fileEncoding = "utf-8")

#---------------------------II.13 feladat---------------------------
# A most kiírt tsv-t olvasd be egy új változóba datasetneve2 néven, majd töröld ki!

tarantino2 <- read.table(file = "data/tarantino.tsv", header = T, sep = "\t",
                       dec = ".", fileEncoding = "utf-8")
rm(tarantino2)

git branch my-solutins-mp
git chechout my-solutins-mp
git push my-solutins-mp




