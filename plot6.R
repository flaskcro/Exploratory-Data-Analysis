filelist <- dir()

if(!exists("NEI") & sum(filelist %in% "summarySCC_PM25.rds") == 1){
    NEI <- readRDS("summarySCC_PM25.rds")  
}

if(!exists("SCC") & sum(filelist %in% "summarySCC_PM25.rds") == 1){
    SCC <- readRDS("Source_Classification_Code.rds")
}

#filtering by the keyword "motor"
motor_list <- SCC[grep("motor", SCC$Short.Name, ignore.case=T),]
#Onece more filtering by the keyword "vehicles"
motor_list <- SCC[grep("vehicles", motor_list$Short.Name, ignore.case=T),1]

cities <- NEI[NEI$fips == "24510" | NEI$fips == "06037",]
subset_data <- subset(cities, SCC %in% motor_list)

city_name = data.frame("fips" = c("06037", "24510"),
    "city_name" = c("Los Angeles","Baltimore"))

subset_data <- merge(subset_data,city_name)

sum_by_year <- aggregate(subset_data$Emissions, list(year = subset_data$year,
                                                     city_name = subset_data$city_name), FUN = sum)

qplot(year,x, data=sum_by_year, color=city_name, geom="line", ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Comparison of Total Emissions by County")
dev.copy(png,'plot6.png')
dev.off()