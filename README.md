---
title: Tidy Data Course Project README
author: jsalzwedel
date: 2014-04-25
---

## Project Description

The raw dataset contains accelerometer measurements taken of thirty subjects using a Samsung Galaxy SII smartphone.  The data were taken while subjects were performing six activities: lying down, sitting, standing, walking, walking downhill, and walking uphill.  For each activity, an accelerometer measured the triaxial (x,y,z) linear acceleration of the subject, and a gyroscope measured the triaxial angular velocity of the subject.

The code run_analysis.R generates a tidy dataset called TidyActivityData.txt.  This refined dataset focuses on the mean and standard deviation values for each measurement.  The average value of each mean and standard deviation observation is found, broken down by subject and activity type. 

See CodeBook.md for descriptions of the initial and final datasets, as well as information about how the final tidy dataset was generated.


## Instructions for generating the the tidy data file:

1. Download the raw data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Unzip the data so that the "UCI HAR Dataset" is in your working directory.
3. Run the run_analysis.R script.
4. View the tidy dataset via
    library(data.table)
    tidyData <- fread("TidyActivityData.txt",header=TRUE)

 

