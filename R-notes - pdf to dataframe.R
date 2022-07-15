library(pdftools)
library(readr)
library(dplyr) 

#online PDF file to dataframe
url <- "https://github.com/averyrobbins1/avery-robbins-resume.pdf?raw=true"
temp <- tempfile()
download.file(url, temp, mode = "wb")
dat <- pdftools::pdf_text(temp)

#Local PDF file to dataframe
dat2 <- pdftools::pdf_text("pdfconverttest/Abbott 2013 Abbott Global Citizenship Report.pdf")


#Convert a whole directory of pdfs to text
dat3 <- fs::dir_ls("pdfconverttest") %>% 
  purrr::walk(~ pdftools::pdf_text(.x))
