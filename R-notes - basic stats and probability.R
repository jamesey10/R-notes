#Statistics


# BASIC Descriptive Stats - mean, median, mode ------------------------------------------------------------------
#Descriptive Stats - mean, median, mode
#Finding a mean
#make some data
student.height <- c(100, 106, 121, 111, 109, 111, 103, 117, 114)
mean(student.height)
#if you have missing data, you will get an error, like in the following
student.height <- c(100, 106, 121, 111, 109, 111, 103, 117, 114, NA, 1047)
mean(student.height) #an error happens
#tell the mean command to removed(rm) the na's
student.height <- c(100, 106, 121, 111, 109, 111, 103, 117, 114, NA, 1047)
mean(student.height, na.rm = TRUE)
#and you can trim out the outlyers, in this case 1047...0.1 = bottom and top 10%
mean(student.height, trim = 0.1, na.rm = TRUE)

#Median - follows the same rules as mean
median(student.height)



# BASIC Variance stats ----------------------------------------------------------
#make some data
student.height <- c(100, 106, 121, 111, 109, 111, 103, 117, 114)
#get the range
range(student.height)
#get some quick stats
summary(student.height)
#interquartile range
IQR(student.height)
#Standard Deviation
sd(student.height)
#how many items
length(student.height)



# PSYCH Package -----------------------------------------------------------
#Psych is great
#install and run psych library(psych)
#make some data
some.data <- runif(25,0,100)
some.data2 <- runif(25,0,100)
#use describe to get a bunch of quick descripitve and variance stats
describe(some.data)
#get 2 rows of information
describe(cbind(some.data,some.data2))



# Central Limit Theory ----------------------------------------------------
#show with more samaples, the data makes a curve honing in on the mean
#some data
#10000 random numbers
r <- runif(10000)
#the mean of those 10000 random numbers
meanr <- mean(r)
#the Std Dev of those 10000 random numbers
sdr <- sd(r)
#pull 4 of them at random
sample(r, 4)
#get the mean of 4 of them
mean(sample(r,4))
#do a little program to get means from 4 samples, 1000 times
cl4 <- mean(sample(r, 4))
for (i in 1:1000) {
  cl4 <- c(cl4, mean(sample(r, 4)))
}

#do a little program to get means from 9 samples, 1000 times
cl9 <- mean(sample(r, 9))
for (i in 1:1000) {
  cl9 <- c(cl9, mean(sample(r, 9)))
}

#do a little program to get means from 100 samples, 1000 times
cl100 <- mean(sample(r, 100))
for (i in 1:100) {
  cl100 <- c(cl100, mean(sample(r, 100)))
}
#get the means and sds for the samples
meancl4 <- mean(cl4)
sdcl4 <- sd(cl4)
meancl9 <- mean(cl9)
sdcl9 <- sd(cl9)
meancl100 <- mean(cl100)
sdcl100 <- sd(cl100)


#then graphing this in histograms will show more sample makes a better curve
par(mfrow = c(2,2))

#mtext - margin text, 1,2,3 or 4, tell the side to put the text
#std dev on top - side 3
#means on the right side - side 4
hist(r, main = "1 Sample")
mtext(sdr, side=3)
mtext(meanr, side=4)

hist(cl4, main = "4 Samples")
mtext(sdcl4, side=3)
mtext(meancl4, side=4)

hist(cl9, main="9 samples")
mtext(sdcl9, side=3)
mtext(meancl9, side=4)

hist(cl100, main="100 sample")
mtext(sdcl100, side=3)
mtext(meancl100, side=4)



# Normal Distribution -----------------------------------------------------

#Randomly generated samples from standard normal distribution 
#default - (mean = 0, sd = 1)
#rnorm
rnorm(10)
#Randomly generated samples from normal distribution 
#adding the arguments (mean = 100, sd = 1)
#kind of like reverse engineering some data
rnorm(10, mean=100, sd=1)

#pnorm - tells the probability of being left or right of a standard deviation
#At z=0 the value of probability is 0.5
pnorm(0)

#At z=-1.96, the probability is 0.025
pnorm(-1.96)

#At z=-1.64, the probability is 0.05
pnorm(-1.64)

#qnorm
#At what value of z the area on left is 5%
qnorm(0.05)

#dnorm
#Y axis value for z=0
dnorm(0)


# Binomial Dsitribution ---------------------------------------------------
# Fixed number of trials - n
# For each trial there are two possible outcomes
# Probability of success remains same for all trials
# Trials are independent of each other
# We are interested in : Probability of x number of successes in n trials

#rbinom - makes random samples
#Probability of head in single coin flipping, makes sample results
rbinom(10,1,0.5)
#probability of head in 10 coin flipping
rbinom(10,10,0.5)

#pbinom Probability of 3 heads in 10 flips of coins
pbinom(3,10,0.5)
#qbinom - tells you probability of failure
qbinom(0.17,10,0.5)
#dbinom - tells you the probability of success
dbinom(3,10,0.5)



# Poisson Distribution ----------------------------------------------------
#5 criteria
#Poisson Distribution
#Outcomes are success or failure
#Average number of successes (mu) in the specific region (time, location) are known
#Outcomes are random. Occurrence of one outcome does not affect the outcome of the other.
#Outcomes are rare compared to possible outcomes

#poisson is the probability of x based on a known mean
#P(x, mu)

#In R we have 
#rpois,
#ppois, 
#qpois 
#dpois, 

# Sample Question: On a booking counter, 
# on the average 3.6 people coming every 10 minutes on weekend. 
# What is the probability of getting 7 people in 10 minutes?
#7 is the weird occurence we are looking for. Our known occurence is 3.6
#dpois gives the answer straight away
dpois(7,3.6)
#or 
ppois(7,3.6) - ppois(6,3.6)


