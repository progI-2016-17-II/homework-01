############# 1. Házi feladat II. feladatának példamegoldásai ##################

############# II/1. feladat ####################################################
if (!("fivethirtyeight" %in% installed.packages())) {
  install.packages("fivethirtyeight")
}
library(fivethirtyeight)


############# II/2. feladat ####################################################
data(package = "fivethirtyeight")
data(tarantino)

#### Károlyi Kristóf ####
??fivethirtyeight


############# II/3. feladat ####################################################
tarantino$year[tarantino$movie == 'Reservoir Dogs'] <- 1992
tarantino$year[tarantino$movie == 'Pulp Fiction'] <- 1994
tarantino$year[tarantino$movie=="Kill Bill: Vol. 1"] <- 2003 
tarantino$year[tarantino$movie=="Kill Bill: Vol. 2"] <- 2004 
tarantino$year[tarantino$movie=="Jackie Brown"] <- 1997 
tarantino$year[tarantino$movie=="Inglorious Basterds"] <- 2009 
tarantino$year[tarantino$movie=="Django Unchained"] <- 2012 

#### Nagy Daniella ####
tarantino$year <-
  ifelse(tarantino$movie=="Reservoir Dogs", 1992,
    ifelse(tarantino$movie=="Pulp Fiction", 1994,
      ifelse(tarantino$movie=="Kill Bill: Vol. 1", 2003,
        ifelse(tarantino$movie=="Kill Bill: Vol. 2", 2004,
           ifelse(tarantino$movie=="Jackie Brown", 1997,
              ifelse(tarantino$movie=="Inglorious Basterds", 2009,
                ifelse(tarantino$movie=="Django Unchained", 2012, NA)))))))

#### Hering András ####
for (i in 1:nrow(tarantino)) {
  if      (tarantino[i,1] == "Reservoir Dogs")     {tarantino [i,5] <- "1992"}
  else if (tarantino[i,1] == "Pulp Fiction")       {tarantino [i,5] <- "1994"}
  else if (tarantino[i,1] == "Kill Bill: Vol. 1")  {tarantino [i,5] <- "2003"}
  else if (tarantino[i,1] == "Kill Bill: Vol. 2")  {tarantino [i,5] <- "2004"}
  else if (tarantino[i,1] == "Jackie Brown")       {tarantino [i,5] <- "1997"}
  else if (tarantino[i,1] == "Inglorious Basterds"){tarantino [i,5] <- "2009"}
  else if (tarantino[i,1] == "Django Unchained")   {tarantino [i,5] <- "2012"}
}
colnames(tarantino)[5] <- "year"

####Farsang Bence ####
tarantino$year[which(tarantino$movie == "Reservoir Dogs")]      <- 1992
tarantino$year[which(tarantino$movie == "Pulp Fiction")]        <- 1994
tarantino$year[which(tarantino$movie == "Kill Bill: Vol. 1")]   <- 2003
tarantino$year[which(tarantino$movie == "Kill Bill: Vol. 2")]   <- 2004
tarantino$year[which(tarantino$movie == "Jackie Brown")]        <- 1997
tarantino$year[which(tarantino$movie == "Inglorious Basterds")] <- 2009
tarantino$year[which(tarantino$movie == "Django Unchained")]    <- 2012


############# II/4. feladat ####################################################
tarantino[which.min(subset(tarantino, tarantino$profane == TRUE)$minutes_in), ]

#### Hering András ####
tarantino[which.min(subset(tarantino, tarantino$profane == TRUE)$minutes_in),
          c(1,3,4)]

#### Takács Bence ####
tarantino[order("minutes_in", decreasing = F), ]

#### Nagy Daniella ####
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

#### Kónya Viktória ####
tarantino$movie[which.min(tarantino$minutes_in)] # A "Reservoir Dogs" c. filmben
tarantino$word[which.min(tarantino$minutes_in)] # a "dick" szó
tarantino$minutes_in[which.min(tarantino$minutes_in)] # a 0.4 percben


############# II/5. feladat ####################################################
tarantino$word <- as.factor(tarantino$word)
sort(summary(tarantino$word), decreasing = T)
names(sort(summary(tarantino$word), decreasing = T))[1]

#### Nagy Daniella #### 
sort(table(tarantino_profane$word), decreasing = T)

#### Nagy Szimonetta #### 
#a tarantino df word oszlopából a leggyakrabban előforduló string kiírása
names(which.max(table(tarantino$word)))

#ez ad egy listát, ami gyakoriság szerint csökkenő sorrendben felsorolja a 
#káromkodásokat (a gyakoriságot is melléírja)
swear_list <- sort(table(tarantino$word), decreasing = T)
swear_list

#### Kajkó Fruzsina #### 
install.packages("plyr")
library(plyr)
freqtab <- count(tarantino, "word")
freqtab <- freqtab[order(-freqtab$freq), ]


############# II/6. feladat ####################################################
tarantino$movie[which(tarantino$word == "shitless")]

#### Kelemen Kinga #### 
shitless <- subset(mytarantino, word == "shitless")
shitless$movie

#### Kövesdi Rita #### 
film[which(grepl("shitless", film$word)), 1]


############# II/7. feladat ####################################################
tarantino[is.na(tarantino$word), ]
nrow(tarantino[is.na(tarantino$word), ])

#### Kelemen Kinga #### 
hiany <- subset(tarantino, is.na(word)==TRUE)
nrow(hiany)

#### Hering András #### 
subset(tarantino, is.na(tarantino$word))
subset(tarantino, tarantino$profane == FALSE)
# ugyanaz az eredmény, mivel minden, ami nem profanitás, az halál
nrow(subset(tarantino, tarantino$profane == FALSE))
nrow(subset(tarantino, is.na(tarantino$word)))

#### Szilágyi Ádám #### 
tarantino[which(is.na(tarantino$word)), ] #sorok adattal
length(which(is.na(tarantino$word))) # Hány darab?

#### Kövesdi Rita #### 
subset(film, is.na(film$word))
summary(is.na(film$word))


############# II/8. feladat ####################################################
class(tarantino$movie)
class(tarantino$word)
tarantino$movie <- as.factor(tarantino$movie)
tarantino$word <- as.factor(tarantino$word)


############# II/9. feladat ####################################################
tarantino_top3 <-
  subset(tarantino, word %in% names(sort(summary(tarantino$word),
                                         decreasing = T))[1:3])

#### Farsang Bence #### 
tarantino_b <- tarantino[tarantino$word %in% c("fucking", "shit", "fuck"), ]


############# II/10. feladat ###################################################
# 9. feladatban definiált tarantino_top3 data frame alapján
table(tarantino_top3$movie, droplevels(tarantino_top3$word))


############# II/11. feladat ###################################################
table(tarantino$movie[tarantino$profane == T], 
      tarantino$profane[tarantino$profane == T]) < 
  table(tarantino$movie[tarantino$profane == F], 
        tarantino$profane[tarantino$profane == F])

#### Hering András #### 
table(tarantino$movie,tarantino$profane)[,1]>
  table(tarantino$movie,tarantino$profane)[,2]

#### Farsang Bence ####
z <- table(tarantino$movie, tarantino$profane)
print("Volt-e olyan film, ahol több halál volt, mint szitkozódás?")
print(TRUE %in% (z[1:7] > z[8:14]))


############# II/12. feladat ###################################################
write.table(
  tarantino,
  file = "data/tarantino.tsv",
  sep = "\t",
  row.names = F,
  fileEncoding = "utf-8"
)

#### Kajkó Fruzsina ####
# a tsv kiírása előtt data mappa létrehozása
dir.create("data")


############# II/13. feladat ###################################################
tarantino2 <-
  read.table(
    file = "data/tarantino.tsv",
    header = T,
    sep = "\t",
    dec = ".",
    fileEncoding = "utf-8"
  )

rm(tarantino2)
