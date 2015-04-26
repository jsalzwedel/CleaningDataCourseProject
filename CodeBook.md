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
 
