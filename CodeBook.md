Codebook for Data Processing
This codebook describes the data processing and analysis steps used in the provided R script. The goal is to clean and transform raw data into a tidy dataset, focusing on extracting key features such as mean and standard deviation measurements for each activity and subject. Below is a detailed description of the variables, data transformations, and processes used in the code.

1. Data Collection
1.1 Input Data Files
The script processes data from the Human Activity Recognition (HAR) dataset, which contains sensor data collected from wearable devices for classifying human activity. The following files are read:

features.txt: Contains the names of the 561 features (sensor readings) used in the dataset.
subject_train.txt / subject_test.txt: Contains subject identifiers for training and testing data.
X_train.txt / X_test.txt: Contains the sensor readings for each subject in the training and test datasets.
y_train.txt / y_test.txt: Contains activity labels (coded integers) corresponding to the sensor readings for each subject.
1.2 Activity Labels
activity_labels.txt: Contains labels for the activity types (walking, running, sitting, etc.), which will be matched to the activity codes in y_train.txt and y_test.txt to replace numerical codes with descriptive activity names.
2. Data Processing Steps
2.1 Reading and Combining Datasets
The training and testing datasets for subjects, activity labels, and sensor readings (X_train and X_test) are read from their respective files.
The data from training and testing sets are merged (using rbind()) to create a unified dataset for subjects, activity labels, and sensor measurements.
2.2 Renaming Columns
The column names for the combined dataset (X_combined) are set to the feature names from the features.txt file, which describe the measurements taken by the sensors.
The subj_combined dataset is given a column name "subject", and the y_combined dataset is given the column name "act_id".
Descriptive activity labels are added to the y_combined dataset by matching the act_id values to the activity_labels dataset.
2.3 Data Cleanup
The column names are converted to lowercase, and any non-alphanumeric characters are replaced by underscores (_) to ensure valid column names.
3. Data Selection
3.1 Selecting Mean and Standard Deviation Columns
The script selects only the columns containing mean and standard deviation values by searching for "mean()" and "std()" in the feature names.
This results in two sets of columns: one containing the mean measurements (mean_columns) and the other containing standard deviation measurements (std_columns).
3.2 Extracting Relevant Data
The mean_data and std_data datasets are created by selecting the "subject", "activity", and the relevant mean or standard deviation columns from the combined dataset (complete_data).
4. Data Aggregation
4.1 Summarizing Data by Subject and Activity
The script calculates the average (mean) of each feature (sensor measurement) for each subject and activity combination using group_by() and summarise(). This results in two datasets:
final_mean: Contains the mean of each selected measurement (mean features) for each subject and activity.
final_std: Contains the mean of each selected measurement (standard deviation features) for each subject and activity.
The across() function is used to apply the mean() function across the relevant columns, while ensuring that missing values (NA) are ignored during the calculation.
4.2 Combining Final Data
The final_mean and final_std datasets are merged using a full join to create the final tidy dataset (final_data), which contains the mean and standard deviation values for each subject and activity.
5. Output
5.1 Writing Data to File
The final tidy dataset (final_data) is written to a text file named "tidy_data.txt" using the write.table() function. This file contains the summarized data with columns for subject, activity, and the mean values of the selected features.
6. Variables in the Tidy Dataset
The final dataset (final_data) includes the following columns:

subject: The identifier of the subject (1–30), representing the individual performing the activity.
activity: The activity label (e.g., "WALKING", "SITTING") corresponding to the activity performed by the subject.
tBodyAcc_mean_X, tBodyAcc_mean_Y, tBodyAcc_mean_Z: The mean values of the body acceleration in the X, Y, and Z directions, respectively, based on the sensor readings.
tBodyAcc_std_X, tBodyAcc_std_Y, tBodyAcc_std_Z: The standard deviation values of the body acceleration in the X, Y, and Z directions, respectively.
tGravityAcc_mean_X, tGravityAcc_mean_Y, tGravityAcc_mean_Z: The mean values of gravity acceleration in the X, Y, and Z directions.
tGravityAcc_std_X, tGravityAcc_std_Y, tGravityAcc_std_Z: The standard deviation values of gravity acceleration in the X, Y, and Z directions.
fBodyAcc_mean_X, fBodyAcc_mean_Y, fBodyAcc_mean_Z: The mean values of the frequency domain body acceleration in the X, Y, and Z directions.
fBodyAcc_std_X, fBodyAcc_std_Y, fBodyAcc_std_Z: The standard deviation values of the frequency domain body acceleration in the X, Y, and Z directions.
Additionally, there are many other features corresponding to different types of sensor measurements, such as body angular velocity, gravity, and jerk, in both the time domain and frequency domain.

7. Conclusion
The script processes the raw human activity recognition data by:

Combining the training and testing datasets,
Cleaning and labeling the data,
Extracting relevant features (mean and standard deviation),
Aggregating the data by subject and activity,
Writing the final summarized dataset to a text file for further analysis.
This results in a tidy dataset suitable for analysis, where each row corresponds to a subject-activity combination, and the columns represent various sensor measurements averaged over the activities.
