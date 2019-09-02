#################################################################################################################
# JHU Data Science Series - Exploratory Data Analysis - Project 2 
#
# Question 4:
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
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
# subset data with coal combustion-related sources
#
comb_coal_index <- grepl("comb.*coal", SCC[, "EI.Sector"], ignore.case=TRUE) 
combCoalSCC <- SCC[comb_coal_index, 'SCC']
combCoalNEI <- NEI[NEI$SCC %in% combCoalSCC, ]


#
# sum Emissions on year; then change emissions unit to kiloton for displaying purpose
#
combCoalNEI <- aggregate(Emissions~year, combCoalNEI,sum)
combCoal_sum <- transform(combCoalNEI, Emissions = round(Emissions/1000,2)) 


#
# plot sum of emissions
#
gg=ggplot(combCoal_sum,aes(factor(year),Emissions,label= Emissions, fill=year))
gg= gg + geom_bar(stat = "identity", width=0.75) 
gg= gg + xlab("Year") + ylab(expression('PM'[2.5]*' Emission in Kilotons')) 
gg=gg+geom_label(aes(fill = year), colour = "white", fontface = "bold", show.legend=FALSE)
gg= gg + ggtitle("Coal Combustion Emissions in 1999-2008") 


png("plot4.png", width = 480, height = 480)
print(gg)
dev.off()

