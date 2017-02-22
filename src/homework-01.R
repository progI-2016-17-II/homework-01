###############################
# Házi feladat 1              #
# Programozás I.              #
# 2016/17. II. félév          #
# Nagy Daniella               #
# 2017.02.22.                 #
###############################

#--------- II. feladat --------
# 1. Package installálása
if (!("fivethirtyeight" %in% installed.packages())) {
  install.packages("fivethirtyeight")
}
library("fivethirtyeight")
# 2. Dataset megkeresése és beolvasása
data(package = "fivethirtyeight")
data("tarantino")
head("tarantino")