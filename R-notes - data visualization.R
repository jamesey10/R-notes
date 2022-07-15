#Data Visualizations


# Super Basic Plotting -----------------------------------------------------
#have some data
a <- c(10,13,14,10,12,17)
b <- c(15,17,19,13,13,19)
#make a basic scatter
plot(a,b)
#adding a title, xaxis label, and yaxis label
plot(a,b,main="Arrival vs Departure Delay", xlab="Arrival Delay", ylab="Departure Delay")
#add a slope-intercept line
abline(0,1)

#Changing Plot Character (pch=)
#1. Circle 2. Triangle 3. Plus 
# 4. Cross 5. Diamond, 
#6. Reverese triangle 7. Box and crossed
plot(a,b, pch=5)
#add some color
plot(a,b,col="red")
#make it a scatter with connecting lines 
plot(a,b,type = "l")
#make it a scatter with line with points
plot(a,b,type = "b")

#make a histogram
a <- runif(15)
b <- runif(15)
hist(a)
#add breaks
hist(a, breaks = 10)

#make a boxplot
a <- runif(15)
b <- runif(15)
#make a box of just a
boxplot(a)
#make a boxplot of a and b
boxplot(a,b)

#make boxplots in two seprate grapsh
#par partitions them 
#make sure to run it all together
par(mfrow=c(1,2))
boxplot(a)
boxplot(b)

#go crazy with 2 histograms and 2 boxplots
par(mfrow=c(2,2))
boxplot(a, ylim = c(0,1))
boxplot(b, ylim = c(0,1))

hist(a, main="A", 
     xlim = c(0,1), ylim = c(0,1))
hist(b, main="B", 
     xlim = c(0,1), ylim = c(0,1))



# Real Plotting -------------------------------------------------------------------
#all plots need these 3 things
# 1. Data        - a dataframe, matrix, vector, whatever
# 2. Aesthetics  - what we want to show
# 3. Geometrics  - axis, labels, scatters, lines, boxes...

#and there are 3 optional things
# 4. Facets - muliple plots one one canvas, guide lines, shadow guides
# 5. Coordinates -  coordinated limits
# 6. Stats Layer - interesting points

#and there can be a them-color, thickness, fonts

#install and run ggplot2

#ALL GGPLOTS ARE KIND OF LIKE THIS:
#First the DATA is defined
ggplot(data= <default data set>, aes(x= <default x axis variable>, 
                                     y= <default y axis variable>,
                                ... <other default aesthetic mappings>),
                                ... <other plot defaults>) +  #note the plus-sign 
#second the GEOMETRICS are assigned after a plus sign
geom_<geom type>(aes(size = <size variable for this geom>, 
                                ... <other aesthetic mappings>),
                             data = <data for this point geom>,
                             stat = <statistic string or function>,
                             position = <position string or function>,
                             color = <"fixed color specification">,
                            <other arguments, possibly passed to the _stat_ function) +
#third, AESTHETICS are assigned, after a plus sign
scale_<aesthetic>_<type>(name = <"scale label">,
                           breaks = <where to put tick marks>,
                           labels = <labels for tick marks>,
                                ... <other options for the scale>) +
#fourth, some customization, after a plus sign
theme(plot.background = element_rect(fill = "gray"),
        ... <other theme elements>)

# Histogram ---------------------------------------------------------------
# Pass a column straight into hist()
# run the ggplot package... library(ggplot2)
#make a dataframe out of the built in movies dataset
df <- movies <- movies[sample(nrow(movies), 1000), ]
#Using qplot
qplot(rating,data=df,geom='histogram',binwidth=0.1,alpha=0.8)

#using ggplot
# ggplot(data, aesthetics)
pl <- ggplot(df,aes(x=rating))
# Add Histogram Geometry
pl + geom_histogram()
pl + geom_histogram(binwidth=0.1,color='red',fill='pink')
pl + geom_histogram(binwidth=0.1,color='red',fill='pink') + xlab('Movie Ratings')+ ylab('Occurences') + ggtitle(' Movie Ratings')
pl + geom_histogram(binwidth=0.1,fill='blue',alpha=0.4) + xlab('Movie Ratings')+ ylab('Occurences')
pl + geom_histogram(binwidth=0.1,color='blue',fill='pink',linetype='dotted') + xlab('Movie Ratings')+ ylab('Occurences')
pl + geom_histogram(binwidth=0.1,aes(fill=..count..)) + xlab('Movie Ratings')+ ylab('Occurences')
# Adding Labels
pl2 <- pl + geom_histogram(binwidth=0.1,aes(fill=..count..)) + xlab('Movie Ratings')+ ylab('Occurences')
# scale_fill_gradient('Label',low=color1,high=color2)
pl2 + scale_fill_gradient('Count',low='blue',high='red')
# scale_fill_gradient('Label',low=color1,high=color2)
pl2 + scale_fill_gradient('Count',low='darkgreen',high='lightblue')
#Adding density plot
pl + geom_histogram(aes(y=..density..)) + geom_density(color='red')


# Scatter plots with ggplot2 -----------------------------------------------

#library('ggplot2')
#get some data, like this dataframe example from the built in mtcars
df <- mtcars
#this makes a scatter plot of wt, mpg, from the df, using qplot (a ggplot tool)
qplot(wt,mpg,data=df)
#this adds some color
qplot(wt,mpg,data=df,color=cyl)
#This adds size to the points
qplot(wt,mpg,data=df,size=cyl)
#or both!!! 
qplot(wt,mpg,data=df,size=cyl,color=cyl)
# Show 4 features (this gets messy)
qplot(wt,mpg,data=df,size=cyl,color=hp,alpha=0.6)

#a bunch of ways to make the previous plot, but using geom_point
pl <- ggplot(data=df,aes(x = wt,y=mpg)) 
pl + geom_point()
pl + geom_point(aes(color=cyl))
pl + geom_point(aes(color=factor(cyl)))
pl + geom_point(aes(size=factor(cyl)))
pl + geom_point(aes(shape=factor(cyl)))
pl + geom_point(aes(shape=factor(cyl),color=factor(cyl)),size=4,alpha=0.6)
pl + geom_point(aes(colour = hp),size=4) + scale_colour_gradient(high='red',low = "blue")

# Box Plots ---------------------------------------------------------------

#use the packagae.... library(ggplot2)
#get some data...
df <- mtcars

#qplot it
qplot(factor(cyl), mpg, data = mtcars, geom = "boxplot")

#ggplot
#define what you want plotted
pl <- ggplot(mtcars, aes(factor(cyl), mpg))
#basic
pl + geom_boxplot()
#flip it
pl + geom_boxplot() + coord_flip()
#some color
pl + geom_boxplot(aes(fill = factor(cyl)))
#Some outline color
pl + geom_boxplot(fill = "grey", color = "blue")


# 2 Variable Plotting -----------------------------------------------------

#run the library(ggplot2)
#get a dataset
df <- movies
# using qplot()
qplot(x=year, y=rating, data = df, geom = "density2d")

#using ggplot()
#define the plot
pl <- ggplot(movies,aes(x = year,y=rating))
pl + geom_bin2d()
# Control bin sizes
pl + geom_bin2d(binwidth=c(2,1))
# Hex Plot
pl + geom_hex()
#hex with colors and a gradient heat map
pl + geom_hex() + scale_fill_gradient(high='red',low='blue')


# BAR Plot ----------------------------------------------------------------
#run and use library(ggplot2)
#define some data
df <- mtcars
#definte your plot
# counts (or sums of weights)
g <- ggplot(mpg, aes(class))
# Number of cars in each class:
g + geom_bar()
# Bar charts are automatically stacked when multiple bars are placed
# at the same location
g + geom_bar(aes(fill = drv))
#make a 100% bar plot
g + geom_bar(aes(fill = drv), position = "fill")
# You can instead dodge, rather than stack or fill them
g + geom_bar(aes(fill = drv), position = "dodge")



# Coordinates and Faceting with ggplot2 -----------------------------------

#Learning how to deal with coordinates will allow us to size our plots correctly.
#Faceting will allow us to place several plots next to each other
# these plots are usually related by the same dataset

#run library(ggplot2)
#have some data
df <- mtcars
#define a plot
pl <- ggplot(mpg,aes(x=displ,y=hwy)) + geom_point()
#set xlimits and ylimits to kill dead space
pl + coord_cartesian(xlim=c(1,4),ylim=c(15,30))
# or use aspect ratios
# aspect ratio, expressed as y / x
pl + coord_fixed(ratio = 1/3)

#More Examples
p <- ggplot(mpg, aes(displ, cty)) + geom_point()

p + facet_grid(. ~ cyl)
p + facet_grid(drv ~ .)
p + facet_grid(drv ~ cyl)

# To change plot order of facet grid,
# change the order of variable levels with factor()

# If you combine a facetted dataset with a dataset that lacks those
# facetting variables, the data will be repeated across the missing
# combinations:
df <- data.frame(displ = mean(mpg$displ), cty = mean(mpg$cty))
p +
  facet_grid(. ~ cyl) +
  geom_point(data = df, colour = "red", size = 2)

# Free scales -------------------------------------------------------
# You can also choose whether the scales should be constant
# across all panels (the default), or whether they should be allowed
# to vary
mt <- ggplot(mtcars, aes(mpg, wt, colour = factor(cyl))) +
  geom_point()

mt + facet_grid(. ~ cyl, scales = "free")

# If scales and space are free, then the mapping between position
# and values in the data will be the same across all panels. This
# is particularly useful for categorical axes
ggplot(mpg, aes(drv, model)) +
  geom_point() +
  facet_grid(manufacturer ~ ., scales = "free", space = "free") +
  theme(strip.text.y = element_text(angle = 0))

# Facet labels ------------------------------------------------------
p <- ggplot(mtcars, aes(wt, mpg)) + geom_point()
p

# label_both() displays both variable name and value
p + facet_grid(vs ~ cyl, labeller = label_both)

# label_parsed() parses text into mathematical expressions, see ?plotmath
mtcars$cyl2 <- factor(mtcars$cyl, labels = c("alpha", "beta", "sqrt(x, y)"))
ggplot(mtcars, aes(wt, mpg)) +
  geom_point() +
  facet_grid(. ~ cyl2, labeller = label_parsed)

# label_bquote() makes it easy to construct math expressions
p + facet_grid(. ~ vs, labeller = label_bquote(cols = alpha ^ .(vs)))

# The facet strips can be displayed near the axes with switch
data <- transform(mtcars,
                  am = factor(am, levels = 0:1, c("Automatic", "Manual")),
                  gear = factor(gear, levels = 3:5, labels = c("Three", "Four", "Five"))
)
p <- ggplot(data, aes(mpg, disp)) + geom_point()
p + facet_grid(am ~ gear, switch = "both")
# It looks better without boxes around the strips
p + facet_grid(am ~ gear, switch = "both") +
  theme(strip.background = element_blank())

# Margins ----------------------------------------------------------

# Margins can be specified by logically (all yes or all no) or by specific
# variables as (character) variable names
mg <- ggplot(mtcars, aes(x = mpg, y = wt)) + geom_point()
mg + facet_grid(vs + am ~ gear)
mg + facet_grid(vs + am ~ gear, margins = TRUE)
mg + facet_grid(vs + am ~ gear, margins = "am")
# when margins are made over "vs", since the facets for "am" vary
# within the values of "vs", the marginal facet for "vs" is also
# a margin over "am".
mg + facet_grid(vs + am ~ gear, margins = "vs")
mg + facet_grid(vs + am ~ gear, margins = "gear")
mg + facet_grid(vs + am ~ gear, margins = c("gear", "am"))





# Plotting a normal Distribution with VISUALIZE ---------------------------
#Creates a line
8.2 in notes


# Plotting Binomial Distribution ------------------------------------------
#Creates a histogram

