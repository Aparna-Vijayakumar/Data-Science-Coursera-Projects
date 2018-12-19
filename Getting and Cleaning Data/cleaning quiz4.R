## Question 1
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url, destfile = "~/idaho.csv")
idaho <- read.csv("idaho.csv", header = T, sep = ",")
list <- strsplit(names(idaho), "wgtp")

## Question 2
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url, destfile = "~/gdp.csv")
gdp <- read.csv("gdp.csv", sep=",", skip = 4)
gdp <- setNames(gdp, c("Code", "Rank", "NA","Country", "GDP"))
gdp$GDP <- gsub(",","", gdp$GDP)
num <- as.numeric(gdp$GDP)

## Question 3
country <- gdp$Country
table(grepl("^United",country))

## Question 4
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
f <- file.path(getwd(), "EDSTATS_Country.csv")
download.file(url, f)
dtEd <- data.table(read.csv(f))
dt <- merge(dtGDP, dtEd, all = TRUE, by = c("CountryCode"))
isFiscalYearEnd <- grepl("fiscal year end", tolower(dt$Special.Notes))
isJune <- grepl("june", tolower(dt$Special.Notes))
table(isFiscalYearEnd, isJune)



## Question 5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
addmargins(table(year(sampleTimes), weekdays(sampleTimes)))

