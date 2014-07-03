best <- function(state, outcome) {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  ## Check that state and outcome are valid
  if(! state %in% data$State)
    stop("invalid state")
  
  colName <- getColName(outcome)
  if(!colName %in% colnames(data))
    stop("invalid outcome")
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  sorted <- getSortedState(data, state, colName)
  sorted$Hospital.Name[1]
}

getSortedState <- function(data, state, colName){
  stateRows <- getStateRows(data, state)
  stateRows[, colName] <- suppressWarnings(as.numeric(stateRows[, colName]))
  sort(stateRows, colName)
}

getStateRows <- function(data, state) {
  ## Return rows for a particular state
  data[data$State == state,]
}

getColName <- function(outcome) {
  paste("Hospital.30.Day.Death..Mortality..Rates.from", formatOutcome(outcome), sep=".")
}

formatOutcome <- function(x) {
  s <- strsplit(x, " ")[[1]]
  upper <- paste(toupper(substring(s, 1, 1)), substring(s, 2), sep = "", collapse=".")
  
}

sort <- function(data, outcome){
  data[order(data[outcome], data$Hospital.Name), ]
}