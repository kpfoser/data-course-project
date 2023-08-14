Code Book
#Data download and unzip

This script will check if the data file is present in your working directory. (If not, will download and unzip the file)

#Read data

subject_test : subject IDs for test
subject_train : subject IDs for train
X_test : values of variables in test
X_train : values of variables in train
y_test : activity ID in test
y_train : activity ID in train
activity_labels : Description of activity IDs in y_test and y_train
features : description(label) of each variables in X_test and X_train

dataFeatures : bind of X_train and X_test
dataSubject : bind of subject_train and subject_test
dataActivity : bind of y_train and y_test
CombinedDataSet bind of dataFeatures,dataSubject,dataActivity

#Extract only mean() and std()

MeanStdOnly : a vector of only mean and std labels extracted from 2nd column of features
Create a vector of only mean and std labels, then use the vector to subset CombinedDataSet.

#Combine test data and train data of subject and activity, then give descriptive labels. Finally, 
#Bind with Data. At the end of this step, Data has 2 additonal columns 'subject' and 'activity' in the left side.

subject : bind of subject_train and subject_test
activity : bind of y_train and y_test

#Rename ID to activity name

Group the activity column of dataSet as "act_group", then rename each levels with 2nd column of activity_levels. Finally apply the renamed "act_group" to Data's activity column.
act_group : factored activity column of Data

#Output tidy data as tidydata.csv

Data is aggregated to create tidy data. It will also add [mean of] to each column labels for better description. Finally output the data as "tidydata.csv"

Data2 : aggregrate of Data with subject and activity
