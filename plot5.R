library(ggplot2)

NEI <- readRDS("data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("data/exdata_data_NEI_data/Source_Classification_Code.rds")

merged_NEISCC <- merge(NEI, SCC, by="SCC")

# get emissions from motor vehicle from 1999-2008 in Baltimore City
# motor vehicle is "ON-ROAD" type in NEI
Baltimore_motor_vehicle_NEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

aggregated_total_by_year <- aggregate(Emissions ~ year, Baltimore_motor_vehicle_NEI, sum)

png("plot5.png", width=840, height=480)
g <- ggplot(aggregated_total_by_year, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle in Baltimore City, Maryland from 1999 to 2008')
print(g)
dev.off()