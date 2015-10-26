#Load necessary libraries
library(plyr)
library(reshape2)
library(dplyr)

#Load the data
#Get the variable names
features = read.table("Data/UCI HAR Dataset/features.txt")
varNames = features[,2]

#Get the training data set, a vector of information about the training subjects,
#and a vector of information about training activities, 
#and bind them together into a single data frame.
trainingSet = read.table("Data/UCI HAR Dataset/train/X_train.txt", 
                         col.names = varNames)
subjectTrain = read.table("Data/UCI HAR Dataset/train/subject_train.txt", 
                          col.names = "Subject")
trainingLabels = read.table("Data/UCI HAR Dataset/train/y_train.txt", 
                            col.names = "Activity_Labels")
trainingSet2 = cbind(subjectTrain, trainingLabels, trainingSet)

#Get the test data set, a vector of information about the test subjects,
#and a vector of information about test activities, 
#and bind them together into a single data frame.
testSet = read.table("Data/UCI HAR Dataset/test/X_test.txt", 
                     col.names = varNames)
subjectTest = read.table("Data/UCI HAR Dataset/test/subject_test.txt", 
                         col.names = "Subject")
testLabels = read.table("Data/UCI HAR Dataset/test/y_test.txt", 
                        col.names = "Activity_Labels")
testSet2 = cbind(subjectTest, testLabels, testSet)

#Bind the training and test data sets together in a single data frame
dataSet = rbind(trainingSet2, testSet2)

#Replace the activity codes with descriptive words
activityLabels = read.table("Data/UCI HAR Dataset/activity_labels.txt", 
                            stringsAsFactors = FALSE)
for (i in 1:6){
     dataSet$Activity_Labels[dataSet$Activity_Labels == i] = activityLabels[i,2]
}

#Extract measurements on the mean and standard deviation for each measurement.
#Determine columns with mean and standard deviation measurements
meanSTDCols = vector(mode = "logical", length = length(names(dataSet)))
#Find columns with "mean" in the variable name
meanCols = grep("mean", names(dataSet), ignore.case = TRUE)   
for (i in meanCols){                   
     meanSTDCols[i] = TRUE
}
#Find columns with "mean" in the variable name
stdCols = grep("std", names(dataSet), ignore.case = TRUE)   
for (i in stdCols){                   
     meanSTDCols[i] = TRUE
}
#Include "Subject" and "Activity_Labels" columns
meanSTDCols[c(1, 2)] = TRUE
#Form a data frame consisting of the measurements on the mean and standard deviation
MSDataSet = dataSet[,meanSTDCols]

#Create a second tidy data set with the average of each variable for each
#subject and each activity
grpSubAct = group_by(MSDataSet, Subject, Activity_Labels)
len = length(names(MSDataSet))
vars = 3:len
summaryData = summarize_each(grpSubAct, funs(mean), vars = vars)
colnames(summaryData) = names(MSDataSet)

#Write the new tidy data set to a file
write.table(summaryData, file = "Summary_Data.txt", row.names = FALSE)
