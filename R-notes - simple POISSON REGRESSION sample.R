

# Basic Poisson Example ---------------------------------------------------


# vector of colors
colors <- c("Red", "Blue", "Gold", "Black", "Pink", "Green")

#Next, we'll create a list for the distribution that will have different values for ??:
poisson.dist <- list()

#Then, we'll create a vector of values for ?? and loop over the values
#from ?? each with quantile range 0-20, storing the results in a list:
a <- c(1, 2, 3, 4, 5, 6) 

# A vector for values of u
for (i in 1:6) {
  poisson.dist[[i]] <- c(dpois(0:20, i)) 
  # Store distribution vector for each corresponding value of u
}

plot(unlist(poisson.dist[1]), type = "o", xlab="y", ylab = "P(y)",
     col = colors[i])
for (i in 1:6) {
  lines(unlist(poisson.dist[i]), type = "o", col = colors[i])
}

# Adds legend to the graph plotted
legend("topright", legend = a, inset = 0.08, cex = 1.0, fill = colors, 
       title = "Values of u")


#Poisson Distribution is most commonly used to find 
#the probability of events occurring within a given time interval.
#Since we're talking about a count, with Poisson distribution,
#the result must be 0 or higher - 
# it's not possible for an event to happen a negative number of times. 
#On the other hand, Normal distribution is a continuous distribution
#for a continuous variable and it could result in a positive or negative value:

#Poisson Distribution	
#Used for count data or rate data
#Skewed depending on values of lambda.	
# Variance = Mean

#Normal Distribution
#	Used for continuous variables
# Bell shaped curve that is symmetric around the mean.
#	Variance and mean are different parameters; mean, median and mode are equal


# We can generate a Normal Distribution in R like this:
# create a sequence -3 to +3 with .05 increments
xseq <- seq(-3, 3, .05)

# generate a Probability Density Function
densities <- dnorm(xseq, 0, 1)

# plot the graph
plot(xseq, densities, col = "blue", xlab = "", ylab = "Density", type = "l", lwd = 2)
# col: changes the color of line
# 'xlab' and 'ylab' are labels for x and y axis respectively
# type: defines the type of plot. 'l' gives a line graph
# lwd: defines line width



# ANOTHER EXAMPLE, basic poisson probability--------------------------------------------------

#If there are 12 cars crossing a bridge per minute on average,
# what is the probability of having 17 or more cars 
#crossing the bridge in any given minute?


# average number of cars crossing a bridge per minute is ?? = 12.

# ppois(q, u, lower.tail = TRUE) is 
#an R function that gives the probability that
#a random variable will be lower than or equal to a value.

# We have to find the probability of having 
# 17 or more cars, so we will use lower.trail = FALSE and set q at 16:
  
ppois(16, 12, lower.tail = FALSE)
# lower.tail = logical; if TRUE (default) then probabilities are P[X < = x],
#otherwise, P[X > x].
#we get a 10.1% chance of their being 17 cars



# -poisson using count data--------------------------------------------------------------------

# In R, the glm() command is used to model Generalized Linear Models. 
# the general structure of glm():
# glm(formula, family = familytype(link = ""), data,...)

#formula-	The formula is symbolic representation of how modeled is to fitted
#family -	Family tells choice of variance and link functions. 
#There are several choices of family, including Poisson and Logistic
#data-	Data is the dataset to be used

#glm() provides eight choices for family 
#with the following default link functions:
  
#  Family           - 	Default Link Function
# binomial          -	(link = "logit")
# gaussian          -	(link = "identity")
# Gamma           	- (link = "inverse")
# inverse.gaussian	- (link = )
# poisson	          - (link = "log")
# quasi	            - (link = "identity", variance = "constant")
# quasibinomial	    - (link = "logit")
# quasipoisson	    -(link = "log")


# install.packages("datasets")
library(datasets) # include library datasets after installation
data <- warpbreaks
columns <- names(data) # Extract column names from dataframe
columns # show columns
#Let's look at how the data is structured using the ls.str() command:
ls.str(warpbreaks)
#We can view the dependent variable breaks data continuity by creating a histogram:
hist(data$breaks)
#Clearly, the data is NOT
# in the form of a bell curve like in a normal distribution.

#Let's check out the mean() and var() of the dependent variable:
  
mean(data$breaks) # calculate mean - 28.14815
var(data$breaks) # calculate variance - 174.2041

# The variance is much greater than the mean, 
# which suggests that we will have over-dispersion in the model.
# Let's fit the Poisson model using the glm() command.
poisson.model <- glm(breaks ~ wool + tension, data, family = poisson(link = "log"))
summary(poisson.model)

#the summary gives a lot of information, 
# The first column named Estimate is the coefficient values of ?? (intercept),
# ??1 and so on. 
#Following is the interpretation for the parameter estimates:
  
# exp(??) = effect on the mean ??, when X = 0, kind of useless
# exp(??) = with every unit increase in X, 
# the predictor variable has multiplicative effect of exp(??) on the mean of Y, that is ??
# If ?? = 0, then exp(??) = 1, and the expected count is exp(??) and, Y and X are not related.
# If ?? > 0, then exp(??) > 1, and the expected count is exp(??) times larger than when X = 0
# If ?? < 0, then exp(??) < 1, and the expected count is exp(??) times smaller than when X = 0

#We can see in summary that for wool,
#'A' has been made the base and is not shown in summary. 
# Similarly, for tension 'L' has been made the base category.

#To see which explanatory variables have an effect on response variable, 
#we look at the p values.
#If the p is less than 0.05 then, the variable has an effect on the response variable. 
#In the summary above, we can see that all p values are less than 0.05, 
# hence, both explanatory variables (wool and tension) have significant effect on breaks. 
#Notice how R output used *** at the end of each variable. 
#The number of stars signifies significance.


# If the Residual Deviance is greater than the degrees of freedom, 
#then over-dispersion exists.
#This means that the estimates are correct,
#but the standard errors (standard deviation)
#are wrong and unaccounted for by the model.
poisson.model2 <- glm(breaks ~ wool + tension, data = data, family = quasipoisson(link = "log"))
summary(poisson.model2)

library(arm)
# extract coefficients from first model using 'coef()'
coef1 = coef(poisson.model)
# extract coefficients from second model
coef2 = coef(poisson.model2)
# extract standard errors from first model using 'se.coef()'
se.coef1 = se.coef(poisson.model)
# extract standard errors from second model
se.coef2 = se.coef(poisson.model2)
# use 'cbind()' to combine values into one dataframe
models.both <- cbind(coef1, se.coef1, coef2, se.coef2, exponent = exp(coef1))
# show dataframe
models.both
# we can see the coefficients are the same, 
# but the standard errors are different.


# make a dataframe with new data
newdata = data.frame(wool = "B", tension = "M")

# use 'predict()' to run model on new data
predict(poisson.model2, newdata = newdata, type = "response")
# Our model is predicting there will be roughly 24 breaks
#with wool type B and tension level M.


#visualizing this
library(jtools)
library(broom)
library(ggstance)


# the plot_summs(poisson.model2, scale = TRUE, exp = TRUE) plots the second model
# using the quasi-poisson family in glm.

# The first argument in plot_summs() is the regression model to be used,
# it may be one or more than one.
# scale helps with the problem of differing scales of the variables.
# exp is set to TRUE because for Poisson regression 
# we are more likely to be interested in exponential values of estimates rather than linear.
plot_summs(poisson.model2, scale = TRUE, exp = TRUE)
# plot regression coefficients for poisson.model2 and poisson.model
plot_summs(poisson.model, poisson.model2, scale = TRUE, exp = TRUE)


# We can also visualize the interaction between predictor variables.
# jtools provides different functions for different types of variables.
# For example, if all the variables are categorical, 
# we could use cat_plot() to better understand interactions among them.
# For continuous variables, interact_plot() is used.
cat_wrap(poisson.model2, pred = wool, modx = tension)
