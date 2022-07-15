# Correlation and Linear Regression--------------------------------------------

# Exploratory Data Analysis
# 1. Measures of Central Tendency
# 2. Measures of Dispersion
# 3. Third Moment Business decision
# 4. Fourth Moment Business decision
# 5. Probability distributions of variables
# 6. Graphical representations
#  > Histogram,Box plot,Dot plot,Stem & Leaf plot, 
#     Bar plot


#Correlation coefficient value for x and y
#make some data
x <- seq(0,100, by=4)
y <- runif(26,20,40)
#then get r, the correlation. 
#it will be between -1 and 1
cor(x,y)
#make a linear model, using x and y
# the tilde is a regress command
reg<-lm(x~y)
#do a summary of a linear model. Get stats that tell:
#Estimate-std tells B0 and B1, p-values for each B0 and B1 are given
#R-squared values are given...hopefully bigger than 0.8
summary(reg)
#this makes a prediction value, with a confidence value
confint(reg,level = 0.95)

predict(reg,inteval="predict")


# Multiple Linear Regression ----------------------------------------------
#get data
#in this example, a theoretical spreadchseet calls cars is used

# do Exploratory Data Analysis
# 1. Measures of Central Tendency
# 2. Measures of Dispersion
# 3. Third Moment Business decision
# 4. Fourth Moment Business decision
# 5. Probability distributions of variables
# 6. Graphical representations
#  > Histogram,Box plot,Dot plot,Stem & Leaf plot, 
#     Bar plot

summary(Cars)

# 7. Find the correlation b/n Output (MPG) & (HP,VOL,SP)-Scatter plot
pairs(Cars)

# 8. Correlation Coefficient matrix - Strength & Direction of Correlation
cor(Cars)

### Partial Correlation matrix - Pure Correlation  b/n the varibles
#install.packages("corpcor")
library(corpcor)
cor2pcor(cor(Cars))

# The Linear Model of interest
model.car <- lm(MPG~VOL+HP+SP+WT)
summary(model.car)

# Prediction based on only Volume 
model.carV<-lm(MPG~VOL)
summary(model.carV) # Volume became significant

# Prediction based on only Weight
model.carW<-lm(MPG~WT)
summary(model.carW) # Weight became significant

# Prediction based on Volume and Weight
model.carVW<-lm(MPG~VOL+WT)
summary(model.carVW) # Both became Insignificant

# So there exists a collinearity problem b/n volume and weight
### Scatter plot matrix along with Correlation Coefficients
panel.cor<-function(x,y,digits=2,prefix="",cex.cor)
{
  usr<- par("usr"); on.exit(par(usr))
  par(usr=c(0,1,0,1))
  r=(cor(x,y))
  txt<- format(c(r,0.123456789),digits=digits)[1]
  txt<- paste(prefix,txt,sep="")
  if(missing(cex.cor)) cex<-0.4/strwidth(txt)
  text(0.5,0.5,txt,cex=cex)
}
pairs(Cars,upper.panel = panel.cor,main="Scatter plot matrix with Correlation coefficients")

# It is Better to delete influential observations rather than deleting entire column which is 
# costliest process
# Deletion Diagnostics for identifying influential observations
influence.measures(model.car)
library(car)
## plotting Influential measures 
influenceIndexPlot(model.car,id.n=3) # index plots for infuence measures
influencePlot(model.car,id.n=3) # A user friendly representation of the above

# Regression after deleting the 77th observation, which is influential observation
model.car1<-lm(MPG~VOL+SP+HP+WT,data=Cars[-77,])
summary(model.car1)

# Regression after deleting the 77th & 71st Observations
model.car2<-lm(MPG~VOL+SP+HP+WT,data=Cars[-c(71,77),])
summary(model.car2)

## Variance Inflation factor to check collinearity b/n variables 
vif(model.car)
## vif>10 then there exists collinearity among all the variables 

## Added Variable plot to check correlation b/n variables and o/p variable
avPlots(model.car,id.n=2,id.cex=0.7)

## VIF and AV plot has given us an indication to delete "wt" variable

## Final model
finalmodel<-lm(MPG~VOL+SP+HP)
summary(finalmodel)

# Evaluate model LINE assumptions 
plot(finalmodel)
#Residual plots,QQplot,std-Residuals Vs Fitted,Cook's Distance 
qqPlot(model.car,id.n = 5)
# QQ plot of studentized residuals helps in identifying outlier 


# Logistic Regression -----------------------------------------------------
#assume some data called claimants
View(claimants)
attach(claimants)

# Linear Regression
# the data is discrete, but lm() is for continuous data
fit<-lm(ATTORNEY~factor(CLMSEX)+factor(CLMINSUR)+factor(SEATBELT)+CLMAGE+LOSS)
summary(fit)
# Linear regression technique can not be employed because probability value is negative

# Logistic Regression 
#we call it a logit because the numbers are logarithmic
logit<-glm(ATTORNEY~factor(CLMSEX)+factor(CLMINSUR)+factor(SEATBELT)+CLMAGE+LOSS,family=binomial,data = claimants)
summary(logit)
#even though the values are negative, they are log numbers.
#applting exp( ) will give the real values
# Odds Ratio
exp(coef(logit))

# Confusion matrix table 
# now we can look at probability values for a variable, like "response"
# this will make a big table showing probability of a correlation between
# the variable and all the other variables. lower than 0.05 is good. 
prob <- predict(logit,type=c("response"),claimants)
prob

# there will be matches and mismatche between the dataset, 
# so we make a confusion matrix
# this tells how many matches are correct.
confusion<-table(prob>0.5,claimants$ATTORNEY)
confusion

# Model Accuracy 
# we want to know the ratio of correct matches
Accuracy<-sum(diag(confusion)/sum(confusion))
Accuracy

# ROC ---------------------------------------------------------------------


