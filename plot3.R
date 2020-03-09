library(ggplot2)

NEI <- readRDS("data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("data/exdata_data_NEI_data/Source_Classification_Code.rds")

# fips == "24510" means Baltimore City, Maryland
marylan_NEI  <- NEI[NEI$fips=="24510", ]

# get total emissions with type in the Baltimore City, Maryland from 1999 to 2008
aggregated_total_by_year <- aggregate(Emissions ~ year + type, marylan_NEI, sum)

png("plot3.png", width=640, height=480)
g <- ggplot(aggregated_total_by_year, aes(year, Emissions, color = type))
g <- g + geom_line() +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions in Baltimore City, Maryland from 1999 to 2008')
print(g)
dev.off()