
#Set working directory
 setwd("C:/Users/james/R/ARpdfs")
 
 #assuming you are in the working directory with all the pdfs, 
 #use list.files to make a list of the pdfs
 files <- list.files(pattern = ".pdf$")

 #turn that list into a dataframe
  df <- data.frame(files)
  
  #write the data frame to a csv
 write.csv(df,"C:\\Users\\james\\Desktop\\MyData.csv", row.names = FALSE)
