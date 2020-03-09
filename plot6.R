library(ggplot2)

NEI <- readRDS("data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("data/exdata_data_NEI_data/Source_Classification_Code.rds")

merged_NEISCC <- merge(NEI, SCC, by="SCC")

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# 24510 is Baltimore, see plot2.R, 06037 is LA CA
# Searching for ON-ROAD type in NEI
# Don't actually know it this is the intention, but searching for 'motor' in SCC only gave a subset (non-cars)
Baltimor_California_motor_vehicle_NEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") 
                                             & NEI$type=="ON-ROAD",  ]

aggregated_total_by_year <- aggregate(Emissions ~ year + fips, Baltimor_California_motor_vehicle_NEI, sum)
aggregated_total_by_year$fips[aggregated_total_by_year$fips=="24510"] <- "Baltimore, MD"
aggregated_total_by_year$fips[aggregated_total_by_year$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png", width=1040, height=480)
g <- ggplot(aggregated_total_by_year, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle in Baltimore City, MD vs Los Angeles, CA (fips = "06037")  1999-2008')
print(g)
dev.off()