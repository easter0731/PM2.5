## Project 2

library("plyr")

## Read data from rds documents
NEI <- readRDS("summarySCC_PM25.rds")

## set "year" as factor
NEI <- transform(NEI, year = factor(year))

## Subset data of Baltimore City, Maryland 
BalNEI<-subset(NEI, fips=="24510")

## Sum the total emmissions according to the year
BalEimmisions <-ddply(BalNEI, .(year), summarise, sum_Eimmisions = sum(Emissions, na.rm = TRUE))

##barplot
png("plot2.png")
barplot(BalEimmisions$sum_Eimmisions, names.arg=BalEimmisions$year, 
        xlab= "Year", ylab = "Emissions (t)", main="Baltimore City PM2.5 Emission From All Sources", col="steelblue")
dev.off()