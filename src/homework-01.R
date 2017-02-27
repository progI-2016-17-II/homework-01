###Házi feladat 1.
###Programozás I.
###2016/17. II. félév
###Nagy Szimonetta
###2016.02.27.
###-----------------------------------------------------

#II. feladat -------------------------------------------

#1. Installáld a fivethirteight package-et, majd hívd be!
install.packages("fivethirtyeight")
library("fivethirtyeight")

#2. Keresd meg a leírásnak megfelelő datasetet! Olvasd be!
#(úgy kerestem meg, hogy miután rámentem a package súgójára, bemásoltam a
#leírást a 'find in topic' súgómezőbe, a neve tarantino)
request(tarantino)  #ezzel behívtam a dataframe-et
View(tarantino)     #ezzel külön fülön megnyitottam táblázatos formában

#3. Egy új year nevű oszlopba ird be a filmek moziba kerülésének évét!
tarantino["year"] <- NA  #ezzel létrehoztam egy üres year nevű oszlopot
tarantino$year <-                   
if(tarantino$movie=="Reservoir Dogs") 1992
if(tarantino$movie=="Pulp Fiction") 1994
if(tarantino$movie=="Kill Bill: Vol. 1") 2003
if(tarantino$movie=="Kill Bill: Vol. 2") 2004
if(tarantino$movie=="Jackie Brown") 1997
if(tarantino$movie=="Inglorious Basterds") 2009
if(tarantino$movie=="Django Unchained") 2012
#ezzel feltöltöttem az üres oszlopot a megfelelő értékekkel

#4. Melyik filmben hangzott el legkorábban szitokszó, melyik szó, hányadik 
#percben?
tarantino[tarantino$minutes_in==(min(tarantino$minutes_in)), ]
#a parancs ráindexel a tarantino dataframe azon sorára, ahol a minutes_in oszlop
#értéke a legkisebb, ezt a sort kiírja a konzolon. A megoldás a Reservoir Dogs,
#a szó a dick, a 0.4. percben hangzott el.

#5. Melyik a Tarantino filmek leggyakoribb szitokszava? Tedd csökkenő sorrendbe
#a szavakat gyakoriság szerint!
names(which.max(table(tarantino$word))) #ezzel kiírom a tarantino df word oszlo-
#pából a leggyakrabban előforduló stringet
swear_list <- sort(table(tarantino$word),decreasing=T) #ez ad egy listát, ami
#gyakoriság szerint csökkenő sorrendben felsorolja a káromkodásokat (a gyakori-
#ságot is melléírja)

#6. Melyik filmben hangzott el a 'shitless' szó?
shitless <- tarantino[which(tarantino$word=="shitless"), 1] #ráindexel annak a 
#sornak az első oszlopára, amiben a word oszlop értéke "shitless", és bekódolja
#a shitlessbe

#7. Listázd ki azokat a sorokat, ahol a szó hiányos adat! Hány van?
word_missing <- tarantino[is.na(tarantino$word), ] #a word_missing df-be teszi
#a tarantino azon sorait, ahol adathiány van a word oszlopban
word_missing #kilistázza ezeket a sorokat
nrow(word_missing) #megadja, hogy hány sor van ebben a df-ben

#8. Nézd meg, milyen adattípusúak a movie és word oszlopok! 
#Alakítsd át őket factor típusúvá!
typeof(tarantino$movie)
typeof(tarantino$word)
tarantino$movie <- as.factor(tarantino$movie)
tarantino$word <- as.factor (tarantino$word)
typeof(tarantino$movie)
typeof(tarantino$word)

#9. Szűrd le a data frame-et úgy, hogy csak a 3 leggyakoribb szóhoz tartozó 
#sorok maradjanak benne!




