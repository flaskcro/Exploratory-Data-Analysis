filelist <- dir()

if(!exists("NEI") & sum(filelist %in% "summarySCC_PM25.rds") == 1){
    NEI <- readRDS("summarySCC_PM25.rds")  
}

if(!exists("SCC") & sum(filelist %in% "summarySCC_PM25.rds") == 1){
    SCC <- readRDS("Source_Classification_Code.rds")
}

baltimore <- NEI[NEI$fips == "24510",]
str(baltimore)
sum_by_year <- aggregate(baltimore$Emissions, list(year = baltimore$year), FUN = sum)
plot( sum_by_year, type="b", expression("Total Emissions, PM"[2.5]), 
      xlab="Year", pch=19, cex=2, col="blue", main = "Total Emissions for Baltimore County")

dev.copy(png,'plot2.png')
dev.off()