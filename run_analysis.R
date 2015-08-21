## Creates a tidy data set of variable averages grouped by activity and subject from the UCI Har Dataset

runAnalysis <- function(directory){
  
  ## Read in relevant files and assign them to tables
  filePath1 <- file.path(directory, "UCI Har Dataset")
  filePath2 <- file.path(filePath1, "test")
  filePath3 <- file.path(filePath1, "train")
  activityLabels <- read.table(file.path(filePath1, "activity_labels.txt"))
  dataFeatures <- read.table(file.path(filePath1, "features.txt"))
  testSubjects <- read.table(file.path(filePath2, "subject_test.txt"))
  testData <- read.table(file.path(filePath2, "X_test.txt"))
  testActivities <- read.table(file.path(filePath2, "y_test.txt"))
  trainSubjects <- read.table(file.path(filePath3, "subject_train.txt"))
  trainData <- read.table(file.path(filePath3, "X_train.txt"))
  trainActivities <- read.table(file.path(filePath3, "y_train.txt"))
  
  ## Find and select columns for mean and standard deviation
  meanStdColumns <- grep("mean|std", dataFeatures$V2, value = FALSE)
  meanStdColumnNames <- grep("mean|std", dataFeatures$V2, value = TRUE)
  testData <- testData[, meanStdColumns]
  trainData <- trainData[, meanStdColumns]
  
  ## Append column headers in dataFeatures to testData and trainData 
  colnames(testData) <- meanStdColumnNames
  colnames(trainData) <- meanStdColumnNames
  
  ## Append columns of activity and subject information to testData and trainData
  testData <- mutate(testData, "Activity" = activityLabels$V2[testActivities$V1], "Subject" = testSubjects$V1)
  trainData <- mutate(trainData, "Activity" = activityLabels$V2[trainActivities$V1], "Subject" = trainSubjects$V1)
  
  ## Combine testData and trainData (tidy data set #1)
  combinedData <- rbind(testData, trainData)
  
  ## Group data by subject and activity and calculate averages of all variables (tidy data set #2)
  by_ActivitySubject <- group_by(combinedData, Activity, Subject)
  groupAveragesData <- summarise_each(by_ActivitySubject, funs(mean))
  
  ## Write out tidy data set #2 to table
  write.table(groupAveragesData, "variableAvgsByActivitySubject.txt", row.names = FALSE)

}