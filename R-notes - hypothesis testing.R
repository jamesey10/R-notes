# Hypothesis Testing

# One Sample Z Test -------------------------------------------------------
#TEST std dev of population
#the packgae readr makes Z-Testing possible
#library(readr)
#open a file or get some data
#Perfume_Volumes <- read_csv("D:/_R Getting Started/0 R Markdowns/Section 9/Perfume Volumes.csv")
#or here's some random sample data
pervol <- runif(100,130,170)
#Unfortunately, there is no z-test in R-basic
#the package BSDA is needed
#library(BSDA)
#then do the ztest in BSDA!
# x=your data , mu= previously calculated mean, sigma.x= populations std dev
z.test(x = pervol, alternative = "greater", sigma.x = 2, mu = 150)
#compare result to population's ztest numbers


# One Sample T Test -------------------------------------------------------
#test standard deviation of a sample
#use if you dont have a standard deviation of a population
#Make some data
vol <- c(151, 153, 152, 152)
#do the t-test
# x = data, mu=known mean, conf.level = desired confidence level
t.test(x = vol, mu = 150, conf.level = 0.95)
#the output from this shows p-value less than .05, thus null hypo is rejected

#this can be fun to plot too
#use the visualize library: library(visualize)
#df = degrees of freedom = number of units in sample minus 1
visualize.t(stat=c(-4.899,4.899), df = 3, section = "tails")



# One Sample Variance Test Chi Squared------------------------------------------------

#Bad News: chisq.test is for contigency tables 
#and not suitable for one sample variance test
#install an external package named EnvStats for this.
# run library(EnvStats)

#ChiSquared is for testing the population variance against a specific value
#OR
#Testing Goodness of fit


#open a file or get some data
#Perfume_Volumes <- read_csv("D:/_R Getting Started/0 R Markdowns/Section 9/Perfume Volumes.csv")
#or here's some random sample data
pervol <- runif(25,130,170)
#Perform one sample variance test using the function varTest from EnvStats.
varTest(x = pervol , sigma.squared = 4, alternative = "greater")
#look at P and reject or fail to reject the null hypo

#Performing one sample variance test in conventional way _
#Calculated Chi Square
calc <- (25-1)* var(pervol) / 4
#Remember 4 R functions for distributions - rchisq, pchisq, qchisq, dchisq
#Use qchisq for 5% area on the right to find the critical value of chi suare.
crit <- qchisq(p=0.05, df=24, lower.tail = F)
#Plot Chi Square distribution, and show critical value (36.4) and calculated (30) using dchisq
x <- seq(1, 50, by = 1)
y <- dchisq(x, 24)
#and plot it
plot(y, type="l", xlab="Chi Sq", ylab="f(chi sq)")
abline(v=30)
text(30, 0.05, "Calculated")

abline(v=crit)
text(crit, 0.04, "Critical - 0.95")

# Two Sample Z Test -------------------------------------------------------
#For 2 samples each from a different population, 
#like comparing 2 machines of the the same model in 2 different cities
#Null Hypo = they have the same mean
#Alt Hypo = their mean is different
#Use library(BSDA)
#Use library(readr) if importing data from excel
#Get Data
Perfume_Volumes_2_Sample <- read_csv("D:Two Sample Z Test/Perfume Volumes 2 Sample.csv")
#or Make some
machine1 <- runif(100,130,170)
machine2 <- runif(100,130,170)

z.test(x = machine1, 
       y = machine2,
       sigma.x = sd(machine1),
       sigma.y = sd(machine2))
# output will tell you a p-value, and this cool statement
# alternative hypothesis: true difference in means is not equal to 0

# make a histogram out of this for fun
hist(x = machine1, 
     col=rgb(1,0,0,0.5),
     main = "Volumes by Machine 1 and 2",
     xlim = c(120,180),
     xlab = "Volume",
     ylab = "Frequency", )
hist(x = machine2, 
     col=rgb(0,0,1,0.5), add = T)


# Two sample z-test with different means ----------------------------------
#For 2 samples each from a different population, 
#like comparing 2 machines of the the same model in 2 different cities
# & one machine is supposed to operate at 150, the other at 151
#just add an argument for the difference between means, in this case -1.0
z.test(x = machine1, 
       y = machine2,
       sigma.x = sd(machine1),
       sigma.y = sd(machine2),mu = -1.0)



# Two sample T Test -------------------------------------------------------
#If Data is independent, use a t-test
#comparing blood pressure of males and females

#if data is dependent, use a paired t-test
#comparing before and after blood pressure medicince

# Two Sample Variance Test with equal variance-----------------------------
#make two sample sets
mc1 <- c(150, 152, 154, 152, 151)
mc2 <- c(156, 155, 158, 155, 154)

#first we have to check if the variances are equal enough
#How to check equality of variance? 
# F Test can do this too, see that section
var.test(x = mc1, y = mc2)
#with this sample, the p is greater than 0.05, fail to reject null
#that means the variances are equal enough
#that means go ahead with the t.test
t.test(x = mc1, y = mc2, var.equal = T)
#the output for this sample has a p-value of 0.003919, lower than 0.05
#null p-value is low, we let it go. 
#this can be plotted for fun
boxplot(mc1, mc2)


# Two Sample Variance Test with un-equal variance -------------------------
#sample data 
#mc1 is the same machine from the equal variance exercise
mc1 <- c(150, 152, 154, 152, 151)
#mc3 is a machine with a wider range of means than mc2 
mc3 <- c(144, 162, 177, 150, 140)

#How to check equality of variance? 
var.test(x = mc1, y = mc3)
#pvalue is less than 0.05, 
#we reject the null hypothesis. Variances of mc1 and mc3 can be considered to be NOT equal.
#Conduct t test considering un-equal variance.
#It's the same as the t.test for equal values, except the variable for var.equal is false
t.test(x = mc1, y = mc3, var.equal = F)

#In this two sample t test the value of p is greater than 0.05,
#hence we fail to reject the null hypothesis.
#There are not sufficient evidences to prove 
#machine 1 and machine 3 produce different volumes.


# Paried T-Test -----------------------------------------------------------
#For Samples dependent on each other. DEPENDENT!!
#imagine blood pressure medicine
bp.before <- c(120, 122, 143, 100, 109)
bp.after <- c(122, 120, 141, 109, 109)
#do the t.test, and set a variabled called paired to TRUE
t.test(x = bp.before, y = bp.after, paired = T)
#Since the value of p is greater than 0.05, 
#we fail to reject the null hypothesis. 
#There is not enough evidences to prove
#this medicine has any effect on the blood pressure.


# Two Sample Variance Test - F Test ---------------------------------------
#Example: a different number of samples from each sample
# We took 8 samples from machine A and the standard deviation was 1.1. 
# From machine B we randomly picked 5 samples and the variance was 11. 
#Is there a difference in the variance for machine A and B? 
#Check with 90% confidence level.
#some data
mca <- c(150, 150, 151, 149, 151, 151, 148, 151)
mcb <- c(152, 146, 152, 150, 155)
#and the test
var.test(x = mca, y = mcb, ratio = 1, conf.level = 0.90)
#Since the p-value is less than 0.10 we reject the null hypothesis. 
#null is low so we let it go. 
#This concludes there is a significant difference between these two machines variance.


# ANOVA -------------------------------------------------------------------
# ANalysis
# Of
# VAriance

#F-TEST - equality of two different populations 
#For testing equality of several means
#Null Hypothesis states the variance are the same
#Alt Hypothesis states the variances NOT the same

#CHI SQAURED 
#- Testing population variance against a specified value
# - testing goodness of fit

#make some data, for 3 machines
mc1 <- c(150, 151, 152, 152, 151, 150)
mc2 <- c(153, 152, 148, 151, 149, 152)
mc3 <- c(156, 154, 155, 156, 157, 155)
# create data frame
volume <- c(mc1, mc2, mc3)
machine <- rep("machine1", times=6)
machine <- rep("machine1", times=length(mc1))
machine <- rep(c("machine1", "machine2", "machine3"), 
               times=c(length(mc1), length(mc2), length(mc3)))
vol.mc <- data.frame(volume, machine)
#run aov with the data, and columns to compare
mc.aov <- aov(data = vol.mc, formula = volume ~ machine)
#run summary
summary(mc.aov)

#Then Do a TukeyHSD (Tukey Honest Significant Differences) to check
TukeyHSD(x = mc.aov)


# Goodness of Fit ---------------------------------------------------------
#Example
#If we flip a coin 100 times and we get 40 heads and 60 tails. 
#Is this coin biased?
#Null Hypo - the data is honest, it follows a specified distritbuion
#Alt Hypo - the data is suspect, it does not follow a specified distribution

#Make a vector of what happened
#we flipped a coin, and got 40 heads, 60 tails
flip <- c(40,60)
#Then we tell chisq.test to examine that vector,
#with an expected probability of 50-50
chisq.test(x=flip, p = c(0.5,0.5))
#in this case, the pvalue is 0.0455
#pvalue is low, let it go. 
#null hypothesis of honest data is not supported. we suspect a bad coin


#Another example
#we predict shirts of sizes S,M,L,XL 
#to sell at rations of .2  .4  .3  .1
#we get actual sales numbers of  (211, 402, 297, 80)
#we make a vector of each 
sh.p <- c(0.2, 0.4, 0.3, 0.1)
sh.a <- c(211, 402, 297, 80)
#run the chisq. The expected probability is the 4 expected ratios. 
chisq.test(x = sh.a, p = sh.p)
#in this sample, p-value is 0.2043
#p is high, our null flies
#our prediction of ratios was off
#we need to make a new prediction
#we can make a plot of this using the data output from the chisq test
library(visualize)
visualize.chisq(stat = 4.59, df = 3, section = "upper")

# Contingency Tables ------------------------------------------------------
#to find a relationship between two discrete variables
#smoker and gender
#sustainability strength and org culture
#null hypothesis - no relationhip
#alt hypothesis - there is a relationship

#make a dataframe
#first 3 vectors
Op1 <- c(22, 28, 72)
Op2 <- c(26, 62, 22)
Op3 <- c(23, 26, 66)
#then a dataframe
Opr <- data.frame(Op1, Op2, Op3, row.names = c('shift1', 'shift2', 'shift3'))
#then do the chisq test
chisq.test(Opr)

#Manual calculation yields chi squ as 49.52, critical as 9.49

#Critical value for 95% confidence level
qchisq(0.05, df=4, lower.tail = F)


# Contingeny Tables for big data sets -------------------------------------
#For big tables, thousands of rows, use package gmodels
#use this datapackage for an example
library(nycflights13)
fl <- nycflights13::flights

#flights by year
CrossTable(x = fl$carrier, y = fl$year)
#flights by month, #this makes a huge list
CrossTable(x = fl$carrier, y = fl$month)


#Clean cross table with just numbers and conducting chi square test
CrossTable(x = fl$carrier, y = fl$month, 
           prop.chisq = F, prop.r = F, prop.c = F, prop.t = F, chisq = T)
#degrees of freedom, chi squared value, and p are calculated


