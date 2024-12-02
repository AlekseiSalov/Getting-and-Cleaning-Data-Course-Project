# Getting-and-Cleaning-Data-Course-Project

Description
This project aims to process and analyze sensor data collected from wearable devices for a human activity classification task. The data is used to recognize different types of activities (e.g., walking, sitting, standing, etc.) collected through smartphones.

The code follows these steps: it merges the data, cleans it, extracts necessary features, and then aggregates and writes the final dataset. The result is a tidy dataset that can be used for further analysis or modeling.

Execution Steps
1. Data Loading
The process starts by loading the required files:

features.txt: a list of features (sensor readings) that will be used for analysis.
subject_train.txt and subject_test.txt: data about the subjects involved in the experiment.
X_train.txt and X_test.txt: sensor measurement data for the training and test datasets.
y_train.txt and y_test.txt: activity labels for the training and test datasets.
2. Data Merging
The training and test datasets are merged into one combined dataset. This includes:

Merging subject data.
Merging activity label data.
Merging sensor measurement data (X).
3. Data Cleaning
After merging the data:

Column names are converted to lowercase and cleaned of any non-alphanumeric characters.
Each numeric activity code is replaced with its corresponding textual label (e.g., "WALKING" for code 1).
4. Feature Selection
For analysis, only those features containing mean (mean()) and standard deviation (std()) values for each sensor measurement are selected.

5. Data Aggregation
Data aggregation is performed as follows:

The mean value of each selected feature is calculated for each subject and activity.
All data is grouped by subject and activity.
6. Writing Final Dataset
The final dataset is written to a text file called tidy_data.txt. This file contains the mean values and standard deviations for each selected feature, for each subject and activity, making it convenient for further analysis.

Results
The final dataset includes the following columns:

subject: the subject identifier.
activity: the name of the activity (e.g., "WALKING").
tBodyAcc_mean_X, tBodyAcc_mean_Y, tBodyAcc_mean_Z: the mean acceleration values of the body along the X, Y, and Z axes.
tBodyAcc_std_X, tBodyAcc_std_Y, tBodyAcc_std_Z: the standard deviations of the body acceleration along the X, Y, and Z axes.
Other columns representing various sensor measurements.
This dataset is ready for further analysis, such as building machine learning models.

Libraries Used
dplyr: for data manipulation, aggregation, and transformation.
tidyr: for working with data formatting.
readr: for reading and writing data to files.
Requirements
To run this code on your machine, you will need to install the following R packages:

r
Копировать код
install.packages("dplyr")
install.packages("tidyr")
install.packages("readr")

Conclusion
This project provides an efficient solution for processing and analyzing wearable device data, including steps for data cleaning, aggregation, and preparation for further analysis.
