# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

getwd()
setwd("C:/Coursera/EDA_ProjectAssignment2")

# Load the NEI & SCC data frames.
if(!exists("NEI")){
  NEI <- readRDS("data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("data/Source_Classification_Code.rds")
}

# Aggregate by sum the total emissions by year
aggregatedTotalByYear <- aggregate(Emissions ~ year, NEI, sum)

png("plot1.png", width = 640, height = 480)

barplot(
  height = aggregatedTotalByYear$Emissions, 
  names.arg = aggregatedTotalByYear$year, 
  xlab = "years", 
  ylab = expression("Total PM[2.5]* emission"),
  main = expression("Total PM2.5 Emissions From All US Sources")
)

dev.off()
