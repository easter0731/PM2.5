## Assignment 3

## Read data from rds documents
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## set "year" as factor
NEI <- transform(NEI, year = factor(year))
NEI <- transform(NEI, type = factor(type))


with(NEI, plot(log(Emissions) ~ year, xlab= "Year", ylab = "Emissions ~ log(t)", col="steelblue",
               pch=20,  main="Total PM2.5 Emission From All Sources"))

##plot2
BalNEI<-subset(NEI, fips=="24510")
with(BalNEI, plot(log(Emissions) ~ year, xlab= "Year",ylab = "Emissions ~ log(t)", col="steelblue",
                  pch=20,  main="Baltimore City PM2.5 Emission From All Sources"))

library(ggplot2)
NEI <- transform(NEI, type = factor(type))
qplot(y=log(Emissions),x=year, data=BalNEI,geom=c("boxplot","smooth"),xlab= "Year",ylab = "Emissions ~ log(t)", 
      facets=.~type, color=type)  
         
head(SCC)        