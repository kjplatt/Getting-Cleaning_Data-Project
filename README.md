# Getting-Cleaning_Data-Project

To run the script, the raw data should be in a file called "UCI HAR Dataset" in a filed named "Data" in your working directory.

The script performs the following sequence of steps.

1. The plyr, reshape2, and dplyr librarys are loaded.
2. The variable names of the raw data is read and stored in a variable called varNames.
3. The training data set is read into the trainingSet variable with the variable names as column names. 
4. Data indicating which subject corresponds to each row in the training data set is read into a vector named subjectTrain.
5. Data indicating which activity each row corresponds to is read into a vector named trainingLabels.
6. Steps 3, 4, and 5 are repeated for the test data set.
7. The data frames created containing the training data and the test data are combined.
8. Using data that describe the activity label, the activity codes are replaced by a description of the activity recorded on each row of the data frame from step 7.
9. A data frame is created from the data frame in step 7 consisting of the subject and activity variables, together with only those measurements on the mean and standard deviation for each feature.
10. A second tidy data set is created that consists of the average of each variable of the data set from step 9 by subject and activity.
