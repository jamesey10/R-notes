
# Intro -------------------------------------------------------------------


#Data Science = computer science, math & stats, and Domain Knowledge
#Science + Domain Knowledge = software development
#Science + Math and STats = Machine Learning
#Domain Knowledge + Math and Stats = Research

#R is a Language
#R-Studio is an environment for doing R

#display an output
print('Hello World')
print(69)
print(2+3*5)

#Make a Variable, display it in console. <- sets the variable, is the assignment operator
#good practice to use lowercase and dots
a.variable <- 2
print(a.variable)

#Show how much is a remainder when doing division
# 5 / 2 has a remainder of 1
5%%2
print(5%%2)

# Character Types ---------------------------------------------------------


#Character Types 
# Numeric = decimal = floating point value = integer
#logical = boolean = ALL CAPS = TRUE, FALSE, T, or F
#characters = strings = set by using quote marks = " " or ' ' = "hello world"
#class command tells you the data type
class(a.variable) 

#Simple Comparison Operators < , > , = , <= , >= , == , !=
a <- 3
#Test comparisons result in TRUE OF FALSE. Answers can be assigned a variable
a < 3
a > 3
a = 3
a !=3


# Make a Vector -----------------------------------------------------------


#make a vector of data
#c(x,y,z) makes a vector out of inputs, a column or row of raw data
# c = combine
# cannot combine data types
#make and display a vector
my.vector1 <- c(1,3,5,7,9,11,13,15)
my.vector2 <- c(100,200,300,400,500,600,700,800)
print(my.vector1)
print(my.vector2)

#colon can be used to create a vector of numbers
one.to.ten <- 1:10
print(one.to.ten)

#name a vector
#Manually, one at a time
names(my.vector1) <- c("Tom","Dick","Harry","Phil","James","Keith","Chris","Tridi")
#Automatically with Names in a vector
#Naming with another vector
dudes <- c("Tom","Dick","Harry","Phil","James","Keith","Chris","Tridi") #a vector of names
names(my.vector1) <- c(dudes)

#adding vectors
vectors.added <- my.vector1 + my.vector2
print(vectors.added)


# Indexing and Slicing vectors --------------------------------------------

#INDEXING and SLICING Vectors
#display the second element in my.vector1
#BRACKET NOTATION [ ] indicates an index calling
my.vector1[2]
#display the 1st and 3rd element in my.vector1
my.vector1[c(1,3)]
dudes[c(1,3)]
#Slicing uses a colon
#pulls elements 2,3,4
my.vector1[2:4]
print(my.vector1[2:4])
#indexes elements greater than 5
my.vector1[my.vector1 > 5]
print(my.vector1[my.vector1 > 5])


# The Matrix --------------------------------------------------------------

#MATRICIES - MATRIX - ONE DATA TYPE ONLY
#Make a 1 column matrix from a vector
my.matrix1 <- matrix(my.vector1)
print(my.matrix1)

#make multi-column matrix from vector
my.matrix2 <- matrix(my.vector1,nrow=2)
print(my.matrix2)

#Make a Matrix by columns first, 4 rows
my.matrix3 <- matrix(my.vector1,byrow=FALSE,nrow=4)
print(my.matrix3)
#Make a Matrix by rows first, 4 rows
my.matrix4 <- matrix(my.vector1,byrow=TRUE,nrow=4)
print(my.matrix4)

#Math with matrixes....array arrangement (2x3, 4x2) must be the same in both
matrixes.multiplied <- my.matrix3*my.matrix4
print(matrixes.multiplied)
print(1 / my.matrix2)

#NAMING columns and rows in a matrix
#Columns
#First make a vector of the names
money <- c('Euros','Dollars')
hats <- c('blue','red','black','white')
#Second Assign names to the columns and rows. Array numbers much match
colnames(my.matrix3) <- money
rownames(my.matrix3) <- hats
print(my.matrix3)

#ADDING New COLUMNS or ROWS to MATRIX
cool.new.vector <- (1:4)
cool.new.vector2 <- (1:2)
#Add a Row
my.matrix1.withnewrow <- rbind(my.matrix4, cool.new.vector2)
print(my.matrix1.withnewrow)
#Add a Column
my.matrix1.withnewcol <- cbind(my.matrix4, cool.new.vector)
print(my.matrix1.withnewcol)

# Indexing and Slicing Matrices -------------------------------------------


#Matrix Slicing and Indexing
#[ ] Use Bracket Notation
#[2,2] - a coordinate in a matrix, row,column
print(my.matrix3[2,2])
#[1,]  - a coordinate in a matrix, row 1, blank column - grabs all of row 1
print(my.matrix3[2,])
#[,2]  - a coordinate in a matrix, blank row, column 2 - grabs all of col 2
print(my.matrix3[,2])
#[1:2, 1:3] - grabs rows 1&2 and cols 1,2,3
print(my.matrix3[2:3,1:2])

#Matrix FACTORS and CATEGORIES
#Factor list the various names of a vector
#first a data exists
animal <- c('dog','cat','dog','cat','cat')
id <- c(1,2,3,4,5)
factor.animal <- factor(animal)
print(factor.animal)

#Ordinal - order can be assigned
#First an ordered vector is set the way we want it
ord.cat <- c('cold','med','hot')
#Second, some data of nominal data words is made
temps <- c('cold','med','cold','med','hot','hot','cold')
#Third the temps in the data are ordered with the factor command
#Ordered=True = put them in order ; levels are assigned < , < , <
fact.temp <- factor(temps,ordered=TRUE,levels=c('cold','med','hot'))
print(fact.temp)


# Random Number Generator -------------------------------------------------


#Random Number Generation
#20 random numbers
print(runif(20))
#20 random numbers with a max and minimum
print(runif(20, min=100, max=500))
#20 random numbers with a max and minimum - PUT into a 4 row matrix 
print(matrix(runif(20, min=20, max=100),nrow=4))


# Rounding ----------------------------------------------------------------


#Rounding
a.decimal.vector <- c(1.32423, 7.23423, 23.234446, 2.9999999)
#insert vector name, and number of decimal places to round
print(round(a.decimal.vector, 3))


# DataFrames --------------------------------------------------------------


#DATAFRAMES - ALLOWS MULTIPLE Data Types (kind of like Excel)
#making a dataframe, use the data.frame command and add all the vector columns
my.dataframe <- data.frame(my.vector1,my.vector2)
print(my.dataframe <- data.frame(my.vector1,my.vector2))
#display some information about a dataframe...min, quartiles, max, mean
print(summary(my.dataframe))
#Display other information about a a dataframe (how many observations per variable)
print(str(my.dataframe))


#IMPORTING data frame from Excel - Using a CSV File
my.imported.dataframe <- read.csv("somecsvfile.csv")
#Saving a data frame as a csv (must have column and row names)
write.csv(my.dataframe, file ="mydataframe.csv")
#Importing an Excel file
#Install and run the package called readxl 
excel_sheets('excelfile.xlsx')
#Import excel sheet as a dataframe
a.dataframe <- read_excel('excelfile.xlsx', sheet="sheet 1")
#Import a workbook from Excel
my.workbook <- lapply(excel_sheets('excelfile.xlsx'),read_excel,path=file.xlsx)
#Saving to Excel - install and run the package xlsx


#pull a vector within the datafame
#Use $ command dataframename$columnname
print(my.dataframe$my.vector1)

#Pull data from a column based on some condition
#Subsets are one way
subset(my.dataframe,subset = my.vector2>300)
subset(my.dataframe, col.name.1 > 7, col.name.2 <700)
#[ ] Brackets are another way
my.dataframe[my.dataframe$my.vector1 > 7, my.dataframe$my.vector2 < 700]

#display first 6 rows (default)
print(head(my.dataframe))
#display head with 7 rows
print(head(my.dataframe,7))
#display last 6 rows
print(tail(my.dataframe))


# DataFrame Indexing and Slicing ------------------------------------------


#DataFrame Indexing and Slicing
#[ ] Use Bracket Notation
#[2,2] - a coordinate in a df, row,column
print(my.dataframe[2,2])
#[1,]  - a coordinate in a df, row 1, blank column - grabs all of row 1
print(my.dataframe[2,])
#[,2]  - a coordinate in a df, blank row, column 2 - grabs all of col 2
print(my.dataframe[,2])
#[1:2, 1:3] - grabs rows 1&2 and cols 1,2,3
print(my.dataframe[2:3,1:2])
#using column names and row names works too
print(my.dataframe["Phil","my.vector2"])

#Change the value of a "cell" in a dataframe - USE A REASSSIGN <-
my.dataframe[["Phil","my.vector1"]] <- 666
print(my.dataframe)  


# Column and Row Names in a DataFrame -------------------------------------


#Setting Column Names in a dataframe
colnames(my.dataframe)[2] <- '2nd col new name'
# Rename all at once with a vector
colnames(my.dataframe) <- c('new.col.name.1', 'new.col.name.2')

#Setting Row Names
#set row names Individually
rownames(my.datafame)[2] <- '2nd row new name'
#set row names with a vector
rownames(my.dataframe) <- c('new.row.name.1', 'new.row.name.2')


# DataFrame Sorting -------------------------------------------------------


#DATAFRAME Sort
#order command, dataframe name, column name with quotes
order(my.dataframe["my.vector1"])

#Adding Columns, add a column called NA
my.dataframe$newcol <- rep(NA, nrow(my.dataframe))
#Copying a column
my.dataframe[, 'copy.of.col2'] <- my.dataframe$col.name.2 
#Using an equation to make a new column, like copying a column and multiplying by 2
my.dataframe[['col1.times.2']] <- my.dataframe$col.name.1 * 2


# DataFrame Missing Data --------------------------------------------------


#Dealing with Missing Data
# detect anywhere in df if there is n/a, missing data. Repsonse will be TRUE or FALSE
any(is.na(my.dataframe))
## detect any missing data in a specific column
any(is.na(my.dataframe$col.name.1))
# delete selected missing data rows
my.dataframe <- my.dataframe[!is.na(my.dataframe$col), ]
# replace NAs with something else, like 0s
my.dataframe[is.na(df)] <- 0 
# replace NAs with something else, like 999s, For a selected column
my.dataframe$col[is.na(my.dataframe$col)] <- 999 


# Lists -------------------------------------------------------------------


#LISTS - combines vectors, matrices, or dataframes into one big thing
#make a list
my.list <- list(my.vector1, my.matrix1, my.dataframe)
print(my.list)
#make a list with each piece named
my.list <- list(vectorpieceoflist=my.vector1, matrixpieceoflist=my.matrix1, mydataframepiceoflist=my.dataframe)
print(my.list)


# Whatever is next --------------------------------------------------------



