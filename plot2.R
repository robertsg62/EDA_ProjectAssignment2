# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

getwd()
setwd("C:/Coursera/EDA_ProjectAssignment2")

# Load the NEI & SCC data frames.
# Load the NEI & SCC data frames.
if(!exists("NEI")){
  NEI <- readRDS("data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("data/Source_Classification_Code.rds")
}

if(!exists("subsetNEI")){
  subsetNEI  <- NEI[NEI$fips=="24510", ]
}

# Aggregate by sum the total emissions by year
aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEI, sum)

png('plot2.png', width=640, height=480)

barplot(
  height=aggregatedTotalByYear$Emissions, 
  names.arg=aggregatedTotalByYear$year, 
  xlab="years", 
  ylab=expression('total PM'[2.5]*' emission'),
  main=expression('Total PM'[2.5]*' in the Baltimore City, MD emissions at various years')
)

dev.off()
