#download and unzip data
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(path, "data.zip"))
unzip(zipfile = "data.zip")

# Load activity labels & features
activityLabels <- read.table(file.path(path, "UCI HAR Dataset/activity_labels.txt"),
                             col.names = c("classLabels", "activityName"))
features <- read.table(file.path(path, "UCI HAR Dataset/features.txt"),
                              col.names = c("index", "featureNames"))
Reqd_features <- grep("(mean|std)\\(\\)", features$featureNames)
measurements <- features[which(features$index %in% Reqd_features), 2]
measurements <- gsub('[()]', '', measurements) #remove()

# Load train datasets
train <- data.table::fread(file.path(path, 
                                     "UCI HAR Dataset/train/X_train.txt"))[, Reqd_features, with = FALSE]
data.table::setnames(train, colnames(train), measurements)
trainActivities <- data.table::fread(file.path(path,
                                               "UCI HAR Dataset/train/y_train.txt"),
                                                col.names = c("Activity"))
trainSubjects <- data.table::fread(file.path(path,
                                             "UCI HAR Dataset/train/subject_train.txt"),
                                              col.names = c("SubjectNum"))
train <- cbind(trainSubjects, trainActivities, train)

# Load test datasets
test <- data.table::fread(file.path(path, 
                                    "UCI HAR Dataset/test/X_test.txt"))[, Reqd_features, with = FALSE]
data.table::setnames(test, colnames(test), measurements)
testActivities <- data.table::fread(file.path(path,
                                              "UCI HAR Dataset/test/y_test.txt"),
                                              col.names = c("Activity"))
testSubjects <- data.table::fread(file.path(path,
                                            "UCI HAR Dataset/test/subject_test.txt"),
                                            col.names = c("SubjectNum"))
test <- cbind(testSubjects, testActivities, test)

# merge datasets
combined <- rbind(train, test)
combined[["Activity"]] <- factor(combined[, Activity]
                                 , levels = activityLabels[["classLabels"]]
                                 , labels = activityLabels[["activityName"]])
combined[["SubjectNum"]] <- as.factor(combined[, SubjectNum])

library(dplyr)
combined_means <- combined %>% 
  group_by(SubjectNum, Activity) %>% #group combined data set by subject and activity
  summarise_all(mean) #return mean for each subject/activity combination

write.table(combined_means, "tidy_data.txt", row.names = FALSE, quote = FALSE)
