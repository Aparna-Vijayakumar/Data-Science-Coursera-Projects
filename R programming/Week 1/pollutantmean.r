pollutantmean <- function(directory, pollutant, id= 1:332){            
  if(grep("specdata",directory) ==1){
    directory <- ("./specdata/")}
  avg <- c()
  files <- as.character(list.files(directory))
  paths <- paste(directory, files, sep="")
  for(i in id) 
  {
    this_file <- read.csv(paths[i], header=T, sep=",")
    #head(curr_file)
    #pollutant
    remove_na <- this_file[!is.na(this_file[, pollutant]), pollutant]
    avg <- c(avg, remove_na)
  }
  ans <- mean(avg)
  return(round(ans,3))
}
