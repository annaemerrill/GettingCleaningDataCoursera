## Getting and Cleaning Data Course Project

The code in run_analysis.R completes the following functions to return a tidy data set.
The tidy data set contains the feature averages grouped by subject and activity.

First, the following files from the UCI HAR Dataset are accessed and stored in data frames:
* activity types: "activity_labels.txt"
* features: "features.txt" (see Code Book for more information)
* subjects in the test and training sets: "subject_test.txt", "subject_train.txt"
* feature data in the test and training sets: "X_test.txt", "X_train.txt"
* activities in the test and training sets: "y_test.txt", "y_train.txt"

Next, columns containing mean and standard deviation data are extracted and labeled.
This step is performed separately for both test and training data sets.

Next, activity and subject information is added to the test and training data sets.
Note that descriptive activity data is utilized.

The test and training data sets are combined into a single, tidy data set.

Finally, the combined data is grouped by activity and subject.
The means for all features are computed.
The resulting tidy data set is written to a .txt file in the working directory.

