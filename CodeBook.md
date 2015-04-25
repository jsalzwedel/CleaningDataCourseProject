---
title: Tidy Data Course Project Codebook
author: jsalzwedel
date: 2014-04-25
Codebook template provided at: 
	 https://gist.github.com/JorisSchut/dbc1fc0402f28cad9b41
---
 
###Collection of the raw data
The raw dataset contains accelerometer measurements taken of thirty subjects using a Samsung Galaxy SII smartphone.  The data were taken while subjects were performing six activities: lying down, sitting, standing, walking, walking downhill, and walking uphill.  For each activity, an accelerometer measured the triaxial (x,y,z) linear acceleration of the subject, and a gyroscope measured the triaxial angular velocity of the subject.  The accelaration was further decomposed into body motion and gravitational motion components.  For both the accelaration and angular velocity,  many types of measurements are recorded, including mean value, standard deviation, kurtosis, etc.  For each subject, an activity has multiple measurements.

 
###Notes on the original (raw) data 

The raw data can be obtained at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 
##Creating the tidy datafile
 
###Guide to create the tidy data file
See README.md for instructions to generate the tidy data file
 
###Cleaning of the data
1.  Read in the data
The data are split into two sets, a training set and a test set.  We eventually want to combine these, but first each one needs to be cleaned up individually.  For the test set. we read in the raw measurement data (X_train.txt), their respective activity IDs (y_train.txt), and the respective subject data (subject_train.txt). Likewise for the test data. 
We also read in the activity names associated with each activity ID (acactivity_labels.txt). Finally, we read in the descriptive names (features.txt) of each of the measurements (i.e. the X_train/X_test column names).

2.  Update variable names
We use features.txt to apply descriptive variable names to each of the 561 different types (columns) of measurement data contained in both the train and test sets.  We also apply names to the Activity ID, Activity Name, and Subject ID sets to make subsequent merging of data cleaner.

3.  Subset the required mean and std data
For the tidy data set, we only care about the assorted "mean" and "std" variables.  We can find the relevant variables by searching through the table of descriptive names for entries containing "mean" and "std". We see that for each spatial component of each type of accelerometer and gyroscope measurement, there are "mean", "std", and "meanFreq" entries.  We'll extract all of these.  For both the train and test datasets, we subset just the columns referring to the "mean", "std", and "meanFreq".

4. Combine Subject ID and Activity ID into the datasets
The rows of the dataset correspond to the rows of the Subject ID and Activity ID data.  We column bind the subject and activity IDs to the data sets for both the test and train data.

5. Combine the test and train data
Now that we have all the subject IDs and activity IDs merged into the data set, it is simple to combine the train and test data via row binding.

6. Add a column showing the name of each activity
The activity_labels.txt file contains activity names that are associated with each of the 1-6 activity IDs.  We now merge an ActivityName column into the dataset using the relevant activity IDs.

7. Generate a tidy data set containing average measurements
For each subject, activity, and observation type (e.g. "fBodyAcc-mean"), there are a number of measurements.  For each subject and activity, we find the average value of each observation type.  We use the plyr::ddply to to split the data up by subject and activity name, take the average of each column, and return the calculated values in a new, tidy data set.

8. Write the tidy data to a file
We write out the tidy data in a table to the "TidyActivityData.txt" file.


 
##Description of the variables in the TidyActivityData.txt file
The tidy data set contains 180 observations (30 subjects x 6 activities) of 82 variables.  The variables include:

Classification info:
SubjectID
ActivityID
ActivityName

Observations: 
(All observations detail the average quanity for a given subject-activity pair)
	Type:
		Accelerometer measurements ("Acc" label), in units of standard gravity "g".  These are split into "Body" motion acceleration and "Gravity" acceleration.
		Gyroscopic measurements ("Gyro" label) of angular velocity, in units of radians/second.
		Time derivative of accelerometer or Gyroscopic measurements ("Jerk" label).
	Component:
		Observations are listed as either as an X-, Y-, or Z- component of acceleration/angular velocity, or as the magnitude (sqrt(x^2 + y^2 + z^2))
	Mode:
		Each obsevation is either the "mean" value of the measurement, the standard deviation "std" of the measurement, or the mean frequency "meanFreq" of the measurement.
	Domain:
		The "t" or "f" prefix denotes whether the measurement reflects a signal seen in the time domain or in the frequency domain.
 
