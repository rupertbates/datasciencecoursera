library(sqldf)
acs <- read.csv("./data/getdata-data-ss06pid.csv")

sqldf("select pwgtp1 from acs where AGEP < 50")

sqldf("select * from acs where AGEP < 50 and pwgtp1")

sqldf("select pwgtp1 from acs")

sqldf("select * from acs where AGEP < 50")

unique(acs$AGEP)

sqldf("select distinct AGEP from acs")