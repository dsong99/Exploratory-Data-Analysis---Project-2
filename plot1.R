#################################################################################################################
# JHU Data Science Series - Exploratory Data Analysis - Project 2 
#
# Question 1:
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting 
# system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, 
# and 2008.
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
# convert SCC, year columns to factors
#
NEI <- transform(NEI, SCC = factor(SCC))
NEI <- transform(NEI, year = factor(year))

#
# sum Emissions on each year
#
total_emissions_years <- aggregate(Emissions ~ year,NEI, sum)


#
# plot emissions 
#
png(file="plot1.png", width = 480, height = 480)
barplot(total_emissions_years$Emissions,  xlab="Year", ylab="PM2.5 Emissions", col="steelblue", main = "PM2.5 Emissions in 1999, 2002, 2005,2008 ", names.arg = total_emissions_years$year)
dev.off()