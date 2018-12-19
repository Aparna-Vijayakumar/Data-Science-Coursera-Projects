library(dplyr)
# Download the zip file containing dataset
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("UCI HAR Dataset.zip")){
  download.file(url, destfile = "~/CleaningDataProject")
}

# Unzip the folder in the home directory
if(!file.exists("UCI HAR Dataset")){
  unzip("~/CleaningDataProject")
}

# Load the training data
trainvalue <- read.table("~/UCI HAR Dataset/train/X_train.txt")
trainlabel <- read.table("~/UCI HAR Dataset/train/y_train.txt")
trainsubjects <- read.table("~/UCI HAR Dataset/train/subject_train.txt")

# Load the test data
testvalue <- read.table("~/UCI HAR Dataset/test/X_test.txt")
testlabel <- read.table("~/UCI HAR Dataset/test/y_test.txt")
testsubjects <- read.table("~/UCI HAR Dataset/test/subject_test.txt")

# Load features without converting into factors
features <- read.table("~/UCI HAR Dataset/features.txt", as.is = T)

# Load activity labels
activities <- read.table("~/UCI HAR Dataset/activity_labels.txt")
colnames(activities) <- c("activityId", "activityLabel")

# Merge the training and test data
dataset <- rbind(cbind(trainsubjects, trainvalue, trainlabel), cbind(testsubjects, testvalue, testlabel))

# Give column names
colnames(dataset) <- c("Subject", features[ ,2], "ActivityLabel")

# Keep only mean and standard deviation for each measurement
keepcols <- grep("Subject|ActivityLabel|mean|std",colnames(dataset))
dataset <- dataset[ ,keepcols]

# To get descriptive activity labels, replace the activity labels with named factor levels
activitynames <- dataset$ActivityLabel
factor(activitynames, levels = activities[ ,1], labels = activities[ ,2])
dataset$ActivityLabel <- activitynames

# Remove special characters from columns and rename them descriptively
datasetcols <- colnames(dataset)
datasetcols <- gsub("[\\(\\)-]", "", datasetcols)
datasetcols <- gsub("^f", "frequencyDomain", datasetcols)
datasetcols <- gsub("^t", "timeDomain", datasetcols)
datasetcols <- gsub("Acc", "Accelerometer", datasetcols)
datasetcols <- gsub("Gyro", "Gyroscope", datasetcols)
datasetcols <- gsub("Mag", "Magnitude", datasetcols)
datasetcols <- gsub("Freq", "Frequency", datasetcols)
datasetcols <- gsub("mean", "Mean", datasetcols)
datasetcols <- gsub("std", "StandardDeviation", datasetcols)
colnames(dataset) <- datasetcols

# Compute average of each variable for each subject and activity
avg <- dataset %>% group_by(Subject, ActivityLabel) %>% summarise_all(funs(mean))

# Create tidy dataset
write.table(avg, "tidydata.txt", row.names = FALSE)




