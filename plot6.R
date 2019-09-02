#################################################################################################################
# JHU Data Science Series - Exploratory Data Analysis - Project 2 
#
# Question 6:
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor 
# vehicle emissions?
################################################################################################################# 

#
# assume the data files are under current working diretory, if not, 
# use setwd() to change to the directory contains the date files
#

library(ggplot2)


#
# read data files
#
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#
# subset data with Baltimore and Los Angels, add county column.
#
subNEI <- subset(NEI, NEI$fips %in% c("24510", "06037"))
subNEI <- transform(subNEI, county=ifelse(fips==24510, 'Baltimore', 'Los Angeles'))


#
# subset data with vehicles sectors
#
vehicles_index <- grepl("vehicles", SCC[, "EI.Sector"], ignore.case=TRUE) 
vehiclesSCC <- SCC[vehicles_index, 'SCC']
vehiclesNEI <- subNEI[subNEI$SCC %in% vehiclesSCC, ]

#
# sum Emissions on County, year; then change emissions unit to kiloton
#
vehiclesNEI_sum <- with(vehiclesNEI, aggregate(Emissions, by=list(county=county,year=year), sum))
colnames(vehiclesNEI_sum )[3] = 'Emissions'
vehiclesNEI_sum <- transform(vehiclesNEI_sum, Emissions = round(Emissions/1000,2)) 


#
# plot sum of emissions, separated by counties
#
gg=ggplot(vehiclesNEI_sum,aes(factor(year),Emissions,label= Emissions, fill=year))
gg= gg + geom_bar(stat = "identity", width=0.75) + facet_grid(. ~ county)
gg= gg + xlab("Year") + ylab(expression('PM'[2.5]*' Emission in Kilotons')) 
gg= gg + geom_label(aes(fill = year), colour = "white", fontface = "bold", show.legend=FALSE)
gg= gg + ggtitle("Baltimore vs Los Angeles Vehicle Emissions, 1999 to 2008") 


png("plot6.png", width = 900, height = 900)
print(gg)
dev.off()
