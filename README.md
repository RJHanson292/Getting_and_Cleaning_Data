#README

run_analysis.R reads in the unzipped data (orinially found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) from the working directory. 

It then merges the training and test data into one large data set and names all the columns and activities. 

The R script also creates sub tables  containing just the mean/standard deviation variables but these remain within the R workplace for analysis

Finally the the R script outputs a tidy dataset containing the mean of each variable calculated for every subject activity pair 