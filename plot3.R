# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make 
# a plot answer this question.

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

library(ggplot2)

# 24510 is Baltimore, see plot2.R
if(!exists("subsetNEI")){
  subsetNEI  <- NEI[NEI$fips == "24510", ]
}

# Aggregate by sum the total emissions by year
aggregatedTotalByYearAndType <- aggregate(Emissions ~ year + type, subsetNEI, sum)

png("plot3.png", width = 640, height = 480)

g <- ggplot(aggregatedTotalByYearAndType, aes(factor(year), Emissions, fill = type)) +
    geom_bar(stat = "identity") +
    theme_bw() + 
    guides(fill = FALSE) +
    facet_grid(.~type, scales = "free", space = "free") + 
    labs(x = "year", y = expression("Total PM[2.5]* Emission (Tons)")) + 
    labs(title = expression("PM[2.5]* Emissions, Baltimore City 1999-2008 by Source Type"))

print(g)

dev.off()
