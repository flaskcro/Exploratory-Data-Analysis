filelist <- dir()

if(!exists("NEI") & sum(filelist %in% "summarySCC_PM25.rds") == 1){
    NEI <- readRDS("summarySCC_PM25.rds")  
}

if(!exists("SCC") & sum(filelist %in% "summarySCC_PM25.rds") == 1){
    SCC <- readRDS("Source_Classification_Code.rds")
}

coal_list <- SCC[grep("coal", SCC$Short.Name, ignore.case=T),1]

subset_data <- subset(NEI, SCC %in% coal_list)
sum_by_year <- aggregate(subset_data$Emissions, list(year = subset_data$year), FUN = sum)
plot( sum_by_year$year, sum_by_year$x, type="b", ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Emissions and Total Coal Combustion for the United States", pch=19, cex=2, col="blue")
dev.copy(png,'plot4.png')
dev.off()