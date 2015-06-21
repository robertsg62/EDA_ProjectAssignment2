# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from 
# motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city 
# has seen greater changes over time in motor vehicle emissions?

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

# merge the two data sets 
if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}

#library(ggplot2)

# 24510 is Baltimore, see plot2.R, 06037 is LA CA
# Searching for ON-ROAD type in NEI
# Don't actually know it this is the intention, but searching for 'motor' in SCC only gave a subset (non-cars)
subsetNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]

# Aggregate by sum the total emissions by year
aggregatedTotalByYearAndFips <- aggregate(Emissions ~ year + fips, subsetNEI, sum)

# Aggregate emissions for Baltimore, MD
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="24510"] <- "Baltimore, MD"

# Aggregate emissions for Los Angeles, CA
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png", width=640, height=480)

g <- ggplot(aggregatedTotalByYearAndFips, aes(factor(year), Emissions)) + 
    facet_grid(. ~ fips) + 
    geom_bar(aes(fill=year), stat="identity")  +
    theme_bw() +
    guides(fill=FALSE) +
    xlab("year") +
    ylab(expression('Total PM'[2.5]*" Emissions")) +
    ggtitle('PM[2.5]* Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008')

print(g)

dev.off()
