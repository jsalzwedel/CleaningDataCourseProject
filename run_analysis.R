# You should create one R script called run_analysis.R that does the following. 

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each 
#    measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.



################################################################################
# Read in all the data, variable names, IDs, etc.
#


# First let's load in each data set quickly using the data.table package
library(data.table)

# Main dataset. Crashes when using fread, so read in with read.table then
# convert to data frame
trainData <- read.table("UCI HAR Dataset//train//X_train.txt")
trainData <- data.table(trainData)
# Activity numbers (1-6).  Will eventually update these to be human readable
trainActivityID <- fread("UCI HAR Dataset//train//y_train.txt")
# Test subject IDs
trainSubject <- fread("UCI HAR Dataset//train/subject_train.txt")

# Let's also load the test data sets
testData <- read.table("UCI HAR Dataset//test/X_test.txt")
testData <- data.table(testData)
testActivityID <- fread("UCI HAR Dataset//test/y_test.txt")
testSubject <- fread("UCI HAR Dataset//test/subject_test.txt")

# Activity names associated with the activity IDs
activityNames <- fread("UCI HAR Dataset//activity_labels.txt")

#
#
################################################################################
# Make all the column names human readable
#

colNames <- fread("UCI HAR Dataset//features.txt")
setnames(trainData,1:561,colNames$V2)
setnames(testData,1:561,colNames$V2)
setnames(trainActivityID,1,"ActivityID")
setnames(testActivityID,1,"ActivityID")
setnames(activityNames,1:2,c("ActivityID","ActivityName"))
setnames(trainSubject,1,"SubjectID")
setnames(testSubject,1,"SubjectID")

#
#
################################################################################
# Subset and merge the train and test data sets to get one complete data set of 
# all the mean and standard deviation measurements
#

# Subset out just the columns related to mean and std deviation
requiredColumns <- grep("mean|std",colNames$V2)
trainSubset <- trainData[,requiredColumns,with=FALSE]
testSubset <- testData[,requiredColumns,with=FALSE]

# Now merge the subject and activity ID into the data tables
trainMerged <- cbind(trainSubset,trainActivityID,trainSubject)
testMerged <- cbind(testSubset,testActivityID,testSubject)


# We are ready to merge the train and test sets together!
dataMerged <- rbind(trainMerged,testMerged)

# Let's add one more column, the name of each activity
dataComplete <- merge(dataMerged,activityNames,by="ActivityID")

#
#
################################################################################
# Finally, lets make a separate data set containing the average of each variable 
# for each activity and each subject
#

# We'll use the plyr package to split the data up by SubjectID and Activity,
# then take the mean of each column.
library(plyr)
averages <- ddply(dataComplete,.(SubjectID,ActivityName), numcolwise(mean))
tidyData <- data.table(averages)

# Write the data set to a file
write.table(tidyData, file="TidyActivityData.txt", row.names=FALSE)

#
#
################################################################################


