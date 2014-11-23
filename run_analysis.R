run <- function(){ 
  setwd("D:/DataScience/Coursera/1 - Data Science - Specialization/MyCode/Getting_and_Cleaning_Data_Course_Project")
  
  ##### 1 - Merges the training and the test sets to create one data set.
  #Reading the data which is related to 'train'
  #then adding one more variable 'column' called group to the data and it will have 'train'
  train_data <- read.table("./UCI HAR Dataset/train/X_train.txt")
  train_data <- data.frame(train_data, group = "train")
  
  #Reading the data which is related to 'test'
  #then adding one more variable 'column' called group to the data and it will have 'test'
  test_data <- read.table("./UCI HAR Dataset/test/X_test.txt")
  test_data <- data.frame(test_data, group = "test")
  
  #Merging the 2 data frames 'train' & test in one data frame
  #This new data frame has total number of rows = 7352+ 2947 = 10299 observations
  #This new data frame has total number of columns = 561 + 1 'group' = 265 variables
  all_data <- rbind(train_data, test_data)
  #################END OF STEP # 1 #############################
  
  
  ##### 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
  #Reading the features 'variable names'
  #To extract measurements for mean I am filtering using a pattern 'mean()'
  #To extract measurements for standard deviation I am filtering using a pattern 'std()'
  features <- read.table("./UCI HAR Dataset/features.txt")
  feature_mean <- grep("[m][e][a][n][(][)]", features$V2, value = TRUE)
  feature_std <- grep("[s][t][d][(][)]", features$V2, value = TRUE)
  feature_mean_std <- c(feature_mean, feature_std)
  
  #Get mean & std columns
  mean_std_features <- features[features$V2 %in% as.factor(feature_mean_std),]
  
  #Generating a vector with IDs for the columns
  #I am adding ncol(all_data) to add the last column which has the group type either 'train' or 'test'
  column_ids <- c(mean_std_features$V1,ncol(all_data))
  mean_std_data <- all_data[,column_ids]
  #################END OF STEP # 2 #############################
  
  
  ##### 3 - Uses descriptive activity names to name the activities in the data set.
  #Reading activity for both 'train' & 'test' group
  train_activity <- read.table("./UCI HAR Dataset/train/y_train.txt")
  test_activity <- read.table("./UCI HAR Dataset/test/y_test.txt")
  all_activity <- rbind(train_activity, test_activity)
  colnames(all_activity) <- c("activity_id")
  
  #Reading subject for both 'train' & 'test' group
  train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
  test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
  all_subject <- rbind(train_subject, test_subject)
  colnames(all_subject) <- c("subject_id")
  
  mean_std_data <- data.frame(mean_std_data, activity = all_activity, subject = all_subject)
  
  #Loading activity and merging to the data set
  activity_name <- read.table("./UCI HAR Dataset/activity_labels.txt")
  colnames(activity_name) <- c("activity_id","activity_name")
  mean_std_data_actv <- merge(mean_std_data, activity_name, by.x = "activity_id", by.y = "activity_id", all = FALSE)
  #################END OF STEP # 3 #############################
    
  
  ##### 4 - Appropriately labels the data set with descriptive variable names.
  x1 <- data.frame(V1=0, V2="activity_id")
  x2 <- data.frame(V1=0, V2="group")
  x3 <- data.frame(V1=0, V2="subject")
  x4 <- data.frame(V1=0, V2="activity_name")
  mean_std_features <- rbind(x1, mean_std_features)
  mean_std_features <- rbind(mean_std_features, x2)
  mean_std_features <- rbind(mean_std_features, x3)
  mean_std_features <- rbind(mean_std_features, x4)
  colnames(mean_std_data_actv) <- mean_std_features$V2
  #################END OF STEP # 4 #############################
  
  
  ##### 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  result <- aggregate(x = mean_std_data_actv, 
                   by = list(ACTIVITY_ID = mean_std_data_actv$activity_id, 
                             GROUP = mean_std_data_actv$group, 
                             SUBJECT = mean_std_data_actv$subject, 
                             ACTIVITY_NAME = mean_std_data_actv$activity_name), 
                   FUN = "mean")
  result <- result[,c(1:4,6:71)]
  write.table(x = result, file = "./UCI HAR Dataset/output.txt", row.name=FALSE)
  #################END OF STEP # 5 #############################
  
}