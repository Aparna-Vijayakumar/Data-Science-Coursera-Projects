complete <- function(directory, id = 1:332){
  if(grep("specdata", directory) == 1){
    directory <- ("./specdata/")
  }
  all <- rep(0, length(id))
  files <- as.character(list.files(directory))
  paths <- paste(directory, files, sep="")
  count <- 1
  for(i in id){
    this_file <- read.csv(paths[i], header = T, sep = ",")
    all[count] <- sum(complete.cases(this_file))
    count <- count + 1
  }
  ans <- data.frame(id = id, nobs = all)
  return(ans)
}


  
  
  

