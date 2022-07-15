#manipulating dataframe data in R


# DPLYR - filter, arrange, slice, mutate, summarise, pull sample ----------


#Dplyr is a really good package for this
#install.packages('dplyr')

#open the practice data that comes from R, called nycflights
library(nycflights13)
summary(flights)


#filter out data from the huge dataset
head(filter(flights,month==11,day==3,carrier=='AA'))
#A better,more legible way to write this, with brackets [ ] and $
head(flights[flights$month == 11 & flights$day == 3 & flights$carrier == 'AA', ])


#We can select rows by position using slice()
slice(flights, 1:10)

#arrange() works similarly to filter() 
#except that instead of filtering or selecting rows, 
#it reorders them.
#It takes a data frame, 
# and a set of column names (or more complicated expressions) to order by. 
#If you provide more than one column name, 
#each additional column will be used to break ties in the values of preceding columns
#arrange is a dplyr command. 
#filter comes with R
head(arrange(flights,year,month,day,air_time))

#select() -  a dplyr function
#Often you work with large datasets with many columns
#but only a few are actually of interest to you.
#select() allows you to rapidly zoom in on a useful subset 
#using operations that usually only work on numeric variable positions:
head(select(flights,carrier))

#You can use rename() to rename columns, 
#note this is not "in-place" 
#you'll need to reassign the renamed data structures.
head(rename(flights,airline_car = carrier))

#select() 
#find the values of a set of variables. 
#This is particularly useful in conjunction with the distinct() 
# which only returns the unique values in a table.
distinct(select(flights,carrier))


#mutate()
#Besides selecting sets of existing columns, 
#it's often useful to add new columns that are functions of existing columns. 
#This is the job of mutate():
head(mutate(flights, new_col = arr_delay-dep_delay))
#Use transmute if you only want the new columns:
head(transmute(flights, new_col = arr_delay-dep_delay))
  
#use summarise() to quickly collapse data frames 
#into single rows using functions that aggregate results.
#Remember to use na.rm=TRUE to remove NA values.
summarise(flights,avg_air_time=mean(air_time,na.rm=TRUE))

#You can use sample_n() and sample_frac() 
#to take a random sample of rows: use sample_n() 
#for a fixed number and sample_frac() for a fixed fraction.
sample_n(flights,10)
# .005% of the data
sample_frac(flights,0.00005)


# # TIDYR -----------------------------------------------------------------


# TIDYR

#Install and run Tidyr
#install.packages('tidyr',repos = 'http://cran.us.r-project.org')
#library(tidyr)
#library(data.table)

#create some sample data
# 3 company's with 3 reporting years put into a vector
comp <- c(1,1,1,2,2,2,3,3,3)
#the correspsonding year for each company reporting period put in a vector
yr <- c(1998,1999,2000,1998,1999,2000,1998,1999,2000)
# 9 random quarterly numbers between 0 and 100 put into vectors
q1 <- runif(9, min=0, max=100)
q2 <- runif(9, min=0, max=100)
q3 <- runif(9, min=0, max=100)
q4 <- runif(9, min=0, max=100)
#making a dataframe out of the vectors
df <- data.frame(comp=comp,year=yr,Qtr1 = q1,Qtr2 = q2,Qtr3 = q3,Qtr4 = q4)


# gather ------------------------------------------------------------------


#The gather() function will collapse multiple columns 
#into key-pair values. 
#The data frame I just made is considered wide
#since the time variable (represented as quarters)
#is structured such that each quarter represents a variable.

#To re-structure the time component as an individual variable, 
#we can gather each quarter within one column variable 
#and also gather the values associated with each quarter 
#in a second column variable.
#normal
gather(df,Quarter,Revenue,Qtr1:Qtr4)
# Using Pipe Operator
df %>% gather(Quarter,Revenue,Qtr1:Qtr4)


# spread ------------------------------------------------------------------
#This is the complement of gather(), 
#which is why its called spread():

#make some dataframe
stocks <- data.frame(
  time = as.Date('2009-01-01') + 0:9,
  X = rnorm(10, 0, 1),
  Y = rnorm(10, 0, 2),
  Z = rnorm(10, 0, 4)
)

#shows some stocks for company's x,y, and z over 10 days
print(stocks)
#gather pulls the 3 company columns into one column
stocksm <- stocks %>% gather(stock, price, -time)
print(stocksm)
#spread expand the 3 company's from one column into how it originally was
print(stocksm %>% spread(stock, price))
#this spreads it by time
stocksm %>% spread(time, price)



# Separate and Unite------------------------------------------------------------------
#Given either regular expression or a vector of character positions, 
#separate() turns a single character column into multiple columns.

#this makes a dataframe of 1 columb with 4 rows where the data is combined
df <- data.frame(x = c(NA, "a.x", "b.y", "c.z"))
print(df)
#separates the column into two columns named ABC and XYZ. 
#NA is simpliy dupliacted
dfs <- df %>% separate(x, c("ABC", "XYZ"))
print(dfs)
#and they can be united again
unite_(dfs, "united", c("ABC","XYZ"),sep = '.')


# whatever is next --------------------------------------------------------


