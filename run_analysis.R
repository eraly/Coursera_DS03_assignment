#
## Read in raw TRAINING data from relevant files.
#
train_raw_vecs = read.table("train/X_train.txt")
train_subject_id = readLines("train/subject_train.txt")
train_activity_id = readLines("train/y_train.txt")
# Column bind to assemble the "template" for the tidy data
train_df = cbind(train_subject_id,train_activity_id,train_raw_vecs)

#
## Repeat above for TEST data as well
#
test_raw_vecs = read.table("test/X_test.txt")
test_subject_id = readLines("test/subject_test.txt")
test_activity_id = readLines("test/y_test.txt")
# Column bind to assemble the "template" for the tidy data
test_df = cbind(test_subject_id,test_activity_id,test_raw_vecs)

#
## Name the columns with the feature names given in "features.txt"
#
feature_names = readLines("features.txt")
data_names = c("subject_id","activity_id",feature_names)
names(train_df) = data_names
names(test_df) = data_names

#
## 'Merge' test and train data together with a row bind
#
train_test_df = rbind(train_df,test_df)


#
## Use grep to extract features names with std() and mean() in them
## Had to add two to the column indices from the grep to account for i
## the first two columns in the data being subject & activity ids
#
relevant_cols = c(grep('std()',feature_names,fixed=TRUE),grep('mean()',feature_names,fixed=TRUE)) + 2
relevant_cols = c(1,2,relevant_cols)

#
## Keep only those columns
#
relevant_train_test_df = train_test_df[,relevant_cols]

#
## Fix those column names. Replace all that junk before the "t" and "f" (for time or frequency)
#
names(relevant_train_test_df) = gsub("^.*? ","",names(relevant_train_test_df))

#
## Use the activity label file names to convert the column in the dataframe to factors with
## appropriate labels
#
activity_labels = readLines("activity_labels.txt")
activity_labels = sapply(activity_labels,function (a) strsplit(a, " ")[[1]][2])
relevant_train_test_df$activity_id=factor(relevant_train_test_df$activity_id,labels=activity_labels)

#
## plyr is powerful and a good fit for cases like this
#
library(dplyr)
mean_tidy_data = group_by(relevant_train_test_df,subject_id,activity_id) %>% summarise_each(funs(mean))

#
## Give the 'mean' columns from above meaningful names
#
names(mean_tidy_data)[-1:-2] = paste("mean_",names(mean_tidy_data)[-1:-2],sep="") 

# ALL DONE ###########################################################################################
#    This is how I got dataframe to print in a way that was readable.
##     How to format columns to justified regardless of the width of column names. 
##      Bigger pain than I thought it would be.
####    From: http://stackoverflow.com/questions/12985091/print-data-frame-with-columns-center-aligned-in-r
####### names_width = max(sapply(names(mean_tidy_data), nchar))
####### names(mean_tidy_data) = format(names(mean_tidy_data), width = names_width, justify = "centre")
####### format(mean_tidy_data, width = names_width, justify = "centre")


