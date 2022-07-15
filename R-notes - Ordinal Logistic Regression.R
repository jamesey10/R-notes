# Ordinal Logistic Regression ---------------------------------------------

# The following page discusses how to
#use R's polr package to perform an ordinal logistic regression.
#packages needed:
require(foreign)
require(ggplot2)
require(MASS)
require(Hmisc)
require(reshape2)
require(polr)


#Example
# A study looks at factors that influence the decision of
# whether to apply to graduate school.
# College juniors are asked if they are
# unlikely, somewhat likely, or very likely 
# to apply to graduate school. 
# Hence outcome variable has three categories. 
# Data on 
# parental educational status, 
# whether the undergraduate institution is public or private, 
# current GPA is also collected. 
# The researchers have reason to believe that the "distances" 
#between these three points are not equal.
#For example, the "distance" between "unlikely" and "somewhat likely"
#may be shorter than the distance between "somewhat likely" and "very likely".


#there is online data for this example
dat <- read.dta("https://stats.idre.ucla.edu/stat/data/ologit.dta")
#there are 6 categories of likliness, and 3 varaibles. 400 rows of data
summary(dat)
head(dat)
#descriptive statistics of these variables.
#a simple count of all the stats
lapply(dat[, c("apply", "pared", "public")], table)

## three way cross tabs (xtabs) and flatten the table
ftable(xtabs(~ public + apply + pared, data = dat))
## a look at gpas...
summary(dat$gpa)
sd(dat$gpa)

#this shows box plots overlayed with scatter to try and determine 
#where the correlations may be. 
ggplot(dat, aes(x = apply, y = gpa)) +
  geom_boxplot(size = .75) +
  geom_jitter(alpha = .5) +
  facet_grid(pared ~ public, margins = TRUE) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))

# we use the polr command from the MASS package
# to estimate an ordered logistic regression model.
# proportional odds logistic regression
## fit ordered logit model and store results 'm'
m <- polr(apply ~ pared + public + gpa, data = dat, Hess=TRUE)
## view a summary of the model
summary(m)
#In the output above, we see

# Call-  this is R reminding us what type of model we ran, what options we specified, etc.
# the usual regression output coefficient table including 
# the value of each coefficient, standard errors, and t value,
#which is simply the ratio of the coefficient to its standard error. 
#There is no significance test by default.
# Next, the estimates for the two intercepts,
# which are sometimes called cutpoints.
# The intercepts indicate where the latent variable is cut
# to make the three groups that we observe in our data. 
# Note that this latent variable is continuous. 
# In general, these are not used in the interpretation of the results. 
# The cutpoints are closely related to thresholds, which are reported by other statistical packages.
# Finally, we see the residual deviance,
# -2 * Log Likelihood of the model as well as the AIC.
# Both the deviance and AIC are useful for model comparison.

## store table
# We need to calculate a p-value 
#in this case is by comparing the t-value
#against the standard normal distribution, like a z test. 
(ctable <- coef(summary(m)))
## calculate and store p values
p <- pnorm(abs(ctable[, "t value"]), lower.tail = FALSE) * 2
## combined table
(ctable <- cbind(ctable, "p value" = p))

# We can also get confidence intervals for the parameter estimates.
# These can be obtained either by profiling the likelihood function
# or by using the standard errors and assuming a normal distribution.
# Note that profiled CIs are not symmetric
# (although they are usually close to symmetric).
# If the 95% CI does not cross 0, 
# the parameter estimate is statistically significant.
ci <- confint(m) # default method gives profiled CIs
confint.default(m) # CIs assuming normality

#The estimates in the output are given in units of ordered logits, 
#some are negative and there cant be negative probabilities
#or ordered log odds. We find odds ratios with the (exp) command
## odds ratios
exp(coef(m))
## OR and CI
exp(cbind(OR = coef(m), ci))


#There are many equivalent interpretations of the odds ratio
#based on how the probability is defined and the direction of the odds. 

##            OR  2.5 % 97.5 %
## pared  2.8511 1.6958  4.817
## public 0.9429 0.5209  1.681
## gpa    1.8514 1.1136  3.098

# Interpretation of that output....(*) denotes the one chosen
# Parental Education

# (*) For students whose parents did attend college, the odds of being more likely (i.e., very or somewhat likely versus unlikely) to apply is 2.85 times that of students whose parents did not go to college, holding constant all other variables.
# For students whose parents did not attend college, the odds of being less likely to apply (i.e., unlikely versus somewhat or very likely) is 2.85 times that of students whose parents did go to college, holding constant all other variables.

# School Type
# For students in public school, the odds of being more likely (i.e., very or somewhat likely versus unlikely) to apply is 5.71% lower [i.e., (1 -0.943) x 100%] than private school students, holding constant all other variables.
# (*) For students in private school, the odds of being more likely to apply is 1.06 times [i.e., 1/0.943] that of public school students, holding constant all other variables (positive odds ratio).
# For students in private school, the odds of being less likely to apply (i.e., unlikely versus somewhat or very likely) is 5.71% lower than public school students, holding constant all other variables.
# For students in public school, the odds of being less likely to apply is 1.06 times that of private school students, holding constant all other variables (positive odds ratio).

#GPA
#(*) For every one unit increase in student's GPA the odds of being more likely to apply (very or somewhat likely versus unlikely) is multiplied 1.85 times (i.e., increases 85%), holding constant all other variables.
#For every one unit decrease in student's GPA the odds of being less likely to apply (unlikely versus somewhat or very likely) is multiplied 1.85 times, holding constant all other variables.

# An assumption of underlying ordinal logistic (and ordinal probit) regression is
#  the relationship between each pair of outcome groups is the same.
# The ordinal logistic regression assumes the coefficients describing the relation between
# the lowest versus all higher categories of the response variable are the same as
# those that describe the relationship between the next
# lowest category and all higher categories, etc. 
# This is called the proportional odds assumption or the parallel regression assumption.
# Because the relationship between all pairs of groups is the same, 
# there is only one set of coefficients.
# we need to evaluate whether the proportional odds assumption is tenable

#The first line of this command tells R that sf is a function,
# and that this function takes one argument, which we label y. 
# The sf function will calculate the log odds of being greater than or equal
#to each value of the target variable. 
# For our purposes, we would like the log odds of apply
# being greater than or equal to 2, and then greater than or equal to 3

sf <- function(y) {
  c('Y>=1' = qlogis(mean(y >= 1)),
    'Y>=2' = qlogis(mean(y >= 2)),
    'Y>=3' = qlogis(mean(y >= 3)))
}

# This second command calls the function sf 
# on several subsets of the data defined by the predictors. 
# Proportional odds assumption
s <- with(dat, summary(as.numeric(apply) ~ pared + public + gpa, fun=sf))


glm(I(as.numeric(apply) >= 2) ~ pared, family="binomial", data = dat)

glm(I(as.numeric(apply) >= 3) ~ pared, family="binomial", data = dat)

s[, 4] <- s[, 4] - s[, 3]
s[, 3] <- s[, 3] - s[, 3]
s # print

plot(s, which=1:3, pch=1:3, xlab='logit', main=' ', xlim=range(s[,3:4]))


newdat <- data.frame(
  pared = rep(0:1, 200),
  public = rep(0:1, each = 200),
  gpa = rep(seq(from = 1.9, to = 4, length.out = 100), 4))

newdat <- cbind(newdat, predict(m, newdat, type = "probs"))

##show first few rows
head(newdat)



lnewdat <- melt(newdat, id.vars = c("pared", "public", "gpa"),
                variable.name = "Level", value.name="Probability")
## view first few rows
head(lnewdat)


ggplot(lnewdat, aes(x = gpa, y = Probability, colour = Level)) +
  geom_line() + facet_grid(pared ~ public, labeller="label_both")




# interpret the coefficients in an ordinal logistic regression in R -------
#use these packages
library(foreign)
library(MASS)
#read in some data
dat <- read.dta("https://stats.idre.ucla.edu/stat/data/ologit.dta")
m <- polr(apply ~ pared, data = dat)
summary(m)

# The output shows that for students whose parents attended college, 
# the log odds of being unlikely to apply to college (versus somewhat or very likely) is 
# actually ???^??1=???1.127 or 1.127 points lower than 
# students whose parents did not attend college.
# note exp(???1.127) = 0.324 =  e ^ -1.127

# To obtain the odds ratio in R, 
# simply exponentiate the coefficient or log-odds of pared.
# The following code uses cbind to 
#combine the odds ratio with its confidence interval. 
#First store the confidence interval in object ci
ci <- confint(m)

#Then bind the transpose of the ci object with coef(m) 
#and exponentiate the values,
exp(cbind(coef(m),t(ci)))



newdat <- data.frame(pared=c(0,1))
phat <- predict(object = m, newdat, type="p")

#In general, to obtain the odds ratio 
#it is easier to exponentiate the coefficient itself
# rather than its negative because this is what is output directly from R (polr). 
# The researcher must then decide which of the two interpretations to use: