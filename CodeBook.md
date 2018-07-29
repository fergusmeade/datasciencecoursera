#Getting and Cleaning Data Project

##Purpose
To describe the data, the variables, and any transformations or work performed to clean up the data

##Source Data
Data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. The data can be accessed from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

#Data description
Experiments have been carried out with 30 volunteers aged 19-48. Wearing a Samsung Galaxy S smartphone on their waist, each volunteer performed six activities-WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING & LAYING. The smartphones accelerometer and gyroscope captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The dataset has been randomly split to training (70%) and test (30%) sets. 

Each record in the dataset contains

* 3-axial acceleration from the accelerometer and the estimated body acceleration
* 3-axial angular velocity from the gyroscope
* time and frequency domain variables
* activity label i.e. which of 6 activities was being performed
* subject identifier i.e. which of 30 volunteers was wearing the device

##Transformations
The following transformations were applied to the downloaded source data

* The activity class numbers (1-6) were replaced with text descriptions
* The variable names replaced with descriptive identifiers
* The training and test data sets were combined
* The combined data set was used to calculate the average for each variable for each SubjectNum-Activity combination
* This tidy data set was written to a file called "tidy_data.txt"

## R Script
The data collection and transformations described above were implemented with the run_Analysis.R script provided 

##R Packages required
Analysis was performed using R version 3.4.4 on an x86_64-pc-linux-gnu (64-bit) running under Ubuntu 18.04.1 LTS. 
In addition the following R packages were used

* data.table
* dplyr