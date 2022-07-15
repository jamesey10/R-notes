## Put this R-script in the text file directory
## there might be errors if there are subdirectories
## just run in

filelist = list.files(pattern = ".txt")

for (i in 1:length(filelist)) {
  cur.input.file <- filelist[i]
  cur.output.file <- paste0(cur.input.file, ".csv") 
  print(paste("Processing the file:", cur.input.file))
  
  # If the input file has less than 11 rows you will reveive the error message:
  # "Error in read.table: no lines available in input")
  data = read.delim(cur.input.file, header = TRUE)
  write.table(data, file=cur.output.file, sep=",", col.names=TRUE, row.names=FALSE)
}
