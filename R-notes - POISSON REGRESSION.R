#Poisson Regression
#Poisson regression is used to model count variables.
#Poisson regression - Poisson regression is often used for modeling count data.
#Poisson regression has a number of extensions useful for count models.


# Poisson  ----------------------------------------------------------------

require(ggplot2)
require(sandwich)
require(msm)

#For the purpose of illustration, we have simulated a data set
# num_awards is the outcome variable 
# and indicates the number of awards earned by students at a high school in a year,
# math is a continuous predictor variable and represents
# students' scores on their math final exam, 
# prog is a categorical predictor variable with three levels 
# indicating the type of program in which the students were enrolled. 
# It is coded as
# 1 = "General",
# 2 = "Academic" and 
# 3 = "Vocational". 

# get some data
p <- read.csv("https://stats.idre.ucla.edu/stat/data/poisson_sim.csv")
p <- within(p, {
  prog <- factor(prog, levels=1:3, labels=c("General", "Academic", 
                                            "Vocational"))
  id <- factor(id)
})
summary(p)


#use the tapply function to 
#display the summary statistics by program type.
#The table  shows the average numbers of awards 
#by program type and seems to suggest that program type is
# a good candidate for predicting the 
#number of awards, our outcome variable,
#because the mean value of the outcome appears to vary by prog.
with(p, tapply(num_awards, prog, function(x) {
  sprintf("M (SD) = %1.2f (%1.2f)", mean(x), sd(x))
}))
#and a plot shows the academic program shows the most rewards
ggplot(p, aes(num_awards, fill = prog)) +
  geom_histogram(binwidth=.5, position="dodge")

#use the glm function
#num_awards is regressed against program + math score, 
# family = poisson because this is count
m1 <- glm(num_awards ~ prog + math, family="poisson", data=p)
summary(m1)
#the glm output shows 
#Deviance residuals are a little bit skewed left of mean

#the Poisson regression coefficients for each of the variables 
#along with the standard errors, z-scores, p-values and 95% confidence intervals
#for the coefficients. The coefficient for math is 0.07. 
#This means that the expected log count for a one-unit increase in math is .07. 
# The indicator variable progAcademic compares between
# prog = "Academic" and prog = "General", 
# the expected log count for prog = "Academic" increases by about 1.1. 
# The indicator variable progVocational is the expected difference 
#in log count ((approx .37)) between prog = "Vocational" and the reference group 
#(prog = "General").


#NEXT

# robust standard errors for the parameter estimates will be found
# R package sandwich below to obtain the robust standard errors 
#and calculated the p-values accordingly.

cov.m1 <- vcovHC(m1, type="HC0")
std.err <- sqrt(diag(cov.m1))
r.est <- cbind(Estimate= coef(m1), "Robust SE" = std.err,
               "Pr(>|z|)" = 2 * pnorm(abs(coef(m1)/std.err), lower.tail=FALSE),
               LL = coef(m1) - 1.96 * std.err,
               UL = coef(m1) + 1.96 * std.err)

r.est

# The information on deviance is also provided in the (glm)
# We can use the residual deviance to perform a goodness of fit test for
# the overall model. The residual deviance is the difference between 
# the deviance of the current model and the maximum deviance of the ideal model
# where the predicted values are identical to the observed. 
# Therefore, if the residual difference is small enough,
# the goodness of fit test will not be significant, 
# indicating that the model fits the data. 
# We conclude that the model fits reasonably well 
# because the goodness-of-fit chi-squared test is not statistically significant.

#goodness of fit test...
with(m1, cbind(res.deviance = deviance, df = df.residual,
               p = pchisq(deviance, df.residual, lower.tail=FALSE)))

##  The two degree-of-freedom chi-square test indicates that prog, 
# taken together, is a statistically significant predictor of num_awards.
## update m1 model dropping prog
m2 <- update(m1, . ~ . - prog)
## test model differences with chi square test
anova(m2, m1, test="Chisq")

# to present the regression results as incident rate ratios
# and their standard errors, together with the confidence interval.
#we  compute the standard error for the incident rate ratios, 
# we will use the Delta method. 
#To this end, we make use the function deltamethod implemented in R package msm.

s <- deltamethod(list(~ exp(x1), ~ exp(x2), ~ exp(x3), ~ exp(x4)), 
                 coef(m1), cov.m1)

## exponentiate old estimates dropping the p values
rexp.est <- exp(r.est[, -3])
## replace SEs with estimates for exponentiated coefficients
rexp.est[, "Robust SE"] <- s

rexp.est

#The output indicates that the incident rate for prog = "Academic" is 2.96 times 
#the incident rate for the reference group (prog = "General"). 
#Likewise, the incident rate for prog = "Vocational" is 1.45 times the incident rate
# for the reference group holding the other variables at constant. 
# The percent change in the incident rate of num_awards is by 7%
# for every unit increase in math


# to look at the expected marginal means.
#For example, what are the expected counts for each program type 
# holding math score at its overall mean? 
#To answer this question, we can make use of the predict function. 
#First off, we will make a small data set to apply the predict function to it.
#make the data set
(s1 <- data.frame(math = mean(p$math),
                  prog = factor(1:3, levels = 1:3, labels = levels(p$prog))))
#use the predict funtion for marginal means
predict(m1, s1, type="response", se.fit=TRUE)

# In the output we see that the predicted number of events 
# for level 1 of prog is about .21, holding math at its mean.
# The predicted number of events for level 2 of prog is higher at .62,
# and the predicted number of events for level 3 of prog is about .31.
# The ratios of these predicted counts
# ((frac{.625}{.211} = 2.96), (frac{.306}{.211} = 1.45)) 
# match what we saw looking at the IRR.

# This can all be graphed
## calculate and store predicted values
p$phat <- predict(m1, type="response")

## order by program and then by math
p <- p[with(p, order(prog, math)), ]

## create the plot
ggplot(p, aes(x = math, y = phat, colour = prog)) +
  geom_point(aes(y = num_awards), alpha=.5, position=position_jitter(h=.2)) +
  geom_line(size = 1) +
  labs(x = "Math Score", y = "Expected number of awards")

# looking at the plot, 
#there seems to be an issue of dispersion, 
#we should first check if our model is appropriately specified, 
#such as omitted variables and functional forms

#One common cause of over-dispersion is excess zeros, 
# which in turn are generated by an additional data generating process.
#In this situation, zero-inflated model should be considered.

# If the data generating process does not allow for any 0s 
#(such as the number of days spent in the hospital), 
#then a zero-truncated model may be more appropriate.

