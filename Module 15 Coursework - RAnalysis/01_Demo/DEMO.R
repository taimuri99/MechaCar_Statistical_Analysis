#loading in our installed jsonlite package using the library(package)
library(jsonlite)

# Data manipulation - structures
# Practice
x <- 3
x <- 5
numlist <- c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9)
?read.csv()
# dataframes, tibbles, matrices possible : Console coding possible as well
# read.csv(), read.delim(), read.table()
?fromJSON()

# make sure files in active working directory, setwd("~/Desktop/REPEAT BOOTCAMP FOR SYNC/MechaCar_Statistical_Analysis/Module 15 Coursework - RAnalysis/01_Demo")

demo_table <- read.csv(file='demo.csv',check.names=F,stringsAsFactors = F)

demo_table2 <- fromJSON(txt='demo.json')

x <- c(3, 3, 2, 2, 5, 5, 8, 8, 9)
x[3]


# bracket notation to select data from two-dimensional data structures, such as matrices, data frames, and tibbles
demo_table[3,"Year"]
# using indices
demo_table[3,3]

#select columns from any two-dimensional R data structure as a single vector
demo_table$"Vehicle_Class"
#bracket notation to select a single value
demo_table$"Vehicle_Class"[2]

#Logic Operators to Select Data
# +	Addition operator
# -	Subtraction operator
# *	Multiplication operator
# /	Division operator
# ^ or **	Exponent operator
# %%	Modulus operator (finds the remainder of the first element divided by the second)
# <	Each element in the first data structure is less than each element in the second data structure
# <=	Each element in the first data structure is less than or equal to each element in the second data structure
# >	Each element in the first data structure is greater than each element in the second data structure
# >=	Each element in the first data structure is greater than or equal to each element in the second data structure
# ==	Each element in the first data structure is equal to each element in the second data structure
# !=	Each element in the first data structure is unequal to each element in the second data structure
# x|y	Element-wise OR operator—each element of x and y structures are combined and returns TRUE if either element is TRUE
# x&y	Element-wise AND operator—each element of x and y structures are combined and returns TRUE if both elements are TRUE
# x||y	Logical OR operator—the first element of x and y structures are combined and returns TRUE if either element is TRUE
# x&&y	Logical AND operator—the first element of x and y structures are combined and returns TRUE if either element is TRUE
# isTRUE(x)	Checks if the logic x is TRUE, otherwise FALSE
# x %in% y	Checks if x is contained within y.	x in y
# x:y	Creates a range of integer values from x to y


#Filter and subsetting data
filter_table <- demo_table2[demo_table2$price > 10000,]
# , subsets by rows
# Subsets
?subset()
filter_table2 <- subset(demo_table2, price > 10000 & drive == "4wd" & "clean" %in% title_status) #filter by price and drivetrain and status
# bracket notation of previous code
#filter_table3 <- demo_table2[("clean" %in% demo_table2$title_status) & (demo_table2$price > 10000) & (demo_table2$drive == "4wd"),]

#Sample data
?sample()
#sample a large vector and create a smaller vector, we can set the vector to "x":
sample(c("cow", "deer", "pig", "chicken", "duck", "sheep", "dog"), 4)


#sampling a two-dimensional data structure, we need to supply the index of each row we want to sample. This process can be completed in three steps:
#Create a numerical vector that is the same length as the number of rows in the data frame using the colon (:) operator.
#Use the sample() function to sample a list of indices from our first vector.
#Use bracket notation to retrieve data frame rows from sample list.
demo_table[sample(1:nrow(demo_table), 3),]



#Transform, Group, and Reshape Data Using the Tidyverse Package
#dplyr library transforms R data.
#chain together functions in a single statement using their own pipe operator (%>%).
#transform a data frame and include new calculated data columns, we'll use the mutate() function
#install.packages('tidyverse')

library(tidyverse)
?mutate()

demo_table <- demo_table %>% mutate(Mileage_per_Year=Total_Miles/(2020-Year),IsActive=TRUE) #add columns to original data frame

#Group Data
#group_by() function tells dplyr which factor (or list of factors in order) to group our data frame by.
#summarize() function to create columns in our summary data frame
#group our used car data by the condition of the vehicle and determine the average mileage per condition
summarize_demo <- demo_table2 %>% group_by(condition) %>% summarize(Mean_Mileage=mean(odometer), .groups = 'keep') #create summary table

#statistics mean(), median(), sd(), min(), max(), and n() (used to calculate the number of rows in each category)

summarize_demo <- demo_table2 %>% group_by(condition) %>% summarize(Mean_Mileage=mean(odometer),Maximum_Price=max(price),Num_Vehicles=n(), .groups = 'keep') #create summary table with multiple columns

#summarize() function takes an additional argument, .groups. This allows you to control the the grouping of the result. The four possible values are:

# .groups = "drop_last" drops the last grouping level (default)
# .groups = "drop" drops all grouping levels and returns a tibble
# .groups = "keep" preserves the grouping of the input
# .groups = "rowwise" turns each row into its own group

#Reshape Data
?gather()
?spread()

#pivot_longer() lengthens the data by increasing the number rows and decreasing the number of columns
#pivot_wider() will perform an inverse transformation.

demo_table3 <- read.csv('demo2.csv',check.names = F,stringsAsFactors = F)
long_table <- gather(demo_table3,key="Metric",value="Score",buying_price:popularity)
#long_table <- demo_table3 %>% gather(key="Metric",value="Score",buying_price:popularity)

#collapsed all of the survey metrics into one Metric column and all of the values into a Score column. Because the Vehicle column was not in the arguments, it was treated as an identifier column and added to each row as a unique identifier
# the inverse is:

wide_table <- long_table %>% spread(key="Metric",value="Score")

#compare two data frames that you expect to be equal, and the all.equal() function
all.equal(demo_table3,wide_table)

#Test 1
table <-demo_table3[,order(colnames(wide_table))]
all.equal(table,wide_table)

#Test2
table <- demo_table3[,(colnames(wide_table))]
all.equal(table,wide_table)


#GGPLOT2



