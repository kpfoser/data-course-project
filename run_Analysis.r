## Data download and unzip 

# string variables for file download
fileName <- "UCIdataset.zip"
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir <- "UCI HAR Dataset"

# File download verification. If file does not exist, download to working directory.
if(!file.exists(fileName)){
        download.file(url,fileName, mode = "wb") 
}

# File unzip verification. If the directory does not exist, unzip the downloaded file.
if(!file.exists(dir)){
	unzip("UCIdataset.zip", files = NULL, exdir=".")
}


## Read Data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")  

## Analysis
# 1. Merge training and test sets to create one data set.
dataFeatures <- rbind(X_train,X_test)
dataSubject <- rbind(subject_train, subject_test)
dataActivity <- rbind(y_train, y_test)

# combine test and train of subject data and activity data, give descriptive labels
names(dataFeatures)<- features$V2
names(dataSubject) <- c("subject")
names(dataActivity) <- c("activity")

# combine subject, activity, and features data sets to create final data set.
CombinedDataSet <- cbind(dataSubject,dataActivity,dataFeatures)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
MeanStdData<-features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]

# 3. Uses descriptive activity names to name the activities in the data set
# group the activity column, re-name label of levels with activity Levels, and apply it to the data.
selectedNames<-c(as.character(MeanStdData), "subject", "activity" )
Data<-subset(CombinedDataSet,select=selectedNames)
act_group <- factor(Data$activity)
levels(act_group) <- activity_labels[,2]
Data$activity <- act_group


# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# check if reshape2 package is installed
if (!"plyr" %in% installed.packages()) {
	install.packages("plyr")
}
library("plyr")

# write the tidy data to the working directory as "tidy_data.txt"
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.csv(Data2, file = "tidydata.csv", row.names=FALSE)

