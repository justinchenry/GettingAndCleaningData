
## SET WORKING DIRECTORY
setwd("C:/Users/jhenry/Desktop/Coursera/Class - Getting and Cleaning Data")

## URL TO THE DATA FILE
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, dest="wearabledata.zip", mode="wb") 
unzip("wearabledata.zip")

## OPEN 
trainX <- read.table("UCI HAR Dataset/train/X_train.txt")
trainY <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")

testX <- read.table("UCI HAR Dataset/test/X_test.txt")
testY <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")

unionX <- rbind(trainX, testX)
unionY <- rbind(trainY, testY)
unionSubject <- rbind(trainSubject, testSubject)

features <- read.table("UCI HAR Dataset/features.txt")

# get only columns with mean() or std() in their names
mean_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the desired columns
unionX <- unionX[, mean_std_features]

# correct the column names
names(unionX) <- features[mean_std_features, 2]

activities <- read.table("UCI HAR Dataset/activity_labels.txt")

# update values with correct activity names
unionY[, 1] <- activities[unionY[, 1], 2]

# correct column name
names(unionY) <- "activity"

# correct column name
names(unionSubject) <- "subject"

# bind all the data in a single data set
unionAll <- cbind(unionX, unionY, unionSubject)

# Step 5
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
###############################################################################

# 66 <- 68 columns but last two (activity & subject)
require(plyr)
resultSet <- ddply(unionAll, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(resultSet, "averages_data.txt", row.name=FALSE)


