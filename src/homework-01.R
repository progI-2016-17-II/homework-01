

#Házi Feladat I.      #
#Programozás I.       #
#2016/2017 II. félév  #
#Gallina Beáta        #
#2017.02.22.          #
#_______________________________________________________________#

#----------------II. Feladat-------------------#

#******* 1.*******#

if (!("fivethirtyeight" %in% installed.packages())){
  install.packages("fivethirtyeight")
}
library(fivethirtyeight)


#******* 2.*******#

data(package = "fivethirtyeight")

#tarantino dataset#

#dataset behívása#

data(tarantino)
head(tarantino)

#******* 3.*******#

#Year oszlopba beírom az évet#

reservoir <- subset(tarantino, movie == "Reservoir Dogs")

reservoir$year<-as.factor("1992")

pulp <- subset(tarantino, movie == "Pulp Fiction")

pulp$year<-as.factor("1994")

kill1 <- subset(tarantino, movie == "Kill Bill: Vol. 1")

kill1$year<-as.factor("2003")

kill2 <- subset(tarantino, movie == "Kill Bill: Vol. 2")

kill2$year<-as.factor("2004")

jackie <- subset(tarantino, movie == "Jackie Brown")

jackie$year<-as.factor("1997")

basterds <- subset(tarantino, movie == "Inglorious Basterds")

basterds$year<-as.factor("2009")

django <- subset(tarantino, movie == "Django Unchained")

django$year<-as.factor("2012")


#******* 4.*******#

min(tarantino$minutes_in)

#0.4. percben hangzott el#

which.min(tarantino$minutes_in)


#az első filmben: Reservoir Dogs#

korai<-subset(tarantino, minutes_in == 0.4)

korai$word

#legkorábban a "dick" szó hangzott el#

#******* 5.*******#

table(tarantino$word)

#leggyakoribb káromkodás="fucking"#

sort(tarantino$word, decreasing=F)

#******* 6.*******# 

subset(tarantino, word=="shitless")

#Kill Bill Vol.2-ben#

#******* 7.*******#

sum((is.na(tarantino$word))==TRUE)

#190 ilyen sor van#

#******* 8.*******#

class(tarantino$movie)

class(tarantino$word)

#mindkettő character típusú#

mov_fact<-as.factor(tarantino$movie)
class(mov_fact)

word_fact<-as.factor(tarantino$word)
class(word_fact)

#******* 9.*******#

table(tarantino$word)

firstgyak<-subset(tarantino, tarantino$word == "fucking")
thirdgyak<-subset(tarantino, tarantino$word == "fuck")
secgyak<-subset(tarantino, tarantino$word == "shit")
gyakoriword<-rbind(firstgyak, thirdgyak, secgyak)

#******* 10.*******#

help(table)
help(droplevels)

table(droplevels(gyakoriword)$movie,
      (gyakoriword)$word)


#******* 11.*******#

table(tarantino$movie,tarantino$profane)
table(tarantino$movie,tarantino$word)

sum(reservoir$profane == "FALSE")
sum(pulp$profane == "FALSE")
sum(basterds$profane == "FALSE")
sum(django$profane == "FALSE")
sum(jackie$profane == "FALSE")
sum(kill1$profane == "FALSE")
sum(kill2$profane == "FALSE")

szitok<-rbind((431-(sum((is.na(reservoir$word))==TRUE))),(476-(sum((is.na(pulp$word))==TRUE))),
              (106-(sum((is.na(basterds$word))==TRUE))), (309-(sum((is.na(django$word))==TRUE))), 
              (372-(sum((is.na(jackie$word))==TRUE))), (120-(sum((is.na(kill1$word))==TRUE))),
              (80-(sum((is.na(kill2$word))==TRUE))))
szitok

halal<-rbind((sum(reservoir$profane == "FALSE")),
             (sum(pulp$profane == "FALSE")),
             (sum(basterds$profane == "FALSE")),
             (sum(django$profane == "FALSE")),
             (sum(jackie$profane == "FALSE")),
             (sum(kill1$profane == "FALSE")),
             (sum(kill2$profane == "FALSE")))
halal

halal>szitok

#Vagy#

summary(reservoir$word, na.rm=TRUE)
sum((is.na(reservoir$word))==TRUE)
431-(sum((is.na(reservoir$word))==TRUE))
sum(reservoir$profane == "FALSE")>(431-(sum((is.na(reservoir$word))==TRUE)))
#Reservoir-ban nem volt több halál, mint szitkozódás#

summary(pulp$word, na.rm=TRUE)
sum((is.na(pulp$word))==TRUE)
476-(sum((is.na(pulp$word))==TRUE))
sum(pulp$profane == "FALSE")>(476-(sum((is.na(pulp$word))==TRUE)))
#Pulp-ban sem#

summary(basterds$word, na.rm=TRUE)
sum((is.na(basterds$word))==TRUE)
106-(sum((is.na(basterds$word))==TRUE))
sum(basterds$profane == "FALSE")>(106-(sum((is.na(basterds$word))==TRUE)))
#Basterds-ben sem#

summary(django$word, na.rm=TRUE)
sum((is.na(django$word))==TRUE)
309-(sum((is.na(django$word))==TRUE))
sum(django$profane == "FALSE")>(309-(sum((is.na(django$word))==TRUE)))
#Django-ban sem#

summary(jackie$word, na.rm=TRUE)
sum((is.na(jackie$word))==TRUE)
372-(sum((is.na(jackie$word))==TRUE))
sum(jackie$profane == "FALSE")>(372-(sum((is.na(jackie$word))==TRUE)))
#Jackie-ben sem#

summary(kill1$word, na.rm=TRUE)
sum((is.na(kill1$word))==TRUE)
120-(sum((is.na(kill1$word))==TRUE))
sum(kill1$profane == "FALSE")>(120-(sum((is.na(kill1$word))==TRUE)))
#Kill 1-ben t?bb hal?l van, mint szitoksz?#

summary(kill2$word, na.rm=TRUE)
sum((is.na(kill2$word))==TRUE)
80-(sum((is.na(kill2$word))==TRUE))
sum(kill2$profane == "FALSE")>(80-(sum((is.na(kill2$word))==TRUE)))
#Kill2-ben sem#




#******* 12.*******#


write.table(tarantino, file = "data/tarantino.tsv", sep = "\t", 
            row.names = F, fileEncoding = "utf-8")

#******* 13.*******#

tarantino2 <- 
  read.table(
    file = "data/tarantino.tsv",
    header = T,
    sep = "\t",
    dec = ".",
    fileEncoding = "utf-8"
  ) 

