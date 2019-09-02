#################################################################################################################
# JHU Data Science Series - Exploratory Data Analysis - Project 2 
#
# Question 3:
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these 
# four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in 
# emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
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
# plot emissions separated by type 
#
gg=ggplot(NEI_Baltimore,aes(factor(year),Emissions,fill=type)) 
gg= gg + geom_bar(stat = "identity") 
gg= gg + facet_grid(.~type) 
gg= gg + xlab("Year") + ylab(expression('PM'[2.5]*' Emission')) 
gg= gg + ggtitle("Baltimore Emissions by Source Type in 1999-2008") 

png("plot3.png", width = 900, height = 900)
print(gg)
dev.off()
