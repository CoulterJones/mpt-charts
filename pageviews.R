#Libraries used for this analysis
library(ggplot2) #Wickham's charting library.
library(plyr) #Used for ddply
library(lattice)
library(stringr)
library(zoo) #Another date library, which I don't think was actually used in this script.
library(lubridate) #Amazing date library
library(dichromat) #Colorblind friendly library

#Setting working directory
setwd("~/Documents/MedPageToday/analytics")

#Importing the data 
data <- read.csv("articles.csv", header = T)

#Checking structure of the data
str(data)

#Create a date field -- Note how the data is separated by periods and not the normal structure
data$DateFixed <- as.Date(data$Date, "%m.%d.%Y") 


#Create a month field that we will use for our X-axis. as.yearmon creates a class that displays as "Jan, etc. "" I belive this is zoo's library.
data$DateMonth <- as.numeric(as.yearmon(data$DateFixed))

#using lubridate you can do things like  this
	# month(head(data$DateFixed)
	# year(head(data$DateFixed)

#Uses lubridate to create a year here
data$Quarter <- quarter(data$DateFixed, with_year = TRUE)

#This is the aggregate data for the article types by month
totalmonths <- ddply(data, c("Type.Grouped", "DateMonth"), summarise, hcp = sum(HCP.PVs), arts = length(Type.Grouped))
#This is the aggregate data for the article types by quarter
totalquarter <- ddply(data, c("Type.Grouped", "Quarter"), summarise, hcp = sum(HCP.PVs), arts = length(Type.Grouped))


#Because we created two different summary files with all the data we need, these four plots all work fine together. It's a lot of duplicative code.

#Plotting page views by Quarter
ggplot(totalquarter, aes(x= Quarter, y = hcp, fill=Type.Grouped)) + 
	#geom area, ensuring a black line
	geom_area(color = "black", size=.1) + 
	#manually changing the color scheme
	scale_fill_manual(values=c("red", "purple", "deepskyblue", "black", "orange", "gray", "white", "dodgerblue4", "green", "azure4")) + 
	#manually change the names
	labs(title = "HCP Page Views \nby Article Type\n2013-2014", x = "Total By Quarter", y = "HCP Page Views")

#This is to save out a copy to my desktop
dev.copy(png, "viewbyquarter.png", width = 800, height = 350)


#Plotting page vies by MOnth
ggplot(totalmonths, aes(x= DateMonth, y = hcp, fill=Type.Grouped)) + 
	#geom area, ensuring a black line
	geom_area(color = "black", size=.1) + 
	#manually changing the color scheme
	scale_fill_manual(values=c("red", "purple", "deepskyblue", "black", "orange", "gray", "white", "dodgerblue4", "green", "azure4")) + 
	#manually change the names
	labs(title = "HCP Page Views \nby Article Type\n2013-2014", x = "Total By Month", y = "HCP Page Views")

#This is to save out a copy to my desktop
dev.copy(png, "viewbymonth.png", width = 800, height = 350)

#Plotting articles produced by quarter 
ggplot(totalquarter, aes(x= Quarter, y = arts, fill=Type.Grouped)) + 
	#geom area, ensuring a black line
	geom_area(color = "black", size=.1) + 
	#manually changing the color scheme
	scale_fill_manual(values=c("red", "purple", "deepskyblue", "black", "orange", "gray", "white", "dodgerblue4", "green", "azure4")) + 
	#manually change the names
	labs(title = "Articles produced \nby Type 2013-2014", x = "Total By Quarter", y = "Total Articles")

#This is to save out a copy to my desktop
dev.copy(png, "articlesbyquarter.png", width = 800, height = 350)



#Plotting articles produced by month 
ggplot(totalmonths, aes(x= DateMonth, y = arts, fill=Type.Grouped)) + 
 	#geom area, ensuring a black line
 	geom_area(color = "black", size=.1) + 
 	#manually changing the color scheme
 	scale_fill_manual(values=c("red", "purple", "deepskyblue", "black", "orange", "gray", "white", "dodgerblue4", "green", "azure4")) + 
 	#manually change the names
 	labs(title = "Articles produced \nby Type 2013-2014", x = "Total By Month", y = "HCP Page Views")

#This is to save out a copy to my desktop
dev.copy(png, "articlesbymonth.png", width = 800, height = 350)





