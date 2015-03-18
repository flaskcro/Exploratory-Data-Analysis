#if(sum(filelist %in% "summarySCC_PM25.rds") < 1){
#  
#}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Have total emissions from PM2.5 decreased in the United States 
#from 1999 to 2008? 
#Using the base plotting system, make a plot showing 
#the total PM2.5 emission from all sources for each of the 
#years 1999, 2002, 2005, and 2008.

par(mar=rep(3,4))
all_sum_by_year <- aggregate(NEI$Emissions, list(year = NEI$year), FUN = sum)
plot( all_sum_by_year$year, all_sum_by_year$x, type="b", ylab="Total Emissions", 
      xlab="Year", pch=19, cex=2, col="blue")

baltimore <- NEI[NEI$fips == "24510",]
str(baltimore)
sum_by_year <- aggregate(baltimore$Emissions, list(year = baltimore$year), FUN = sum)
plot( sum_by_year$year, sum_by_year$x, type="b", ylab="Total Emissions", 
      xlab="Year", pch=19, cex=2, col="blue")
