##Donwload the data (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ) and extract it to the working directory

##Assemble the training data
xtrain <- read.table("./getdata-projectfiles-UCI HAR Dataset/train/X_train.txt") ##raw results data for training sets
ytrain <- read.table("./getdata-projectfiles-UCI HAR Dataset/train/y_train.txt") ##the activities that gave the raw results
subjecttrain <- read.table("./getdata-projectfiles-UCI HAR Dataset/train/subject_train.txt") ##the subject that did the activity

trainingdataset <- cbind(subjecttrain, ytrain, xtrain)

##Assemble the test data
xtest <- read.table("./getdata-projectfiles-UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./getdata-projectfiles-UCI HAR Dataset/test/y_test.txt")
subjecttest <- read.table("./getdata-projectfiles-UCI HAR Dataset/test/subject_test.txt")

testdataset <- cbind(subjecttest, ytest, xtest)

##Merge the two data sets
totaldataset <- rbind(trainingdataset, testdataset)

##Name the columns
features <- read.table("./getdata-projectfiles-UCI HAR Dataset/features.txt")
variablenames <- features[,2]
colnames(totaldataset) <- c("subject", "activity", as.vector(variablenames))

##which x values are mean and std?
meanstdpositions <- grep(pattern = "mean|std", x = features[,2])
meanstd <- totaldataset[, c(1, 2, 2+meanstdpositions)] ##mean and sd measurements with subject and activity
meanstd2 <- totaldataset[, 2+meanstdpositions] ##mean and sd measurements alone

##Name activities
activitylabels <- read.table("./getdata-projectfiles-UCI HAR Dataset/activity_labels.txt")
totaldataset$activity <- factor(totaldataset$activity, levels = activitylabels[,1], labels = activitylabels[,2])

meanstd3 <- totaldataset[, c(1, 2, 2+meanstdpositions)] ##mean and sd measurements with subject and named activity

##New tidy data set
library(reshape2)
temp <- melt(totaldataset, id.vars = c("subject", "activity"))
tidydataset <- dcast(temp, subject + activity ~ variable, mean)

##Output tidy data set
write.table(tidydataset, "tidydataset.txt", row.names = FALSE)