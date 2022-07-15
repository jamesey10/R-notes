#packages needed
library(pdftools)# install.packages("pdftools")
library(ggplot2)
library(tm) #text mining
library(SnowballC) #stemming - reducing words to their root
library(wordcloud)
library(stringr) #for str_trim
library(plyr)

# folder with PDFs, relative to set directory
GRIdest <- "GRIpdfs"
ARdest  <- "ARpdfs"

# a vector of PDF file names using the list.files function.
# The pattern argument says to only grab those files ending with "pdf":
GRIcorpus <- list.files(path = GRIdest, pattern = "pdf",  full.names = TRUE)
ARcorpus <- list.files(path = ARdest, pattern = "pdf",  full.names = TRUE)


files <- list.files(pattern = "pdf$")
# convert each PDF file that is named in the vector into a text file 
# text file is created in the same directory as the PDFs

lapply(mycorpus, pdf_text)
