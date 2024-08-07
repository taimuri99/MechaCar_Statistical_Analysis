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
#ggplot function—tells ggplot2 what variables to use
#geom function—tells ggplot2 what plots to generate
?ggplot()
#aes() arguments to assign such as color, fill, shape, and size to customize the plots

#Bar PLot
head(mpg)
plt <- ggplot(mpg,aes(x=class)) #import dataset into ggplot2
plt + geom_bar() #plot a bar plot
?geom_bar()

#compare and contrast categorical results
#compare the number of vehicles from each manufacturer in the dataset
#summarize() data, and ggplot2's geom_col() to visualize the results

mpg_summary <- mpg %>% group_by(manufacturer) %>% summarize(Vehicle_Count=n(), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary,aes(x=manufacturer,y=Vehicle_Count)) #import dataset into ggplot2
plt + geom_col() #plot a bar plot

#geom_bar() and geom_col()create bar plots; however, the two methods assume different inputs. geom_bar() expects one variable and generates frequency data, and geom_col()expects two variables where we provide the size of each category's bar

#Formatting
#titles of our x-axis and y-axis, we can use the xlab()and ylab()functions, respectively:
plt + geom_col() + xlab("Manufacturing Company") + ylab("Number of Vehicles in Dataset") #plot bar plot with labels

plt + geom_col() + xlab("Manufacturing Company") + ylab("Number of Vehicles in Dataset") + #plot a boxplot with labels
theme(axis.text.x=element_text(angle=45,hjust=1)) #rotate the x-axis label 45 degrees

#hjust argument tells ggplot that our rotated labels should be aligned horizontally to our tick marks.
#Similarly, if we want to adjust our y-axis labels, we would do so by using the axis.text.y argument of the theme()

#Line PLot
#compare the differences in average highway fuel economy (hwy) of Toyota vehicles as a function of the different cylinder sizes (cyl), our R code would look like the following:
mpg_summary <- subset(mpg,manufacturer=="toyota") %>% group_by(cyl) %>% summarize(Mean_Hwy=mean(hwy), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary,aes(x=cyl,y=Mean_Hwy)) #import dataset into ggplot2
plt + geom_line()

#adjust the x-axis and y-axis tick values, we'll use the scale_x_discrete() and scale_y_continuous() functions
plt + geom_line() + scale_x_discrete(limits=c(4,6,8)) + scale_y_continuous(breaks = c(15:30)) #add line plot with labels
#The scale_x_discrete() function tells ggplot to use explicit values for the x-axis ticks
#scale_x_discrete() function will generate x-axis ticks for each value in a list
#scale_y_continuous()function tells ggplot to rescale the y-axis based on a defined range, here from 15 through 30 using breaks = c(15:30).


#Scatter Plot
plt <- ggplot(mpg,aes(x=displ,y=cty)) #import dataset into ggplot2
plt + geom_point() + xlab("Engine Size (L)") + ylab("City Fuel-Efficiency (MPG)") #add scatter plot with labels
#alpha changes the transparency of each data point
#color changes the color of each data point
#shape changes the shape of each data point
#size changes the size of each data point

plt <- ggplot(mpg,aes(x=displ,y=cty,color=class)) #import dataset into ggplot2
plt + geom_point() + labs(x="Engine Size (L)", y="City Fuel-Efficiency (MPG)", color="Vehicle Class") #add scatter plot with labels

#labs() function, which lets you customize your axis labels as well as any grouping variable labels
plt <- ggplot(mpg,aes(x=displ,y=cty,color=class,shape=drv)) #import dataset into ggplot2
plt + geom_point() + labs(x="Engine Size (L)", y="City Fuel-Efficiency (MPG)", color="Vehicle Class",shape="Type of Drive") #add scatter plot with multiple aesthetics

#City Fuel-Efficiency (MPG) to determine the size of the data point
plt <- ggplot(mpg,aes(x=displ,y=cty,color=class,shape=drv,size=cty)) #import dataset into ggplot2
plt + geom_point() + labs(x="Engine Size (L)", y="City Fuel-Efficiency (MPG)", color="Vehicle Class",shape="Type of Drive") #add scatter plot with multiple aesthetics

# Box Plots
#boxplot to visualize the highway fuel efficiency of our mpg dataset, our R code would look as follows:
plt <- ggplot(mpg,aes(y=hwy)) #import dataset into ggplot2
plt + geom_boxplot() #add boxplot

#compares highway fuel efficiency for each car manufacturer
plt <- ggplot(mpg,aes(x=manufacturer,y=hwy)) #import dataset into ggplot2
plt + geom_boxplot() + theme(axis.text.x=element_text(angle=45,hjust=1)) #add boxplot and rotate x-axis labels 45 degrees

#compares highway fuel efficiency for each car manufacturer with formatting
plt <- ggplot(mpg,aes(x=manufacturer,y=hwy)) #import dataset into ggplot2
plt + geom_boxplot(fill = "white", colour = "#3366FF", outlier.colour = "red", outlier.shape = 1) + theme(axis.text.x=element_text(angle=45,hjust=1)) #add boxplot and rotate x-axis labels 45 degrees

#Create Heatmap Plots
#visualize the average highway fuel efficiency across the type of vehicle class from 1999 to 2008, our R code would look as follows:
mpg_summary <- mpg %>% group_by(class,year) %>% summarize(Mean_Hwy=mean(hwy), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary, aes(x=class,y=factor(year),fill=Mean_Hwy))
plt + geom_tile() + labs(x="Vehicle Class",y="Vehicle Year",fill="Mean Highway (MPG)") #create heatmap with labels

#difference in average highway fuel efficiency across each vehicle model from 1999 to 2008, our R code would look as follows:
mpg_summary <- mpg %>% group_by(model,year) %>% summarize(Mean_Hwy=mean(hwy), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary, aes(x=model,y=factor(year),fill=Mean_Hwy)) #import dataset into ggplot2
plt + geom_tile() + labs(x="Model",y="Vehicle Year",fill="Mean Highway (MPG)") + #add heatmap with labels
  theme(axis.text.x = element_text(angle=90,hjust=1,vjust=.5)) #rotate x-axis labels 90 degrees

#Add Layers
#recreate our previous boxplot example comparing the highway fuel efficiency across manufacturers, add our data points using the geom_point() function:
plt <- ggplot(mpg,aes(x=manufacturer,y=hwy)) #import dataset into ggplot2
plt + geom_boxplot() + #add boxplot
  theme(axis.text.x=element_text(angle=45,hjust=1)) + #rotate x-axis labels 45 degrees
geom_point() #overlay scatter plot on top


#Mapping Function
#compare average engine size for each vehicle class? In this case, we would supply our new data and variables directly to our new geom function using the optional mapping and data arguments.
#mapping argument uses the aes() function to identify the variables to use. Additionally, the data argument can be used to provide a new input data structure; otherwise, the mapping function will reference the data structure provided in the ggplot object.
mpg_summary <- mpg %>% group_by(class) %>% summarize(Mean_Engine=mean(displ), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary,aes(x=class,y=Mean_Engine)) #import dataset into ggplot2
plt + geom_point(size=4) + labs(x="Vehicle Class",y="Mean Engine Size") #add scatter plot

#compute the standard deviations in our dplyr summarize() function, we can layer the upper and lower standard deviation boundaries to our visualization using the geom_errorbar() function:
mpg_summary <- mpg %>% group_by(class) %>% summarize(Mean_Engine=mean(displ),SD_Engine=sd(displ), .groups = 'keep')
plt <- ggplot(mpg_summary,aes(x=class,y=Mean_Engine)) #import dataset into ggplot2
plt + geom_point(size=4) + labs(x="Vehicle Class",y="Mean Engine Size") + #add scatter plot with labels
  geom_errorbar(aes(ymin=Mean_Engine-SD_Engine,ymax=Mean_Engine+SD_Engine)) #overlay with error bars


#data is in a long format, avoid visualizing all data within a single plot
#plot all our measurements but keep each level (or category) of our grouping variable separate
#separating out plots for each level is known as faceting in ggplot2.
#facet()
mpg_long <- mpg %>% gather(key="MPG_Type",value="Rating",c(cty,hwy)) #convert to long format
head(mpg_long)
plt <- ggplot(mpg_long,aes(x=manufacturer,y=Rating,color=MPG_Type)) #import dataset into ggplot2
plt + geom_boxplot() + theme(axis.text.x=element_text(angle=45,hjust=1)) #add boxplot with labels rotated 45 degrees

#produced boxplot is optimal for comparing the city versus highway fuel efficiency for each manufacturer, but it is more difficult to compare all of the city fuel efficiency across manufacturers.
?facet_wrap()
plt <- ggplot(mpg_long,aes(x=manufacturer,y=Rating,color=MPG_Type)) #import dataset into ggplot2
plt + geom_boxplot() + facet_wrap(vars(MPG_Type)) + #create multiple boxplots, one for each MPG type
theme(axis.text.x=element_text(angle=45,hjust=1),legend.position = "none") + xlab("Manufacturer") #rotate x-axis labels
#comparisons across manufacturers


#STATISTISTICAL TESTS
#tests, distributions, statistical analysis, head(), CLT

#Normality Test
#distribution of vehicle weights from the built-in mtcars dataset, our R code would be as follows:
  
ggplot(mtcars,aes(x=wt)) + geom_density() #visualize distribution using density plot
#geom_density() function plots a numerical vector by creating buckets of similar values and calculating the density (number of bucket data points/total number of data points) for each bucket

#Quant Tests for Normality
#quantitative test for normality uses a statistical test to quantify the probability of whether or not the test data came from a normally distributed dataset.
#Shapiro-Wilk test for normality
?shapiro.test()
shapiro.test(mtcars$wt)
#p-value is greater than 0.05, the data is considered normally distributed

#SKEW
#asymmetrical distribution is commonly referred to as a skewed distribution
#left skewed, or negative skewed, if the left tail is longer than the right
#data is skewed left, from the center of the distribution curve, there is a higher probability that extreme negative values exist within our dataset. When this occurs, the mean may no longer accurately reflect the central tendency of the data. Instead, we would use the median to describe the central tendency of the data. This skew is called negative skewed

# right skewed, or positive skewed, if the right tail is longer than the left
#data is skewed right, from the center of the distribution curve, there is a higher probability that extreme positive values exist within our dataset. Once again, if this occurs, we would use the median to describe the central tendency of the data. This skew is called positive skewed.

#Solution
#add data points
#resample or regenerate data
#Transform our data values by normalization - log transform

#Hypothesis Testing
#the null hypothesis is also known as H0 and is generally the hypothesis that can be explained by random chance.
#The alternate hypothesis is also known as Ha and is generally the hypothesis that is influenced by non-random events.


# Generate a null hypothesis, its corresponding alternate hypothesis, and the significance level.
# Identify a statistical analysis to assess the truth of the null hypothesis.
# Compute the p-value using statistical analysis.
# Compare p-value to the significance level.
# Reject (or fail to reject) the null hypothesis and generate the conclusion.

#compare the p-value against a significance level. A significance level (also denoted as alpha or ɑ) is a predetermined cutoff for our hypothesis test
# sig level of 0.0N means N in 100 chance its wrong

#one-tailed hypothesis is only describing one side of the distribution. One-tailed hypotheses use descriptions such as "x is greater than y" or "x is less than or equal to y."
#Alternatively, two-tailed hypotheses describe both sides of the distribution and use descriptions such as "equal to" or "not equal to."

#If our hypotheses and statistical test are both two-tailed, use the statistical test p-value as is.
#If our hypotheses are one-tailed, but our statistical test is two-tailed, divide the statistical test p-value by 2.

# pval < sig level reject bull hyp
# pval > fail to reject null hyp

#Errors in Hyp Testing
#Type I error (also known as a false positive error)—an error in which we reject the null hypothesis when it is actually true. In other words, the observations and measurements used in our statistical test should have been attributed to random chance, but we attributed them to something else.
#Type II error (also known as a false negative error)—an error in which we fail to reject the null hypothesis when it is actually false. In other words, our analysis demonstrates that the observations were due to random chance, but they were not. The observations and measurements used in our statistical test failed to reflect an external force or influence to our problem.

#A type I error can be limited by making your significance level smaller. A smaller significance level makes it harder to accidentally reject the null hypothesis when the data was truly random. This is also why our significance level (alpha or ɑ) is sometimes referred to as our false positive rate.
#A type II error can be limited by increasing the power of the analysis. Although performing a power analysis is outside the scope of the course, power can be increased by adding additional measurements or observations to our analysis.


#SAMPLE VS POP
#Random sampling is a technique in data science in which every subject or data point has an equal chance of being included in the sample
# pop - all, sample - part
#sample data from a numerical vector - sample() function
#sample_n() function to select sample data from a two-dimensional data object
?sample_n()
#use a dplyr pipe (%>%) to provide the data frame object directly

population_table <- read.csv('used_car_data.csv',check.names = F,stringsAsFactors = F) #import used car dataset
plt <- ggplot(population_table,aes(x=log10(Miles_Driven))) #import dataset into ggplot2
plt + geom_density() #visualize distribution using density plot
#transform our miles driven using a log10 transformation

#create sampled dataset
sample_table <- population_table %>% sample_n(50) #randomly sample 50 data points
plt <- ggplot(sample_table,aes(x=log10(Miles_Driven))) #import dataset into ggplot2
plt + geom_density() #visualize distribution using density plot

#1 sample t-test
# students t test
# H0 : There is no statistical difference between the observed sample mean and its presumed population mean.
# Ha : There is a statistical difference between the observed sample mean and its presumed population mean.

# requirements
# The input data is numerical and continuous. This is because we are testing the distribution of two datasets.
# The sample data was selected randomly from its population data.
# The input data is considered to be normally distributed.
# The sample size is reasonably large. Generally speaking, this means that the sample data distribution should be similar to its population data distribution.
# The variance of the input data should be very similar.
?t.test()

#test if the miles driven from our previous sample dataset is statistically different from the miles driven in our population data
  
t.test(log10(sample_table$Miles_Driven),mu=mean(log10(population_table$Miles_Driven))) #compare sample versus population means

# 2 sample t-test
#two-sample t-Test determines whether the means of two samples are statistically different. In other words, a two-sample t-Test is used to test the following hypotheses:
#H0 : There is no statistical difference between the two observed sample means.
#Ha : There is a statistical difference between the two observed sample means.

#Assumptions
# The input data is numerical and continuous.
# Each sample data was selected randomly from the population data.
# The input data is considered to be normally distributed.
# Each sample size is reasonably large. Generally speaking, this means that the sample data distribution should be similar to its population data distribution.
# The variance of the input data should be very similar.
# same t.test function but arguments different


#mean miles driven of two samples from our used car dataset are statistically different.
#create two samples

sample_table <- population_table %>% sample_n(50) #generate 50 randomly sampled data points
sample_table2 <- population_table %>% sample_n(50) #generate another 50 randomly sampled data points
t.test(log10(sample_table$Miles_Driven),log10(sample_table2$Miles_Driven)) #compare means of two samples


# 2 sample t-test compare samples
#to compare two samples, each from a different population

#pair t-test, 
#because we pair observations in one dataset with observations in another.

#EX
#Comparing measurements on the same subjects across a single span of time (e.g., fuel efficiency before and after an oil change)
#Comparing different methods of measurement (e.g., testing tire pressure using two different tire pressure gauges)

#H0 : The difference between our paired observations (the true mean difference, or "μd") is equal to zero.
#Ha : The difference between our paired observations (the true mean difference, or "μd") is not equal to zero.

mpg_data <- read.csv('mpg_modified.csv') #import dataset
mpg_1999 <- mpg_data %>% filter(year==1999) #select only data points where the year is 1999
mpg_2008 <- mpg_data %>% filter(year==2008) #select only data points where the year is 2008

#statistical difference in overall highway fuel efficiency between vehicles manufactured in 1999 versus 2008?

t.test(mpg_1999$hwy,mpg_2008$hwy,paired = T) #compare the mean difference between two samples


#ANOVA TEST
#analysis of variance (ANOVA) test, which is used to compare the means of a continuous numerical variable across a number of groups
#A one-way ANOVA is used to test the means of a single dependent variable across a single independent variable with multiple groups. (e.g., fuel efficiency of different cars based on vehicle class).
#A two-way ANOVA does the same thing, but for two different independent variables (e.g., vehicle braking distance based on weather conditions and transmission type).

#H0 : The means of all groups are equal, or µ1 = µ2 = … = µn.
#Ha : At least one of the means is different from all other groups.

# Conditions
# The dependent variable is numerical and continuous, and the independent variables are categorical.
# The dependent variable is considered to be normally distributed.
# The variance among each group should be very similar.

?aov()
#all of the observations and grouping information are contained within a single data frame

#"Is there any statistical difference in the horsepower of a vehicle based on its engine type?"
#horsepower (the "hp" column) will be our dependent, measured variable
#number of cylinders (the "cyl" column) will be our independent, categorical variable.

#need categorical vector
mtcars_filt <- mtcars[,c("hp","cyl")] #filter columns from mtcars dataset
mtcars_filt$cyl <- factor(mtcars_filt$cyl) #convert numeric column to factor
aov(hp ~ cyl,data=mtcars_filt) #compare means across multiple levels
#get pvalue
summary(aov(hp ~ cyl,data=mtcars_filt))


#Correlation
#relationship between variable A and variable B
#Pearson correlation coefficient - r (-1 -> 0 -> +1)
# r=1 ideal positive correlation , r= -1 ideal negative, r = 0 no correlation
?cor()
#x,y var
head(mtcars)
plt <- ggplot(mtcars,aes(x=hp,y=qsec)) #import dataset into ggplot2
plt + geom_point() #create scatter plot
#vehicle horsepower increases, vehicle quarter-mile time decreases
cor(mtcars$hp,mtcars$qsec) #calculate correlation coefficient


used_cars <- read.csv('used_car_data.csv',stringsAsFactors = F) #read in dataset
head(used_cars)
plt <- ggplot(used_cars,aes(x=Miles_Driven,y=Selling_Price)) #import dataset into ggplot2
plt + geom_point() #create a scatter plot
cor(used_cars$Miles_Driven,used_cars$Selling_Price) #calculate correlation coefficient
#negligible correlation


#correlation matrix is a lookup table where the variable names of a data frame are stored as rows and columns, and the intersection of each variable is the corresponding Pearson correlation coefficient
used_matrix <- as.matrix(used_cars[,c("Selling_Price","Present_Price","Miles_Driven")]) #convert data frame into numeric matrix
cor(used_matrix)


#Linear Regression
#y=mx+b
# y - dep, x - indep
#The job of a linear regression analysis is to calculate the slope and y intercept values (also known as coefficients) that minimize the overall distance between each data point from the linear model.
#Simple linear regression builds a linear regression model with one independent variable.
#Multiple linear regression builds a linear regression model with two or more independent variables.
#linear regression asks if we can predict values for variable A using a linear model and values from variable B.
#H0 : The slope of the linear model is zero, or m = 0
#Ha : The slope of the linear model is not zero, or m ≠ 0
#r-squared (r2) value is also known as the coefficient of determination
# probability metric to determine the likelihood that future data points will fit the linear model.
?lm()
# The input data is numerical and continuous.
# The input data should follow a linear pattern.
# There is variability in the independent x variable. This means that there must be more than one observation in the x-axis and they must be different values.
# The residual error (the distance from each data point to the line) should be normally distributed.

lm(qsec ~ hp,mtcars) #create linear model
summary(lm(qsec~hp,mtcars)) #summarize linear model


model <- lm(qsec ~ hp,mtcars) #create linear model
yvals <- model$coefficients['hp']*mtcars$hp + model$coefficients['(Intercept)'] #determine y-axis values from linear model
plt <- ggplot(mtcars,aes(x=hp,y=qsec)) #import dataset into ggplot2
plt + geom_point() + geom_line(aes(y=yvals), color = "red") #plot scatter and linear model

#Multiple Linear Regression
#y = m1x1 + m2x2 + … + mnxn + b, m are ce and xn are independent var
lm(qsec ~ mpg + disp + drat + wt + hp,data=mtcars) #generate multiple linear regression model
summary(lm(qsec ~ mpg + disp + drat + wt + hp,data=mtcars)) #generate summary statistics
#Pr(>|t|) value represents the probability that each coefficient contributes a random amount of variance to the linear model

#Category Complexities
#hi-squared test is used to compare the distribution of frequencies across two groups and tests the following hypotheses:
#H0 : There is no difference in frequency distribution between both groups.
#Ha : There is a difference in frequency distribution between both groups

# Each subject within a group contributes to only one frequency. In other words, the sum of all frequencies equals the total number of subjects in a dataset.
# Each unique value has an equal probability of being observed.
# There is a minimum of five observed instances for every unique value for a 2x2 chi-squared table.
# For a larger chi-squared table, there is at least one observation for every unique value and at least 80% of all unique values have five or more observations.

?chisq.test()
#test whether there is a statistical difference in the distributions of vehicle class across 1999 and 2008 from our mpg dataset, we would first need to build our contingency table as follows:

table(mpg$class,mpg$year) #generate contingency table

tbl <- table(mpg$class,mpg$year) #generate contingency table
chisq.test(tbl) #compare categorical distribution

#practice A/B testing
#randomized controlled experiment that uses a control (unchanged) and experimental (changed) group to test potential changes using a success metric

#If the success metric is numerical and the sample size is small, a z-score summary statistic can be sufficient to compare the mean and variability of both groups.
#If the success metric is numerical and the sample size is large, a two-sample t-test should be used to compare the distribution of both groups.
#If the success metric is categorical, you may use a chi-squared test to compare the distribution of categorical values between both groups.

