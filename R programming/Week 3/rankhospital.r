rankhospital <- function(state, outcome, num = "best") {
  
  ## Read the outcome data
  dat <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  ## Check that state and outcome are valid
  if (!state %in% unique(dat[, 7])) {
    stop("invalid state")
  }
  switch(outcome, `heart attack` = {
    col = 11
  }, `heart failure` = {
    col = 17
  }, pneumonia = {
    col = 23
  }, stop("invalid outcome"))
  dat[, col] = as.numeric(dat[, col])
  df = dat[dat[, 7] == state, c(2, col)]
  df = na.omit(df)
  nhospital = nrow(df)
  switch(num, best = {
    num = 1
  }, worst = {
    num = nhospital
  })
  if (num > nhospital) {
    return(NA)
  }
  ## Return hospital name in that state with the given rank 30-day death rate
  
  o = order(df[, 2], df[, 1])
  df[o, ][num, 1]
}