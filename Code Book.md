The run_analysis.R script executes the steps of course project’s instructions.

Download dataset and unzip to folder UCI HAR Dataset

Assign each data to variables

Merge  training and the test datasets to create one data set
x dataset merges x_train and x_test using rbind() function
y dataset merges y_train and y_test using rbind() function
subject dataset merges subject_train and subject_test using rbind() function
merged dataset merges subject, y and x datasets using cbind() function

Subset the dataset 'merged'- only columns subject and code- measuring mean and standard deviation for each measurement. Call new dataset 'mean_std'

Rename the activities in the dataset per the second column of the 'activities' dataset

Create a second tidy dataset with the average of each variable for each activity and each subject by grouping on activity and subject. save to 'DF_Final'

write 'DF_Final' into a FinalData.txt file.
