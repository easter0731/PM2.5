## Project 2

library("plyr")
library(ggplot2)

## Read data from rds documents
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## set "year" as factor
NEI <- transform(NEI, year = factor(year))

##Subset the SCC codes
filter<- grepl("On-Road", SCC$EI.Sector)
codes <- SCC[filter,1]

##Subset data using codes
OnRoad <- subset(NEI, NEI$SCC %in% codes)

##Subset Baltimore City and Los Angeles County data
TwoCityOnRoad <- subset(OnRoad, (OnRoad$fips %in% "24510" | OnRoad$fips %in% "06037"))

## Sum the emmissions according to the year
TwoCityEimmisions <- ddply(TwoCityOnRoad, .(year, fips ), summarise, sum_Eimmisions = sum(Emissions, na.rm = TRUE))

##ggplot
png("plot6.png")
g <- ggplot(data=TwoCityEimmisions, aes(x=year, y=sum_Eimmisions, group=fips, color= fips, shape=fips) )
        g + geom_line(size=0.8,alpha=1/2) + 
        geom_point(size=4, alpha=1/2) + 
        labs(x= "Year", y= "Emissions ~ (t)", title = "PM2.5 Emissions From Motor (Los Angeles vs Baltimore)" ) +
        scale_colour_discrete (name="City", breaks=c("06037","24510"), labels= c("Los Angeles","Baltimore")) +
        scale_shape_discrete (name="City", breaks=c("06037","24510"), labels= c("Los Angeles","Baltimore"))
dev.off()