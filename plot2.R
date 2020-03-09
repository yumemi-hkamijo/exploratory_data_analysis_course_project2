NEI <- readRDS("data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("data/exdata_data_NEI_data/Source_Classification_Code.rds")

# fips == "24510" means Baltimore City, Maryland
marylan_NEI  <- NEI[NEI$fips=="24510", ]

# get total emissions in the Baltimore City, Maryland from 1999 to 2008
aggregated_total_by_year <- aggregate(Emissions ~ year, marylan_NEI, sum)

png('plot2.png')
barplot(height=aggregated_total_by_year$Emissions,
        names.arg=aggregated_total_by_year$year,
        xlab="years",
        ylab=expression('total PM'[2.5]*' emission'),
        main=expression('Total PM'[2.5]*' in the Baltimore City, MD emissions at various years'))
dev.off()