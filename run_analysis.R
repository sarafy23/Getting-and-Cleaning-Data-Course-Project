features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","feature"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$feature)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$feature)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

merged <- cbind(subject, y, x)

#extract on cols with mean and std.
mean_std <- select(merged,subject, code, contains("mean"), contains("std"))

#take the activites DF, then subset the second column by choosing the rows code that corresponds , then pass to col code in mean_std DF
mean_std$code <- activities[mean_std$code, 2]

#rename everything to be more clear
names(mean_std)[2] = "activity"
names(mean_std)<-gsub("Acc", "Accelerometer", names(mean_std))
names(mean_std)<-gsub("Gyro", "Gyroscope", names(mean_std))
names(mean_std)<-gsub("BodyBody", "Body", names(mean_std))
names(mean_std)<-gsub("Mag", "Magnitude", names(mean_std))
names(mean_std)<-gsub("^t", "Time", names(mean_std))
names(mean_std)<-gsub("^f", "Frequency", names(mean_std))
names(mean_std)<-gsub("tBody", "TimeBody", names(mean_std))
names(mean_std)<-gsub("-mean()", "Mean", names(mean_std))
names(mean_std)<-gsub("-std()", "STD", names(mean_std))
names(mean_std)<-gsub("-freq()", "Frequency", names(mean_std))
names(mean_std)<-gsub("angle", "Angle", names(mean_std))
names(mean_std)<-gsub("gravity", "Gravity", names(mean_std))


# create a second tidy data set with the average of each variable for each activity and each subject
group<-group_by(mean_std,subject, activity)
DF_Final<-summarise_all(group,mean)

write.table(DF_Final, "DF_Final.txt", row.name=FALSE)


