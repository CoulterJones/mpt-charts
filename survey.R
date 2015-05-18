#Library
library(plyr)

#Importing data
data <- read.csv("~/Desktop/Results-final/CSV/fixed.csv", header=T)

chart <- ddply(data, "RefusingPatients", summarise, n = length(RefusingPatients))

refusing <- ddply(data, "RefusingPatients", summarise, n = length(RefusingPatients))

pie(chart$n, labels = "", col = c('grey85', 'midnightblue'), border = FALSE)



#Creating the 
years <- ddply(data, "PracticeYears", summarise, n = length(PracticeYears))


#Removing the extra year
years <- years[-c(1, 5), ]


#Fixing the problems of the data being out of order. 
#Adding a record
new <- c("Eleven (11) to Fifteen (15) years",  66)

#Binding the new data 
years = rbind(years,new)

new <- c("Sixteen (16) years or more", 399)

#Binding the new data 
years = rbind(years,new)

years$n <- as.numeric(years$n)


#Plotting the barchart
barplot(years$n, border = FALSE)



pie(chart$n, labels = "", col = c('grey85', 'midnightblue'), border = FALSE)
dev.copy(png, '~/Documents/Code/yesno.png')

pie(altered$n, labels = "", col = c('grey85', 'midnightblue'), border = FALSE)

dev.copy(png, '~/Documents/Code/altered.png')


patientq <- ddply(data, "PatientQuestionOthers", summarise, n = length(PatientQuestionOthers))
