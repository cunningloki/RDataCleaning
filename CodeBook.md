The run_analysis.R script is single script that performs the data preparation for UCI HAR dataset. Processing of data for desired output is carried out using following steps. This script assume that data is downloaded manually and available under UCI HAR folder under working directory. Following steps are shown in summary.


Read data common to both test and training.

Read all test data and combine them

Read all training data and combine them

Combine all test and training data 

Filter based on column for mean and standard deviation

Replace activity id with activity names.

Label the  column names with appropriate names.

Aggerate the data showing mean of data based on subject and activity.

Write the aggerate data to file.


1. Read data common to both test and training.

      read activity labels in data frame  from “activity_labels.txt” file  & store two columns as “activity_id” and “activity_name” this file has  6 rows. These are activity against with data measurement is done.

      read feature names, the parameters which are measured using devise for different subjects for different activity, this file has 561 rows and two column, these records are stored in “df_features” dataframe with column names “feature_id” & “feature_name” 


2.	Read all test data and combine them

   read test subject data into “df_test_subject_id” datafarame from file “subject_test.txt" this data denotes all subject who are under test category and denotes    subject identity of observations taken for each subjects, activity wise. This data is stored under “subject_id” column.

   read test feature data from X_test.txt file into df_test_feature_data datafarame under column name taken from df_features dataframe rows under “feature_name”    column. There are 561 columns X_test.txt and 2947 observations. 

   read test activity data from y_test.txt file into df_test_activity dataframe, this data shows the activity id for each 2947 observations.  This data is stored under    “activity_id” column.

   combine test data by combining df_test_subject_id, df_test_activity, df_test_feature_dataframe, in df_test_combine with 563 columns and 2947 rows. This data shows    2947 observations for subject + activity combination. This combination was made using bind_col function.



3.	Read all training data and combine them

     read train subject data into “df_train_subject_id” datafarame from file “subject_train.txt" this data denotes all subject who are under train category and          denotes subject identity of observations taken for each subjects, activity wise. This data is stored under “subject_id” column.


    read train feature data from X_train.txt file into df_train_feature_data datafarame under column name taken from df_features dataframe rows under “feature_name”        column. There are 561 columns X_train.txt and 7352 observations. 


    read training activity data from y_train.txt file into df_train_activity dataframe, this data shows the activity id for each 7352 observations.  This data is     stored under “activity_id” column.


    combine training data by combining df_train_subject_id, df_train_activity, df_train_feature_dataframe, in df_train_combine with 563 columns and 7352 rows. This     data shows 7352  observations for subject + activity combination. This combination was made using bind_col function.



4.	Combine all test and training data
 
     combine both training and test data by combining df_train_combined, df_test_combined dataframe row wise. This combined dataframe now consist of 10299 rows and          88 columns, This data shows 10299 observations for test and train data for 30 subject for different activities. Observations were stored in 561 different         categories.



5.	Filter based on column for mean and standard deviation


      select data for only those columns which contains “mean” and “std” text in their column names.  This data is stored in “df_full_filtered” dataframe. This data          contains 10299 rows, 88 columns with subject_id, activity_id, and 86 columns with features containing “std” and “mean” text in their name.
 
 
6.	Replace activity id with activity names.

     Replace activity_id row values  in df_full_filtered dataframe with activity_name rows from df_activity_labels dataframe. This provides activity detail names in      place of activity id.  
 

7.	Label the  column names with appropriate names
 
       activity_id  in df_full_filtered -> activity_name

       Acc .> Accelerometer

       Gyro-> Gyroscope

       ABodyBody -> Body

       Mag -> Magnitude

       start with character f -> Frequency

       start with character t -> Time


8.	Aggerate the data showing mean of data based on subject and activity.

        FinalData, 180 rows, 88 columns is created by aggerating data as means for each subject and activity combination 6 activity for each 30 subject, 180 rows 


9.	Write the aggerate data to file

        write FinalData into FinalData.txt file.

