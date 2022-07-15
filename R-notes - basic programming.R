#R-Programming

# Text --------------------------------------------------------------------
#TEXT STRINGS
print('Just a string')
var <- 'a variable'
#cat command combines strings with commas
cat('My variable is: ',var)
#Output:  My variable is: a variable
var <- 25
cat('My number is:',var)
#Output:  My number is: 25
# Could also use this to get: Output: "Variable is: 25"
# paste command combines with commas
print(paste0("Variable is: ", var))


# Logical Operators -------------------------------------------------------
#Logical Operators will allow us to combine multiple comparison operators.
#The logical operators we will learn about are:
#   AND - &
#     OR - |
#   NOT - !
  
# Imagine the variable x
x <- 10
#Now we want to know if 10 is less than 20 AND greater than 5:
 x < 20                        #Tells us TRUE
 x > 5                         #Tells us TRUE
 x < 20  &  x > 5              #Tells us TRUE
(x < 20) & (x > 5)             #Tells us TRUE
(x < 20) & (x > 5) & (x == 10) #Tells us TRUE
 #and if we enter something that's a lie
 x < 2    & x > 1              #Tells us FALSE

# You can think about NOT as reversing any logical value in front of it,
# basically asking, "Is this NOT true?" For example: 
# ! is the symbol
  (10==1) # statement says "this is true" #output is FALSE
 !(10==1)  #Statement says "this is not true #output is TRUE
 !!(10==1) #Statement says "this is not,not, true #output is FALSE
 !!!(10==1) #Statement says "this is not,not,not, true #output is TRUE
 

# If Else ElseIf ----------------------------------------------------------

#IF, ELSE, ELSE IF, statements syntax for Coding
 
#IF
# if some condition is true 
#then execute the code inside of the curly brackets.
#This code can be highlighted and then hit ctrl+entr
 if(1 ==   1)
    {      print('hi')    }
 
 
#explanation with a weather report
#First Variables are set. These can be changed to test
  hot <- FALSE
 temp <- 10
 
 #Then code is written
 if (temp > 80){   #if the temp is greater than 80
   hot <-TRUE  # Execute some code. 
 }
 print(hot)
 
#ELSE
#do some other code
 temp <- 30 #this can be changed to test the code
 
 if (temp > 90){
   print("Hot outside!")
 } else{
   print("Its not too hot today!")
 }
 
 #ELSE IF
 temp <- 42                           #this can be changed to test the code
 
 if (temp > 80){                      #a condition
   print("Hot outside!")
 } else if(temp<80 & temp>50){        #first option
   print('Nice outside!') 
 } else if(temp <50 & temp > 32){     #another option
   print("Its cool outside!")
 } else{                              #a third option
   print("Its really cold outside!")
 }
 

# While Loops -------------------------------------------------------------

 
# WHILE LOOPS
# while loops are a way to have your program continuously run some block of code 
# UNTIL
#  a condition is met (made TRUE). The syntax is:
  while (condition){
   # Code executed here 
   # while condition is true
 }
 
# A while loop example
xx <- 0
while(xx < 10){                                     #While xx is less than 10
    cat('xx is currently: ',xx)                      #do the following
  print(' xx is still less than 10, adding 1 to xx') 
  #add one to xx
    xx <- xx+1
}
 


# Adding an IF to the WHILE LOOP logic!
xxx <- 0
while(xxx < 10){
  cat('xxx is currently: ',xxx)
  print(' xxx is still less than 10, adding 1 to xxx')
  # add one to x
  xxx <- xxx+1
  if(xxx==5) {
    print("whoa we're halfway there")
  }
  if(xxx==10){
    print("xxx is equal to 10! Terminating loop")
  }
}
 
#BREAKING A WHILE
#Unbroken Loop
x <- 0
while(x < 10){
  cat('x is currently: ',x)
  print(' x is still less than 10, adding 1 to x')
    # add one to x
  x <- x+1
  
  if(x==10){
    print("x is equal to 10!")
    print("I will also print, woohoo!")
  }
}

#Breaking a While Loop
x <- 0
while(x < 10){
  cat('x is currently: ',x)
  print(' x is still less than 10, adding 1 to x')
  # add one to x
  x <- x+1
  if(x==10){
    print("x is equal to 10!")
    break
    print("I will also print, woohoo!")
  }
}

# For Loops ---------------------------------------------------------------


#FOR Loops
#A for loop allows us to iterate over an object (such as a vector)
#and we can then perform and execute blocks of codes for every loop
#The syntax for a for loop is:
for (temporary_variable in object){
  # Execute some code at every loop
}

#For loop with a vector example
#make a vector
vec <- c(1,2,3,4,5)
#run some code
#the temporary variable we make up on the fly in this case is temp_var
#in refers the temp variable to the vector
for (temp_var in vec){
  print(temp_var)
}
#we can do this with a matrix too
#this makes a 5x5 matrix
mat <- matrix(1:25,nrow=5)
print(mat)
for (number in mat){
  print(number)
}

#With the matrix, we can do NESTED FOR LOOPS
for (row in 1:nrow(mat)){
  for (col in 1:ncol(mat)){
    print(paste('The element at row:',row,'and col:',col,'is',mat[row,col]))
  }
}
print(mat) #for the sake of checking what just happened


# Functions ---------------------------------------------------------------


#FUNCTIONS
#A set of statements written to be repeatedly run,
# and accepts input parameters
#basic layout

name_of_function <- function(arg1,arg2,...){
  # Code that gets executed when function is called
}

# Simple function, no inputs!
hello <- function() {
  print('hello!')
}
#the function above is written. execute it like this
hello()

# Simple function, 1 input!
helloyou <- function(name){
  print(paste('hello ',name))
}
#the function above is written. execute it like this
helloyou('James')

# Simple function, 1 input!
#we name the funcion <- function(argument 1, argument 2)
add_num <- function(num1,num2){
  print(num1+num2)
}
#the function above is written. execute it like this
#functionName(argument1,argument2)
add_num(5,10)


#Function with a Default Setting

hello_someone <- function(name='Frankie'){
  print(paste('Hello ',name))
}
#Then we execute
# uses default
hello_someone()  #outputs Hello Frankie, the default
# overwrite default
hello_someone('Sammy') #outputs Hello Sammy, the argument


#Return Values in Function
#the arguments are given names
#return stores and updates variables
formal <- function(name='Sam',title='Sir'){
  return(paste(title,' ',name))
}

formal()
formal('Issac Newton')
formal('mary curie','ms')

#Scope
#is global - variables outside of functions
#is limited - variables in a function
#print(v) will check for the global variable v, the outer scope
#print(stuff) will also check for the global variable stuff
#fun(stuff) will accept an argument stuff, print out v, and then reassign stuff 
#(in the scope of the function) and print out stuff. Notice two things:

#1. The reassignment of stuff only effects the scope of the stuff variable 
      #inside the function
#2. he fun function first checks to see if v is defined at the function scope,
      #if not (which was the case) it will then 
         #search the global scope for a variable names v, 
          #leading to it printing out "I'm global v".

v <- "I'm global v" #a global variable for all of R to use
stuff <- "I'm global stuff" #another global variable for all of R to use
#a function named fun, with an argument called stuff
fun <- function(stuff){
  print(v) 
  stuff <- 'Reassign stuff inside func'
  print(stuff)
}
print(v) #print v
print(stuff) #print stuff
fun(stuff) # pass stuff to function
# reassignment only happens in scope of function
print(stuff)

#another global and limited scope example
double <- function(a) {
  a <- 2*a
  a
}
var <- 5
double(var)
var


# Advanced R Programming --------------------------------------------------
#Generate a sequence
# start, end, by 5's? 10? 2s? whatever
print(seq(0,100,by=2))


#combine two vecotrs using append
vec1 <- c(1,2,3)
vec2 <- c(4,5)
print(append(vec1,vec2))

#Sorting
#vector name, decreasing variable
print(sort(vec1, decreasing=TRUE))
print(sort(vec1, decreasing=FALSE))

#Reversing a Vector
#rev(vector-name)
print(rev(vec1))

#Is something a vector, matrix, dataframe....
print(is.vector((vec1)))
print(is.matrix((vec1)))
print(is.data.frame((vec1)))


#Convert a datatype to another data type
#elements must be the same...numbers, characters...
#make a matrix out of vec1
as.matrix((vec1))
#make a dataframe out of vec1
as.data.frame((vec1))



# Apply Function ----------------------------------------------------------

#lapply Takes a vector, applies each element to a function
#lapply(vec1, some function)
#sapply(vec1, some function)
#vapply(vec1, some function)

# vector
v <- c(1,2,3,4,5)

# our custom function
addrand <- function(x){
  # Get a random number
  ran <-sample(x=1:10,1)
  
  # return x plus the random number
  return(x+ran)
}

# lapply()
lapply(v,addrand)

# Math Functions ----------------------------------------------------------

x <- 69.123456789
y <- 96.23432
abs(x) 	#absolute value
sqrt(x) 	#square root
ceiling(x) 	#ceiling(3.475) is 4
floor(x) 	#floor(3.475) is 3
trunc(x) 	#trunc(5.99) is 5
round(x, digits=4) 	#round(3.475, digits=2) is 3.48
signif(x, digits=5) 	#signif(3.475, digits=2) is 3.5
cos(x) sin(x) tan(x) 	acos(x) cosh(x) acosh(x) #etc.
log(x) 	#natural logarithm
log10(x) 	#common logarithm
exp(x) 	#e^x

x%%y #what is the remainder when x is divided by y
x%/%y #what is the quotient when x is divided by y


# Time Stamps -------------------------------------------------------------
#today's day'
Sys.Date()
#covert characters to date
as.Date(1990)

# YYYY-MM-DD
as.Date('1990-11-03')
# Using Format
as.Date("Nov-03-90",format="%b-%d-%y")
# Using Format
as.Date("November-03-1990",format="%B-%d-%Y")
## locale-specific version of date()
format(Sys.time(), "%a %b %d %X %Y %Z")
## time to sub-second accuracy (if supported by the OS)
format(Sys.time(), "%H:%M:%OS3")

## read in date info in format 'ddmmmyyyy'
## This will give NA(s) in some locales; setting the C locale
## as in the commented lines will overcome this on most systems.
## lct <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME", "C")
x <- c("1jan1960", "2jan1960", "31mar1960", "30jul1960")
z <- strptime(x, "%d%b%Y")
## Sys.setlocale("LC_TIME", lct)
z

## read in date/time info in format 'm/d/y h:m:s'
dates <- c("02/27/92", "02/27/92", "01/14/92", "02/28/92", "02/01/92")
times <- c("23:03:20", "22:29:56", "01:03:30", "18:21:03", "16:56:26")
x <- paste(dates, times)
strptime(x, "%m/%d/%y %H:%M:%S")

## time with fractional seconds
z <- strptime("20/2/06 11:16:16.683", "%d/%m/%y %H:%M:%OS")
z # prints without fractional seconds
op <- options(digits.secs = 3)
z
options(op)

## time zones name are not portable, but 'EST5EDT' comes pretty close.
(x <- strptime(c("2006-01-08 10:07:52", "2006-08-07 19:33:02"),
               "%Y-%m-%d %H:%M:%S", tz = "EST5EDT"))
attr(x, "tzone")

## An RFC 822 header (Eastern Canada, during DST)
strptime("Tue, 23 Mar 2010 14:36:38 -0400",  "%a, %d %b %Y %H:%M:%S %z")

## Make sure you know what the abbreviated names are for you if you wish
## to use them for input (they are matched case-insensitively):
format(seq.Date(as.Date('1978-01-01'), by = 'day', len = 7), "%a")
format(seq.Date(as.Date('2000-01-01'), by = 'month', len = 12), "%b")

# Regular Expressions -----------------------------------------------------
#grep = general regular expressions

#a text string is assigned, and named text.sample
text.sample <- "Hi there, do you know who you are voting for?"
#the grep looks for a certain word, "voting" in the string named text.sample
#This will output TRUE
grepl('voting',text.sample)
#This will output FALSE
grepl('jamesey',text.sample)





