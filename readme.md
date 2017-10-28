# Getting-and-Cleaning-Data-Week-4-Assignment

This repo was created to finish the assignment for week 4 of Getting and Cleaning Data Coursera course.
* First, download and unzip the data file into your R working directory.
* Second, download the R source code into your R working directory.
* Finally, execute R source code to generate tidy data file.

### Data description
The variables in the data X are sensor signals measured with waist-mounted smartphone from 30 subjects. The variable in the data Y indicates activity type the subjects performed during recording.

### Code explaination
The code combined training dataset and test dataset,  and extracted partial variables to create another dataset with the averages of each variable for each activity.

### New dataset
The new generated dataset contained variables calculated based on the mean and standard deviation. Each row of the dataset is an average of each activity type for all subjects.

### The code was written based on the instruction of this assignment
To start with read training and test dataset, variable names and subject index into R environment.

1. Merges the training and the test sets to create one data set.
Use command rbind to combine training and test set
2. Extracts only the measurements on the mean and standard deviation for each measurement.
Use grep command to get column indexes for variable name contains "mean()" or "std()"
3. Uses descriptive activity names to name the activities in the data set
Convert activity labels to characters and add a new column as factor
4. Extract only the data on mean and standard deviation
5. Tidy the column names
Give appropriate names for all variables and remove instances of "-", "(" and ")", use camel casing for new variable names
5. Combine all data
Combining all data into one using cbind
6. Grouped mean for each subject based on activity
Now that all relevant data is in one place, further merging and generating the mean based on each activity done by each subject
7. Storing the generated data into a file