#Load the text file of income data

?read.table
data <- read.table(file="zipIncome.txt", sep="|", header=TRUE, nrows=32038)
head(data, n=10)

#Change the column names of your data frame so that 
#zip_Prefix becomes zipCode and meanhouseholdincome becomes income

#str(data)
#names(data)
#summary(data)

colnames(data) <- c('zipCode', 'income')

names(data)

#Analyze the summary of your data. 
#What are the mean and median average incomes?

summary(data)
print(mean(data$income))

#  Plot a scatter plot of the data. 
#Although this graph is not too informative, 
#do you see any outlier values? If so, what are they?

plot(data$zipCode, data$income, main = "Average Household Income by Zip Code", xlab = "Zip Codes", ylab = "Income")

#In order to omit outliers, create a subset of the data so that:
#$7,000 < income < $200,000

#head(data[(data$income <  200000) & (data$income > 7000), 1:2])

data_clear <- data[(data$income <  200000) & (data$income > 7000), 1:2]

#What’s your new mean?
summary(data_clear)
mean(data_clear$income)

#   Create a simple box plot of your data. Be sure to add a title and label the axes.

?boxplot

#boxplot(income ~ as.factor(zipCode), col = "white", data = data_clear, main = "Average Household Income by Zip Code", xlab = "Zip Codes", ylab = "Income")

boxplot(income ~ zipCode, col = "white", data = data_clear, main = "Average Household Income by Zip Code", xlab = "Zip Codes", ylab = "Income")
#In the box plot you created, notice that all of the 
#income data is pushed towards the bottom of the graph 
#because most average incomes tend to be low. Create a new box plot
#where the y-axis uses a log scale. Be sure to add a title and label
#the axes.



boxplot(income ~ as.factor(zipCode), data=data_clear,
        main = "Average Household Income by Zip Code", xlab = "Zip Codes", ylab = "Income",
        log = "y", col = "white")


#Use the ggplot library in R, which enables you to create graphs 
#with several different types of plots layered over each other.
#Be sure to read the documentation for ggplot and 
#load the library ggplot2 (you may have to install this package into R).


install.packages("ggplot2")
library(ggplot2)

#f.        Make a ggplot that consists of just a scatter plot using
#the function geom_point() with position = “jitter” so that the data 
#points are grouped by zip code. Be sure to use ggplot’s function for 
#taking the log10 of the y-axis data. (Hint: for geom_point, have alpha=0.2).

?ggplot
?geom_point

ggplot(data = data_clear,  mapping = aes(x=zipCode, y=income)) + geom_point(position = "jitter", alpha=0.2) + scale_y_continuous(trans = "log10")  + xlab("Zip Code") + ylab("Income") + ggtitle("Average Income by Zip Code")


#g.        Create a new ggplot by adding a box plot layer to your
#previous graph. To do this, add the ggplot function geom_boxplot(). 
#Also, add color to the scatter plot so that data points between 
#different zip codes are different colors. Be sure to label the axes 
#and add a title to the graph.

?geom_boxplot




ggplot(data = data_clear,  mapping = aes(x=as.factor(zipCode), y=income)) + geom_point(aes(colour=factor(zipCode)), position="jitter", alpha=0.2) + geom_boxplot(alpha=0.1, outlier.size=-Inf) + scale_y_continuous(trans = "log10") + xlab("Zip Code") + ylab("Income") + labs(color='Region')+ ggtitle("Average Income by Zip Code")


save.image()
load(".RData")






