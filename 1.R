## Project 2

library("plyr")

## Read data from rds documents
NEI <- readRDS("summarySCC_PM25.rds")

## set "year" as factor
NEI <- transform(NEI, year = factor(year))

## Sum the total emmissions according to the year
UsEimmisions <-ddply(NEI, .(year), summarise, sum_Eimmisions = sum(Emissions, na.rm = TRUE)/1000000)

barplot(UsEimmisions$sum_Eimmisions, names.arg=UsEimmisions$year, 
        xlab= "Year", ylab = "Emissions (x 10^6 t)", main="Total PM2.5 Emission From All Sources", col="steelblue")
