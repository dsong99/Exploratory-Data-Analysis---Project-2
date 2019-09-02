#################################################################################################################
# JHU Data Science Series - Exploratory Data Analysis - Project 2 
#
# Question 2:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.
################################################################################################################# 


#
# assume the data files are under current working diretory, if not, 
# use setwd() to change to the directory contains the date files
#


#
# read data files
#
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#
# subset data with Baltimore
#
NEI_Baltimore <- subset(NEI, NEI$fips=="24510")
NEI_Baltimore <- transform(NEI_Baltimore, SCC = factor(SCC))
NEI_Baltimore <- transform(NEI_Baltimore, year = factor(year))

#
# sum Emissions on each year
#
total_emissions_years <- aggregate(Emissions ~ year,NEI_Baltimore, sum)


#
# plot emissions 
#
png(file="plot2.png", width = 480, height = 480)
barplot(total_emissions_years$Emissions,  xlab="Year", col = "steelblue", ylab="PM2.5 Emissions", main = "Baltimore City PM2.5 Emissions in 1999, 2002, 2005,2008 ", names.arg = total_emissions_years$year)
dev.off()
