---
title: Tidy Data Course Project README
author: jsalzwedel
date: 2014-04-25
---

##Project Description

The raw dataset contains accelerometer measurements taken of thirty subjects using a Samsung Galaxy SII smartphone.  The data were taken while subjects were performing six activities: lying down, sitting, standing, walking, walking downhill, and walking uphill.  For each activity, an accelerometer measured the triaxial (x,y,z) linear acceleration of the subject, and a gyroscope measured the triaxial angular velocity of the subject.

The code run_analysis.R generates a tidy dataset called TidyActivityData.txt.  This refined dataset focuses on the mean and standard deviation values for each measurement.  The average value of each mean and standard deviation observation is found, broken down by subject and activity type. 

See CodeBook.md for descriptions of the initial and final datasets, as well as information about how the final tidy dataset was generated.


##Instructions for generating the the tidy data file:

1. Download the raw data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Unzip the data so that the "UCI HAR Dataset" is in your working directory.
3. Run the run_analysis.R script.
4. View the tidy dataset via
    library(data.table)
    tidyData <- fread("TidyActivityData.txt",header=TRUE)


##Cleaning of the data
1.  Read in the data:
The data are split into two sets, a training set and a test set.  We eventually want to combine these, but first each one needs to be cleaned up individually.  For the test set. we read in the raw measurement data (X_train.txt), their respective activity IDs (y_train.txt), and the respective subject data (subject_train.txt). Likewise for the test data. 
We also read in the activity names associated with each activity ID (acactivity_labels.txt). Finally, we read in the descriptive names (features.txt) of each of the measurements (i.e. the X_train/X_test column names).

2.  Update variable names:
We use features.txt to apply descriptive variable names to each of the 561 different types (columns) of measurement data contained in both the train and test sets.  We also apply names to the Activity ID, Activity Name, and Subject ID sets to make subsequent merging of data cleaner.

3.  Subset the required mean and std data:
For the tidy data set, we only care about the assorted "mean" and "std" variables.  We can find the relevant variables by searching through the table of descriptive names for entries containing "mean" and "std". We see that for each spatial component of each type of accelerometer and gyroscope measurement, there are "mean", "std", and "meanFreq" entries.  We'll extract all of these.  For both the train and test datasets, we subset just the columns referring to the "mean", "std", and "meanFreq".

4. Combine Subject ID and Activity ID into the datasets:
The rows of the dataset correspond to the rows of the Subject ID and Activity ID data.  We column bind the subject and activity IDs to the data sets for both the test and train data.

5. Combine the test and train data:
Now that we have all the subject IDs and activity IDs merged into the data set, it is simple to combine the train and test data via row binding.

6. Add a column showing the name of each activity:
The activity_labels.txt file contains activity names that are associated with each of the 1-6 activity IDs.  We now merge an ActivityName column into the dataset using the relevant activity IDs.

7. Generate a tidy data set containing average measurements:
For each subject, activity, and observation type (e.g. "fBodyAcc-mean"), there are a number of measurements.  For each subject and activity, we find the average value of each observation type.  We use the plyr::ddply to to split the data up by subject and activity name, take the average of each column, and return the calculated values in a new, tidy data set.

8. Write the tidy data to a file:
We write out the tidy data in a table to the "TidyActivityData.txt" file.

 

