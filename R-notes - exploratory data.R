library(tidyverse) 
library(janitor)
library(DataExplorer)
library(skimr)
library(trelliscopejs)
library(gapminder)
library(dplyr)
library(ggplot2)


#a quick look at the columns in a transposed view
glimpse(df)
#quick stats about missing data, completeness
df %>% introduce() %>% glimpse()

#clean column names
df %>% clean_names()

#make some histograms out of every column
df %>% plot_histogram()

#make some bars out of every column
df %>% plot_bar()

#makes a big report of correlations and stats about the data
#output to web browswer, html
df %>% create_report()




