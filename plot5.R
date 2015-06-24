# 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

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

library(ggplot2)

# 24510 is Baltimore, see plot2.R
# Searching for ON-ROAD type in NEI
# Don"t actually know it this is the intention, but searching for "motor" in SCC only gave a subset (non-cars)
subsetNEI <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD",  ]

# Aggregate by sum the total emissions by year
aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEI, sum)

png("plot5.png", width = 640, height = 480)

g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions)) + 
    geom_bar(stat = "identity", fill = "grey", width = 0.75) +
    theme_bw() + 
    guides(fill = FALSE) +
    xlab("year") +
    ylab(expression("Total PM[2.5]* Emissions")) +
    ggtitle("PM[2.5]* Motor Vehicle Source Emissions in Baltimore from 1999-2008")

print(g)

dev.off()
