# Interpreting results from the run_analysis script
The run_analysis.R creates a tidy summary of select features from the UC-Irvine Human Activity Recognition database. This document provides the relevant information needed to interpret the results from the analysis here correctly.  

Details form the study and the original codebook from this study is available [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
The data from this study is available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )

The analysis here comprises of extracting the mean and std deviation as calculated by the study for all available cases of an activity for a given participant. The mean and std deviation instances are then grouped by participant performing a specific activity. So each row here represents data for all possible combinations of **(particant,activity)**

### Further details
This script extracts the mean() and std() deviations from the 561 feature vector available from the analysis in the original study. These vectors and their descriptions in the original codebook. This dataset appends mean_ to indicate that these are averaged across participants+activity.
The variable name follows this convention - 
If the name in the original study is tBodyAcc-mean()-X in this study **mean_**tBodyAcc-mean()-X describes the average for a given particant performing one of the activities. Or mean_fBodyGyro-std()-X gives the mean of the "mean_fBodyAcc-std()-Z" which is the standard dev of the freq component of the body acceleration in the Z axis. Not the explanation for everything that follows mean_ is from the original codebook.
The analysis here does is a simple linear transformation (aka mean) of the original data and therefore retains the units of the original time/frequency components of feature vectors.
