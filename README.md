# MechaCar_Statistical_Analysis
Module 15: Statistics and R for MechaCar.
## Linear Regression to Predict MPG

This is the summary statistics of the linear regression performed.

<img width="533" alt="D1-Summary" src="https://user-images.githubusercontent.com/87828174/145723431-4dcbcd60-e9fc-426a-8b4b-51c2fe0d3f7b.png">

### Which variables/coefficients provided a non-random amount of variance to the mpg values in the dataset?

In the summary output, each Pr(>|t|) value represents the probability that each coefficient contributes a random amount of variance to the linear model. The variables which had a significant impact on mpg were:

   1. Vehicle Length
   2. Ground Clearance
   3. Intercept

These values have a p-value well below the assumed significance level of 0.05% therefore are likely to provide non-random amounts of statistical variance to the miles per gallon(mpg) of the prototype 

### Is the slope of the linear model considered to be zero? Why or why not?

The p-value is 5.35e-11 which is much smaller than any appropriate significance level of 0.05%. Therefore, we can state that there is sufficient evidence to reject our null hypothesis, which means that the slope of our linear model is not zero.

### Does this linear model predict mpg of MechaCar prototypes effectively? Why or why not?

The r-squared (r^2) value is also known as the coefficient of determination and represents how well the regression model approximates real-world data points and how well it can predict future data. From the data we can see the r-squared value is 0.7149. Therefore it has a 71.49 % chance at predicting mpg of MechaCar prototypes. Therefore it does predict mpg of MechaCar prototypes quite effectively.

## Summary Statistics on Suspension Coils

The first image are the summary statistics of suspension coils PSI column.

<img width="316" alt="D2-a" src="https://user-images.githubusercontent.com/87828174/145725580-450a7172-c51f-442c-a2ac-a115f7e09fb1.png">

The second image are the summary statistics of suspension coils PSI column grouped by lots.

<img width="466" alt="D2-b" src="https://user-images.githubusercontent.com/87828174/145725689-c5d4cdd9-64f0-49c9-9ad0-b7bbf72d7e75.png">

### The design specifications for the MechaCar suspension coils dictate that the variance of the suspension coils must not exceed 100 pounds per square inch. Does the current manufacturing data meet this design specification for all manufacturing lots in total and each lot individually? Why or why not?

  1. For all the lots together, the total_summary shows that the variance for the suspension coils PSI (pounds per square inch) is 62.29356 well below the limit of 100 therefore it meets the design specification of the manufacturing lots.
  2. For each individual lot as shown in lot_summary, Lot 1 and Lot 2 meet the design specifications with variances of 0.9795918 and 7.4693878 respectively which are well below 100 PSI. However, Lot 3 with a variance of 170.2861224 PSI exceeds the 100 PSI limit and therefore does not meet the design specifications.

## T-Tests on Suspension Coils

T tests were done to determine if the PSI across all manufacturing lots is statistically different from the population mean of 1,500 pounds per square inch.

### T-Test Overall

<img width="399" alt="D3-a" src="https://user-images.githubusercontent.com/87828174/145730147-e2797ff8-ebac-4de1-870a-92425cd7a58d.png">

The p-value is 0.06028. This is above the common significance level of 0.05 percent therefore we do not have sufficient evidence to reject the null hypothesis, and we would state that the two means are statistically similar. The true mean of the sample is 1498.78 which is close to 1500 the theoretical population mean. The null hypothesis being that the means are similar with the alternate hypothesis saying that there is a difference.

### T-Test Lot 1

<img width="399" alt="D3-b" src="https://user-images.githubusercontent.com/87828174/145730170-33457efb-b981-484e-be5d-ba278c13bf90.png">

Lot 1 has the same mean as the population which is 1500. The p-value is 1. This is greater than the common significance level of 0.05 percent therefore we do not have sufficient evidence to reject the null hypothesis, and we would state that the two means are statistically similar.

### T-Test Lot 2

<img width="398" alt="D3-c" src="https://user-images.githubusercontent.com/87828174/145730174-797d425a-a167-4080-a687-71445f68904a.png">

Lot 2 has a mean of 1500.2 as compared to the population mean of 1500. The p-value is 0.6072. This is way above the common significance level of 0.05 percent therefore we do not have sufficient evidence to reject the null hypothesis, and we would state that the two means are statistically similar.

### T-Test Lot 3

<img width="399" alt="D3-d" src="https://user-images.githubusercontent.com/87828174/145730181-beb93fc0-041d-48ba-83f3-c6624ff0953a.png">

Lot 3 has a mean of 1496.14. The p-value is 0.04168. This is below the assumed common significance level of 0.05 percent therefore we have sufficient evidence to reject the null hypothesis, and we would state that the two means of this lot and population are not statistically similar.

We can conclude from these results that Lot 3 is not performing at the same level as Lot 1 and Lot 2. Lot 3 also has the most variance in the suspension coils PSI. Lot 1 and Lot 2 are performing at a similar level as the population dataset. 

## Study Design: MechaCar vs Competition

Following is a statistical study on how MechaCar performs against the competition.

### What metric or metrics are you going to test?

Although there are many metrics that can be tested as they represent conditions as to which the market would find MechaCar more popular than its competitors, the most important metrics for a prototype in a competitive market are:

   - Fuel Efficiency
   - Cost
   - Safety
   - Maintenance Costs

### What is the null hypothesis or alternative hypothesis?

For each metric we will perform each metric's hypothesis testing to see its performance compared to the competitors.

- The null hypothesis is that MechaCar has the same metric performance as its competitors.
- The alternative hypothesis is that MechaCar does not have the same metric performance as its competitors and has better or worse performance.

### What statistical test would you use to test the hypothesis? And why?

We will use the Anova test which is a generalisation of the Two-Sample t-Test beyond two datasets. The Anova test will be used to test the means of different sample groups to see if they are statistically similar or dissimilar. Our aim is to see if datasets for different metrics are dissimilar. If they are dissimilar, are they better or worse? This would allow us to individually see the performance of our key metrics or key factors for user popularity compared to the competition in the automotive industry. These comparisons can also be plotted for more visual aid.

### What data is needed to run the statistical test?

We would need datasets for different types of cars for all metrics for testing, from different competitors. These datasets would then be compared using Anova.


