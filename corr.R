corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations

  
#   getComplete <- function(filename){
#     path <- paste(directory, "/", filename, sep="")
#     data <- read.csv(path)
#     #data[1:2,]
#     data[complete.cases(data),]
#   }
#   
#   valid <- function(df){
#     nrow(df) > threshold
#   }
#   
  getCorr <- function(id){
    filename <- paste(directory, "/", formatC(id, width=3, flag="0"), ".csv", sep="")
    data <- read.csv(filename)
    good <- data[complete.cases(data),]
    cor(good$nitrate, good$sulfate)
  }
  
  rowCounts <- complete(directory)
  overThreshold <- rowCounts$id[rowCounts$nobs > threshold]
  sapply(overThreshold, getCorr)
}

