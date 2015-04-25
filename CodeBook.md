Input Data
The script assumes the UCI dataset is extracted in the local directory. 
test and train folders are in the current directory

Input data meaning

Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II). The X files are performance measures for each of the six activities.

Input data files

'features.txt': List of all performance features, like tBodyAcc-mean()

'activity_labels.txt': six activity labels.

'train/X_train.txt': Training set.

'train/y_train.txt': Training labels.

'test/X_test.txt': Test set.

'test/y_test.txt': Test labels.

Output data
The resulting cleandata.summary.txt data set includes mean and standard deviation variables for the following original variables,tBodyAcc, tGravityAcc, tBodyAccJerk, tBodyGyro, tBodyGyroJerk, tBodyAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag, fBodyAcc, fBodyAccJerk, fBodyGyro, fBodyAccMag, fBodyBodyAccJerkMag, fBodyBodyGyroMag, fBodyBodyGyroJerkMag. All three X, Y, Z directions are included.

The above variables where choosen as they included either mean or std in their original names.

Transformations
The script, run_analysis.R, does the following:

Load the various sparse data files from the dataset;
Merges the three test and three train files into a single data table;
Creates a smaller second dataset, containing only mean and std variables;
Computes the means of this secondary dataset, group by subject/activity;
Saves this last dataset to tidy_data.txt.
