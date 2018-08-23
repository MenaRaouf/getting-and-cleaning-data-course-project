library(dplyr)
library(tidyr)


##read test data from files
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test_value <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_activity <- read.table("./UCI HAR Dataset/test/y_test.txt")

##read train data from files
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train_value <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_activity <- read.table("./UCI HAR Dataset/train/y_train.txt")

##read lables for activity and features
activity_lables <- read.table("./UCI HAR Dataset/activity_labels.txt" , as.is = TRUE)
features_lables <- read.table("./UCI HAR Dataset/features.txt", as.is = TRUE)
names(activity_lables) <- c("activity_id" , "activity_name")


## 1 - mearging test data and train data

test_data <- cbind(test_subject , test_value , test_activity)
train_data <- cbind(train_subject , train_value , train_activity)

data <- rbind(test_data , train_data)

##clear workspace
rm(test_subject,
   test_value,
   test_activity,
   train_subject,
   train_value,
   train_activity,
   test_data,
   train_data)

names(data) <- c("subject" , features_lables[,2] , "activity_id")

## 2- keep colums which contain mean and standard deviation

keep_col_names <- grepl("subject|activity_id|mean|std" , colnames(data))

data <- data[,keep_col_names]

## 3- Uses descriptive activity names to name the activities in the data set

data <- merge(data , activity_lables , by = "activity_id" )

##4-Appropriately labels the data set with descriptive variable names

data_col_names <- colnames(data)

data_col_names <- gsub("^t" , "timeDomain" , data_col_names)
data_col_names <- gsub("^f" , "frequencyDomain" , data_col_names)
data_col_names <- gsub("mean" , "Mean" , data_col_names)
data_col_names <- gsub("freq" , "Freaquency" , data_col_names)
data_col_names <- gsub("std" , "StandardDeviation" , data_col_names)
data_col_names <- gsub("Acc" , "accelerometer" , data_col_names)
data_col_names <- gsub("Gyro" , "gyroscope" , data_col_names)

colnames(data) <- data_col_names

## 5- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

data_mean <- data %>%
        group_by(activity_id , activity_name  , subject) %>% 
        summarize_all(mean)

## 6- Save tidy data to file

write.table(data_mean,file = "tidydata.txt" , row.names = FALSE) 