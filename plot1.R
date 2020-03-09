library('data.table')

NEI <- readRDS("data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("data/exdata_data_NEI_data/Source_Classification_Code.rds")

# get total emissions of the years 1999, 2002, 2005, and 2008.
aggregated_total_by_year <- aggregate(Emissions ~ year, NEI, sum)

png('plot1.png')
barplot(height=aggregated_total_by_year$Emissions,
        names.arg=aggregated_total_by_year$year,
        xlab="years",
        ylab=expression('total PM'[2.5]*' emission'),
        main=expression('Total PM'[2.5]*' emissions at various years'))
dev.off()