#################################################################################################################
# JHU Data Science Series - Exploratory Data Analysis - Project 2 
#
# Question 5:
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
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
# subset data with Baltimore
#
NEI_Baltimore <- subset(NEI, NEI$fips=="24510")


#
# subset data with vehicles sectors
#
vehicles_index <- grepl("vehicles", SCC[, "EI.Sector"], ignore.case=TRUE) 
vehiclesSCC <- SCC[vehicles_index, 'SCC']
vehiclesNEI <- NEI_Baltimore[NEI_Baltimore$SCC %in% vehiclesSCC, ]


#
# sum Emissions on year, round result to 2 digits decimal for displaying purpose
#
vehiclesNEI_sum <- aggregate(Emissions~year, vehiclesNEI,sum)
vehiclesNEI_sum <- transform(vehiclesNEI_sum, Emissions = round(Emissions,2)) 


#
# plot sum of emissions
#
gg=ggplot(vehiclesNEI_sum,aes(factor(year),Emissions,label= Emissions, fill=year))
gg= gg + geom_bar(stat = "identity", width=0.75) 
gg= gg + xlab("Year") + ylab(expression('PM'[2.5]*' Emission in Tons')) 
gg=gg+geom_label(aes(fill = year), colour = "white", fontface = "bold", show.legend=FALSE)
gg= gg + ggtitle("Baltimore Vehicle Emissions, 1999 to 2008") 


png("plot5.png", width = 480, height = 480)
print(gg)
dev.off()
