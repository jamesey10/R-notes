library(ggplot2)
library(GGally)
library(CCA)
library(CCP)


#Look at the Data
mm <- read.csv("https://stats.idre.ucla.edu/stat/data/mmreg.csv")
colnames(mm) <- c("Control", "Concept", "Motivation", "Read", "Write", "Math", 
                  "Science", "Sex")
summary(mm)
xtabs(~Sex, data = mm)

##Specify independent and dependent variables
psych <- mm[, 1:3] #this is the dependent variables
acad <- mm[, 4:8]  #this is the independent variables

#Correlate dependent variables
ggpairs(psych)
#Correlation on independent variables
ggpairs(acad)
# correlations within and between the two sets of variables
matcor(psych, acad)

cc1 <- cc(psych, acad)
# display the canonical correlations
cc1$cor
cc1[3:4]

# Use comput to compute the loadings of the variables on the canonical dimensions (variates). 
# These loadings are correlations between variables and the canonical variates.
cc2 <- comput(psych, acad, cc1)
# display canonical loadings
# These correlations are between observed variables and canonical variables, the canonical loadings.
# These canonical variates are actually a type of latent variable.
cc2[3:6]

# the number of canonical dimensions is equal to
# the number of variables in the smaller set;
# however, the number of significant dimensions may be even smaller
# tests of canonical dimensions
rho <- cc1$cor
## Define number of observations, number of variables in first set, and number of variables in the second set.
n <- dim(psych)[1]
p <- length(psych)
q <- length(acad)

## Calculate p-values using the F-approximations of different test statistics:
## 4 different t-stat tests
## Low p-value indicates significance in each test
p.asym(rho, n, p, q, tstat = "Wilks")
p.asym(rho, n, p, q, tstat = "Hotelling")
p.asym(rho, n, p, q, tstat = "Pillai")
p.asym(rho, n, p, q, tstat = "Roy")

## When the variables in the model have very different standard deviations,
## the standardized coefficients allow for easier comparisons among the variables.
## Next, we'll compute the standardized canonical coefficients.

# standardized psych canonical coefficients diagonal matrix of psych sd's
s1 <- diag(sqrt(diag(cov(psych))))
s1 %*% cc1$xcoef
# standardized acad canonical coefficients diagonal matrix of acad sd's
s2 <- diag(sqrt(diag(cov(acad))))
s2 %*% cc1$ycoef
