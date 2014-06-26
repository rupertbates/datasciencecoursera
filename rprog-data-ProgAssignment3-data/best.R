best <- function(state, outcome) {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  outcome <- getColName(outcome)
  state <- getStateRows(state)
  state[, outcome] <- as.numeric(state[, outcome])
  sorted <- sort(state, outcome)
  sorted
}

getSortedState <- function(state, outcome){
  colName <- getColName(outcome)
  stateRows <- getStateRows(state)
  stateRows[, colName] <- as.numeric(stateRows[, colName])
  sort(stateRows, colName)
}

getStateRows <- function(state) {
  ## Return rows for a particular state
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
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