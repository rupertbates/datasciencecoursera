rankall <- function(outcome, num = "best") {
  
  rankhospital <- function(state) {  
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    sorted <- getSortedState(data, state, colName)
    sorted$Hospital.Name[getPosition(sorted, num)]    
  }
  
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that outcome is valid
  
  colName <- getColName(outcome)
  if(!colName %in% colnames(data))
    stop("invalid outcome")
  
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  state <- unique(data$State)
  state <- state[order(state)]
  hospital <- sapply(state, rankhospital)
  data.frame(hospital, state)
  

}

getSortedState <- function(data, state, colName){
  stateRows <- getStateRows(data, state)
  #Convert the column we are interested in to a numeric
  stateRows[, colName] <- suppressWarnings(as.numeric(stateRows[, colName]))
  #Remove NAs
  stateRows <- stateRows[!is.na(stateRows[colName]),]
  sort(stateRows, colName)
}

getStateRows <- function(data, state) {
  ## Return rows for a particular state
  stateRows <- data[data$State == state,]
}

getColName <- function(outcome) {
  paste("Hospital.30.Day.Death..Mortality..Rates.from", formatOutcome(outcome), sep=".")
}

getPosition <- function(data, num){
  if(num == "best")
    1
  else if(num == "worst")
    nrow(data)
  else
    num
}

formatOutcome <- function(x) {
  s <- strsplit(x, " ")[[1]]
  upper <- paste(toupper(substring(s, 1, 1)), substring(s, 2), sep = "", collapse=".")
  
}

sort <- function(data, outcome){
  data[order(data[outcome], data$Hospital.Name), ]
}