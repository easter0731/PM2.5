## Project 2

library("plyr")
library(ggplot2)

## Read data from rds documents
NEI <- readRDS("summarySCC_PM25.rds")

## set "year" and "type" as factors
NEI <- transform(NEI, year = factor(year))
NEI <- transform(NEI, type = factor(type))

## Subset data of Baltimore City, Maryland 
BalNEI<-subset(NEI, fips %in% "24510")

## Sum the total emmissions according to the year
BalEimmisions <-ddply(BalNEI, .(year, type), summarise, sum_Eimmisions = sum(Emissions, na.rm = TRUE))

##ggplot
png("plot3.png")
g <- ggplot(data=BalEimmisions, aes(x=year, y=sum_Eimmisions, group=type, colour=type, shape=type))
g + geom_line(size=0.8) + geom_point(size=4) + labs(x= "Year", y= "Emissions ~ (t)", title = "Baltimore City PM2.5 Emissions" )
dev.off()

