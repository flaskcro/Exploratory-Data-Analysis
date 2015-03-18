filelist <- dir()

if(!exists("NEI") & sum(filelist %in% "summarySCC_PM25.rds") == 1){
    NEI <- readRDS("summarySCC_PM25.rds")  
}

if(!exists("SCC") & sum(filelist %in% "summarySCC_PM25.rds") == 1){
    SCC <- readRDS("Source_Classification_Code.rds")
}

#Have total emissions from PM2.5 decreased in the United States 
#from 1999 to 2008? 
#Using the base plotting system, make a plot showing 
#the total PM2.5 emission from all sources for each of the 
#years 1999, 2002, 2005, and 2008.

all_sum_by_year <- aggregate(NEI$Emissions, list(year = NEI$year), FUN = sum)
plot( all_sum_by_year, type="b", ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", pch=19, cex=2, col="blue", main="Total Emissions in the United States (1998-2008)")
dev.copy(png,'plot1.png')
dev.off()
