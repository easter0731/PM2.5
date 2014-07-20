## Project 2

library("plyr")
library(ggplot2)

## Read data from rds documents
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## set "year" as factor
NEI <- transform(NEI, year = factor(year))

##Subset the SCC codes
filter<- grepl("Combustion", SCC$SCC.Level.One) & grepl("Coal", SCC$SCC.Level.Three)
codes <- SCC[filter,1]

##Subset data using codes
Coal <- subset(NEI, NEI$SCC%in%codes)

## Sum the emmissions according to the year
CoalEimmisions <-ddply(Coal, .(year), summarise, sum_Eimmisions = sum(Emissions, na.rm = TRUE))

##ggplot
png("plot4.png")
g <- ggplot(data=CoalEimmisions, aes(x=year, y=sum_Eimmisions))
        g + geom_line(aes(group=1), size=1,color="steelblue",alpha=1/2)+
        ##geom_line() + 
        geom_point(size=4,color="steelblue",alpha=1/2) + 
        labs(x= "Year", y= "Emissions ~ (t)", title = "PM2.5 Emissions From Coal in US" ) 

dev.off()