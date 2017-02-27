#######################
###Házi feladat 1.    #
###Programozás I.     #
###2016/17. II. félév #
###Nagy Szimonetta    #
###2016.02.27.        #
#######################

#II. feladat -------------------------------------------------------------------

#1. Installáld a fivethirteight package-et, majd hívd be!
install.packages("fivethirtyeight")
library("fivethirtyeight")
#-------------------------------------------------------------------------------

#2. Keresd meg a leírásnak megfelelő datasetet! Olvasd be!----------------------
#(úgy kerestem meg, hogy miután rámentem a package súgójára, bemásoltam a
#leírást a 'find in topic' súgómezőbe, a neve tarantino)

#dataframe behívása
tarantino

#ezzel külön fülön megnyitottam táblázatos formában
View(tarantino)
#-------------------------------------------------------------------------------

#3. Egy új year nevű oszlopba ird be a filmek moziba kerülésének évét!

#ezzel létrehoztam egy üres year nevű oszlopot
tarantino["year"] <- NA  

#üres oszlop feltöltése a megfelelő értékekkel
tarantino$year <-                   
if(tarantino$movie=="Reservoir Dogs") 1992
if(tarantino$movie=="Pulp Fiction") 1994
if(tarantino$movie=="Kill Bill: Vol. 1") 2003
if(tarantino$movie=="Kill Bill: Vol. 2") 2004
if(tarantino$movie=="Jackie Brown") 1997
if(tarantino$movie=="Inglorious Basterds") 2009
if(tarantino$movie=="Django Unchained") 2012

#-------------------------------------------------------------------------------

#4. Melyik filmben hangzott el legkorábban szitokszó, melyik szó, hányadik 
#percben?

#a parancs ráindexel a tarantino dataframe azon sorára, ahol a minutes_in oszlop
#értéke a legkisebb, ezt a sort kiírja a konzolon.
tarantino[tarantino$minutes_in==(min(tarantino$minutes_in)), ]
#A megoldás a Reservoir Dogs, a szó a dick, a 0.4. percben hangzott el.
#-------------------------------------------------------------------------------

#5. Melyik a Tarantino filmek leggyakoribb szitokszava? Tedd csökkenő sorrendbe
#a szavakat gyakoriság szerint!

#a tarantino df word oszlopából a leggyakrabban előforduló string kiírása
names(which.max(table(tarantino$word)))

#ez ad egy listát, ami gyakoriság szerint csökkenő sorrendben felsorolja a 
#káromkodásokat (a gyakoriságot is melléírja)
swear_list <- sort(table(tarantino$word), decreasing = T)
swear_list
#-------------------------------------------------------------------------------

#6. Melyik filmben hangzott el a 'shitless' szó?

#indexelés annak a sornak az első oszlopára, amiben a word oszlop értéke 
#"shitless", és a sor bekódolása a shitless nevű változóba
shitless <- tarantino[which(tarantino$word == "shitless"), 1]
shitless
#-------------------------------------------------------------------------------

#7. Listázd ki azokat a sorokat, ahol a szó hiányos adat! Hány van?

#a word_missing df-be teszi a tarantino azon sorait, ahol adathiány van a 
#word oszlopban
word_missing <- tarantino[is.na(tarantino$word), ]

#az adathiányos sorok listázása
word_missing

#a df sorainak számának megadása
nrow(word_missing)
#-------------------------------------------------------------------------------

#8. Nézd meg, milyen adattípusúak a movie és word oszlopok! 
#Alakítsd át őket factor típusúvá!

#movie és word oszlopok típusának lekérése
typeof(tarantino$movie)
typeof(tarantino$word)

#típus átállítása
tarantino$movie <- as.factor(tarantino$movie)
tarantino$word <- as.factor (tarantino$word)

#movie és word oszlopok típusának lekérése
typeof(tarantino$movie)
typeof(tarantino$word)
#-------------------------------------------------------------------------------

#9. Szűrd le a data frame-et úgy, hogy csak a 3 leggyakoribb szóhoz tartozó 
#sorok maradjanak benne!
#három df létrehozása a három leggyakoribb szóval
word1 <- subset.data.frame(tarantino, tarantino$word == "fucking")
word2 <- subset.data.frame(tarantino, tarantino$word == "shit")
word3 <- subset.data.frame(tarantino, tarantino$word == "fuck")

#a három df összevonása
top3_swear <- rbind.data.frame(word1, word2, word3)

#az összevont df megtekintése
View(top3_swear)

#felesleges df-ek törlése
rm(word1, word2, word3)
#-------------------------------------------------------------------------------

#10. A leggyakoribb szavak és a filmek kereszttáblája és a felesleges 
#faktorszintek törlése
#felesleges faktorszintek törlése
top3_swear$word <- droplevels(top3_swear$word)

#sikerült-e törölni?
levels(top3_swear$word)

#kereszttábla
table(top3_swear$movie, top3_swear$word)
#-------------------------------------------------------------------------------

#11. Melyik filmben hány halál történt és hány szitokszó hangzott el? Volt olyan
#film, ahol több halál volt, mint szitkozódás?
#(a profane oszlop ha TRUE=káromkodás, FALSE=halál)
#adatok filmenkénti bontásban
Res_Dogs <- subset.data.frame(tarantino, tarantino$movie == 
                                "Reservoir Dogs")
Pulp_Fic <- subset.data.frame(tarantino, tarantino$movie == 
                                "Pulp Fiction")
Kill_Bill1 <- subset.data.frame(tarantino, tarantino$movie == 
                                  "Kill Bill: Vol. 1")
Kill_Bill2 <- subset.data.frame(tarantino, tarantino$movie == 
                                  "Kill Bill: Vol. 2")
Jackie_B <- subset.data.frame(tarantino,tarantino$movie == 
                                "Jackie Brown") 
Ingl_Bas <- subset.data.frame(tarantino, tarantino$movie == 
                                "Inglorious Basterds") 
Django_unch <- subset.data.frame(tarantino, tarantino$movie == 
                                   "Django Unchained")

#halálok és szitokszavak száma
length(which(Res_Dogs$profane == F))
length(which(Res_Dogs$profane == T))

length(which(Pulp_Fic$profane == F))
length(which(Pulp_Fic$profane == T))

length(which(Kill_Bill1$profane == F))
length(which(Kill_Bill1$profane == T))

length(which(Kill_Bill2$profane == F))
length(which(Kill_Bill2$profane == T))

length(which(Jackie_B$profane == F))
length(which(Jackie_B$profane == T))

length(which(Ingl_Bas$profane == F))
length(which(Ingl_Bas$profane == T))

length(which(Django_unch$profane == F))
length(which(Django_unch$profane == T))

#halálok számának és szitokszavak számának összehasonlítása (T=több halál)
length(which(Res_Dogs$profane == F)) > length(which(Res_Dogs$profane == T))

length(which(Pulp_Fic$profane == F)) > length(which(Pulp_Fic$profane == T))

length(which(Kill_Bill1$profane == F)) > length(which(Kill_Bill1$profane == T))

length(which(Kill_Bill2$profane == F)) > length(which(Kill_Bill2$profane == T))

length(which(Jackie_B$profane == F)) > length(which(Jackie_B$profane == T))

length(which(Ingl_Bas$profane == F)) > length(which(Ingl_Bas$profane == T))

length(which(Django_unch$profane == F)) > length(which(Django_unch$profane == T))
#csak a Kill Bill első részében volt több halál, mint káromkodás.
#-------------------------------------------------------------------------------

#12. Írd ki tsv formátumba a datasetet egy data nevű mappába (datasetneve.tsv)!
tarantino <- write.table(
  tarantino,
  file = "data/tarantino.tsv",
  sep = "\t",
  row.names = F,
  fileEncoding = "utf-8"
)
#-------------------------------------------------------------------------------

#13. A kiírt tsv-t olvasd be egy új változóba (datasetneve2), majd töröld ki!
tarantino2 <-
  read.table(
    file = "data/tarantino.tsv",
    header = T,
    sep = "\t",
    dec = ".",
    fileEncoding = "utf-8"
  )
#beolvasott df táblázatos formában
View(tarantino2)

#törlés
rm(tarantino2)
#-------------------------------------------------------------------------------

#FELADAT VÉGE ---------------------------------------------------------
#felesleges subsetek törlése
rm(Django_unch, Ingl_Bas, Jackie_B, Kill_Bill1, Kill_Bill2, Pulp_Fic, Res_Dogs)
