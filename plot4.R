library(ggplot2)

NEI <- readRDS("data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("data/exdata_data_NEI_data/Source_Classification_Code.rds")

merged_NEISCC <- merge(NEI, SCC, by="SCC")

# get total emissions across the United States from 1999 to 2008
# fetch merged data with Short.Name (SCC) Coal
coalMatches  <- grepl("coal", merged_NEISCC$Short.Name, ignore.case=TRUE)
subsetNEISCC <- merged_NEISCC[coalMatches, ]

aggregated_total_by_year <- aggregate(Emissions ~ year, merged_NEISCC, sum)

png("plot4.png", width=640, height=480)
g <- ggplot(aggregated_total_by_year, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(g)
dev.off()