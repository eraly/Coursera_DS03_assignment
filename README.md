# README
run_analysis.R creates a tidy summary of select features from the UC-Irvine Human Activity Recognition database. The Codebook provides relevant information from the original study and documents how to interpret the results from the analysis done here. This document provides an overview of how the run_analysis script works.  

Exploratory analysis on this dataset favored a straightforward strategy using the powerful plyr package outlined as follows (Specific details from R after the "->"). 
The result is 'tidy data' in the long format.

### Detailing the run_analysis.script
* Since the training data spans across multiple files first 'string' together corresponding parts to a row -> 
 + Column bind the subject (subject_.*txt) file, the activity (y_.*txt) file and the time/frequency vector file (X_*txt)
* Repeat above on test data
* Name the columns ->
 + "subject_id","activity_id" and the values from features.txt file for the time/frequency vector names
* Combine train and test data ->
 + Rowbind train and test dataframes to give the merged training+test data set
* Select only relevant columns ->
 + Pattern match for std() and mean() in the column names to get the indices to choose 
* Make column names more readable ->
 + Drop the part of the name before the " t" or the " f".  
* Give the activity_id meaning ->
 +  Use the second field in the activity_labels.txt to generate labels for activity_id as a factor
* Organize into tidy data in long format ->
 + Use plyr to group first by subject and then by activity 
* Then summarise
* Name the columns in the summary ->
 + Add mean_ to the column names of the data frame summarised 

