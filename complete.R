complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  getComplete <- function(id){
    filename <- paste(directory, "/", formatC(id, width=3, flag="0"), ".csv", sep="")  
    #print(filename)
    data <- read.csv(filename)
    good <- complete.cases(data)
    nrow(data[good,])
  }
  
  complete <- sapply(id, getComplete)
  data.frame(id=id, nobs=complete)
}