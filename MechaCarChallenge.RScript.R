# Set working directory
setwd("~/Desktop/Class_Folder/Analysis_Projects/MODULE_15/MechaCar_Statistical_Analysis")

# import dependencies
library(dplyr)

# Deliverable 1
# read CV
MechaCar_df <- read.csv(file='MechaCar_mpg.csv',check.names=F,stringsAsFactors = F) # reading csv files

# multiple linear regression
lm(mpg~vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD,data=MechaCar_df) #generate multiple linear regression model
summary(lm(mpg~vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD,data=MechaCar_df))

# Deliverable 2
# read csv
SuspensionCoil_df <- read.csv(file='Suspension_Coil.csv',check.names=F,stringsAsFactors = F) # reading csv files

# summary
total_summary <- summarize(SuspensionCoil_df, Mean = mean(PSI), Median = median(PSI), Variance = var(PSI), SD = sd(PSI))
head(total_summary)

# group each manufacturing lot by the mean, median, variance, and standard deviation of the suspension coil’s PSI column
lot_summary <- SuspensionCoil_df %>% group_by(Manufacturing_Lot) %>%
  summarise(Mean = mean(PSI), Median = median(PSI), Variance = var(PSI), SD = sd(PSI))
head(lot_summary)

# Deliverable 3
# manufacturing lots and each lot individually are statistically different from the population mean of 1,500 pounds per square inch

# PSI across all manufacturing lots is statistically different from the population mean of 1,500 pounds per square inch
t.test(SuspensionCoil_df$PSI, mu = 1500)

# t test for individual lot1
lot1 <- subset(SuspensionCoil_df, Manufacturing_Lot=='Lot1')
t.test(lot1$PSI, mu = 1500)

# t test for individual lot2
lot2 <- subset(SuspensionCoil_df, Manufacturing_Lot=='Lot2')
t.test(lot2$PSI, mu = 1500)

# t test for individual lot3
lot3 <- subset(SuspensionCoil_df, Manufacturing_Lot=='Lot3')
t.test(lot3$PSI, mu = 1500)




