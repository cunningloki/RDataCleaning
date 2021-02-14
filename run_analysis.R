## read activity labels
df_activity_labels <- read.delim("UCI HAR Dataset/activity_labels.txt", sep=" ", header = FALSE)

## rename activity data frame with activity_id & activity_name
colnames(df_activity_labels) <- c("activity_id", "activity_name")



## read feature names
df_features <- read.delim("UCI HAR Dataset/features.txt", sep=" ", header = FALSE)

## rename column name feature_id and feature_name to feature df
colnames(df_features) <- c("feature_id", "feature_name")






###***************************
## read all test data
###**************************

## read test subject ID data
df_test_subject_id <- read.delim("UCI HAR Dataset/test/subject_test.txt", sep=" ", header = FALSE)
colnames(df_test_subject_id) <- c("subject_id")



## read test feature data

df_test_feature_data <-df_test_feature_data <- read.fwf("UCI HAR Dataset/test/X_test.txt", widths=rep(c(16), times = 561))
colnames(df_test_feature_data) <- df_features[,2]


## read test activity data
df_test_activity <- read.delim("UCI HAR Dataset/test/y_test.txt", sep=" ", header = FALSE)
colnames(df_test_activity) <- c("activity_id")


###************************
##combine test data
###*************************

df_test_combined <-bind_cols(df_test_subject_id,df_test_activity,df_test_feature_data) 


##*****************************
## read all training data
##*****************************
## read training subject ID data

df_train_subject_id <- read.delim("UCI HAR Dataset/train/subject_train.txt", sep=" ", header = FALSE)
colnames(df_train_subject_id) <- c("subject_id")



## read training feature data
df_train_feature_data <-read.fwf("UCI HAR Dataset/train/X_train.txt", widths=rep(c(16), times = 561))
colnames(df_train_feature_data) <- df_features[,2]

## read training activity data
df_train_activity <- read.delim("UCI HAR Dataset/train/y_train.txt", sep=" ", header = FALSE)
colnames(df_train_activity) <- c("activity_id")



###************************
##combine training data
###*************************
## combine training subject ID + feature data + activity data
df_train_combined <-bind_cols(df_train_subject_id,df_train_activity,df_train_feature_data) 


## combine both training and test df.

df_full_combined <- bind_rows(df_train_combined,df_test_combined)

## select only standart deviation and mean columns.

df_full_filtered <- df_full_filtered <- select(df_full_combined, subject_id, activity_id,contains("mean"),contains("std"))

## replace activity_id with names of activities


df_full_filtered$activity_id <- df_activity_labels[df_full_filtered$activity_id,2]


## tidy column  names 

names(df_full_filtered)[2] = "activity_name"
names(df_full_filtered) <-gsub("Acc", "Accelerometer", names(df_full_filtered))
names(df_full_filtered) <-gsub("Gyro", "Gyroscope", names(df_full_filtered))
names(df_full_filtered) <-gsub("BodyBody", "Body", names(df_full_filtered))
names(df_full_filtered) <-gsub("Mag", "Magnitude", names(df_full_filtered))
names(df_full_filtered) <-gsub("^t", "Time", names(df_full_filtered))
names(df_full_filtered) <-gsub("^f", "Frequency", names(df_full_filtered))
names(df_full_filtered) <-gsub("tBody", "TimeBody", names(df_full_filtered))
names(df_full_filtered) <-gsub("-mean()", "Mean", names(df_full_filtered), ignore.case = TRUE)
names(df_full_filtered) <-gsub("-std()", "STD", names(df_full_filtered), ignore.case = TRUE)
names(df_full_filtered) <-gsub("-freq()", "Frequency", names(df_full_filtered), ignore.case = TRUE)
names(df_full_filtered) <-gsub("angle", "Angle", names(df_full_filtered))
names(df_full_filtered) <-gsub("gravity", "Gravity", names(df_full_filtered))



##summarize the data for each subject activity wise by averaging the data for them

FinalData <- df_full_filtered %>% 
  group_by(subject_id, activity_name) %>% 
  summarise_all(funs(mean))
## write to file.

write.table(FinalData, "FinalData.txt", row.name=FALSE) 
