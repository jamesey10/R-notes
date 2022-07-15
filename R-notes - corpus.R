library(qdap)
library(readr)
library(tm)
library(pdftools)



#reading one file
# Import text data one file
grireport <- read_csv("pdfconverttest/Abbott 2013 Abbott Global Citizenship Report.pdf")
nrow(grireport)


#import a corpus of many pdfs
directory <- "C://Users//james//R//pdfconverttest" # change this to directory where files are located

# read the pdfs with readPDF, default engine used is pdftools see ?readPDF for more info
GRIcorpus <- VCorpus(DirSource(directory, pattern = ".pdf"), 
                     readerControl = list(reader = readPDF))
#get data about document #15
GRIcorpus[[15]]
#some info about the 15th document
str(GRIcorpus[[15]])
# Print the content of the 15th document
GRIcorpus[[15]][1]

# folder with PDFs, relative to set directory
ReportDest <- "pdfconverttest"
# a vector of PDF file names using the list.files function.
# The pattern argument says to only grab those files ending with "pdf":
GRICorpusnames <- list.files(path = ReportDest, pattern = "pdf",  full.names = TRUE)
files <- list.files(path = ReportDest, pattern = "pdf",  full.names = TRUE)


example_text <- data.frame(title = files, stringsAsFactors = FALSE)
# Create a DataframeSource on columns 2 and 3: df_source
df_source <- DataframeSource(example_text[])
# Convert df_source to a corpus: df_corpus
df_corpus <- VCorpus(example_text,GRIcorpus)
# Examine df_corpus
df_corpus
