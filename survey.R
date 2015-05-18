#Libraries
library(plyr)

#Importing Data
	#Generic data import
	#data <- read.csv("file.csv", header = T)

data <- read.csv("~/Documents/Data/surveys/lessismore/Data_All_150518/CSV/final_data.csv", 
	header = T)

#Subsetting columns we care about
	#newdata <- X[,c(1, 14, 15)]

#Renaming if it's easier
	#names(newdata) <- c("Name", "Name2"...)

#Summaries for charts
	ddply(data, 2, summarise, n = length(LessIsMore))

#Establishing color spectrum
	cols <- c("#0484d9", "#00235f", "#d2d2d2", "#ef3e1b")

#Making the bar chart
barplot(data, 
	horiz = TRUE, 
	border = FALSE, 
	col = cols)
abline(v=seq(0,400, 20), col = "white")
#Saving the chart
dev.copy(png, "~/Documents/Projects/charts/resist_extra.png", width = 800, height = 350)