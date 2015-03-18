filelist <- dir()

if(!exists("NEI") & sum(filelist %in% "summarySCC_PM25.rds") == 1){
    NEI <- readRDS("summarySCC_PM25.rds")  
}

if(!exists("SCC") & sum(filelist %in% "summarySCC_PM25.rds") == 1){
    SCC <- readRDS("Source_Classification_Code.rds")
}

motor_list <- SCC[grep("motor", SCC$Short.Name, ignore.case=T),]
motor_list <- SCC[grep("vehicles", motor_list$Short.Name, ignore.case=T),1]

baltimore <- NEI[NEI$fips == "24510",]
subset_data <- subset(baltimore, SCC %in% motor_list)

sum_by_year <- aggregate(subset_data$Emissions, list(year = subset_data$year), FUN = sum)
plot( sum_by_year$year, sum_by_year$x, type="b", ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Total Emissions from Motor Vehicle Sources", pch=19, cex=2, col="blue")
dev.copy(png,'plot5.png')
dev.off()