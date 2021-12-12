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


