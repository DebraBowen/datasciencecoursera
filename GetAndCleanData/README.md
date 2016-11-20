# GetAndCleanData

## Getting and Cleaning Data Course Project

### Note: This document contains 2 main sections: 

1) R function description
2) README document for the original data set

### Section 1: Description of run_analysis.r

R function run_analysis.r performs the following tasks:

1) housekeeping and reads
	set working directory
	read X_test.txt into table test: test measurement data set
	read X_train.txt into table train: train measurement data set
	read y_test.txt into table testactivity: activity column for test
	read y_train.txt into table trainactivity: activity column for train
	read subject_test.txt into table testsubject: subject column for test
	read subject_train.txt into table trainsubject: subject column for train
	read measurements.csv into table measurements: column headings for data

2) work with column names, keeping data consistent at each step
	assign measurements col names: "colid", "accelname"
	assign testsubject col name: "subject"
	assign trainsubject col name: "subject"
	convert activity numbers to text: 
		"walk", "walkupstairs", "walkdownstairs", "sit", "stand", "lay"
	combine activity and subject with test, placing subject into 1st column
	combine activity and subject with train, placing subject into 1st column
	rename 1st and 2nd column in test to "subject" and "activity"
	rename 1st and 2nd column in train to "subject" and "activity"
	create vector "namesvector" with measurement column names
	recreate namesvector with "subject" as 1st column and "activity" as 2nd column
        
3) merge test and train data to dataframe testtrain

4) work with testtrain columns to get only those wanted in data set
	assign measurement column names to merged data
	create data frames with columns: std dev, Mean/mean, subject and activity
	change "subject" column to numeric
	change "activity" column to character
	create dataframe with activity, subject, mean and std dev columns
	
5) remove unwanted elements from column names
	change data column names to lower case
	remove from column names:
	()
	-
	(
	(
	,
 
6) extract tidy data set
	sort by activity, subject:
	create an independent tidy data set with the mean of each variable:
	rename 1st and 2nd columns to "subject" and "activity"
	return dataframe : accelmean


### Section 2: Original Data Set Readme doc
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

