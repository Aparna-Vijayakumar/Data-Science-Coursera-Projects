corr <- function(directory, threshold = 0){
  if(grep("specdata", directory) == 1){
    directory = ("./specdata/")
  }
  all <- complete("specdata", 1:332)
  nobs <- all$nobs
  new_id <- all$id[nobs > threshold]
  correlation <- rep(0, length(new_id))
  files <- as.character( list.files(directory) )
  paths <- paste(directory, files, sep="")
  count <- 1
  for(i in new_id) {
    this_file <- read.csv(paths[i], header=T, sep=",")
    correlation[count] <- cor(this_file$sulfate, this_file$nitrate, use="complete.obs")
    count <- count + 1
    }
  ans <- correlation
  return(ans)  
}
