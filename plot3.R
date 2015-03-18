filelist <- dir()

if(!exists("NEI") & sum(filelist %in% "summarySCC_PM25.rds") == 1){
    NEI <- readRDS("summarySCC_PM25.rds")  
}

if(!exists("SCC") & sum(filelist %in% "summarySCC_PM25.rds") == 1){
    SCC <- readRDS("Source_Classification_Code.rds")
}

library(ggplot2)
baltimore <- NEI[NEI$fips == "24510",]
str(baltimore)
sum_by_year <- aggregate(baltimore$Emissions, list(year = baltimore$year,
                                                   type = baltimore$type), FUN = sum)

qplot(year,x, data=sum_by_year, color=type, geom="line",ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Total Emissions ifor Baltimore County. by Type of Pollutant")

dev.copy(png,'plot3.png')
dev.off()