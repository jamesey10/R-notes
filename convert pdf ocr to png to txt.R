## run these packages
library(pdftools)
library(tesseract)

## convert pdf to png - generally better -
## converts a tought to crack pdf to a png
## then to a pdf
## then to a file named text.txt
## might take a few (10-15) minutes
pngfile <- pdftools::pdf_convert("C:\\Users\\james\\Desktop\\Article 2\\FWpdf\\fssd.pdf", dpi = 600)
text <- tesseract::ocr(pngfile)
cat(text)
write.table(text, "text.txt", append = FALSE, sep = " ", dec = ".",
            row.names = TRUE, col.names = TRUE)


## convert pdf to txt using tesseract only
## an alternative that might be faster if a password protected pdf isnt the issue
eng <- tesseract("eng")
text2 <- tesseract::ocr("C:\\Users\\james\\Desktop\\Article 2\\FWpdf\\fssd.pdf", engine = eng)
cat(text2)
write.table(text2, "text2.txt", append = FALSE, sep = " ", dec = ".",
            row.names = TRUE, col.names = TRUE)


