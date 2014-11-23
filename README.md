##Getting and Cleaning Data "Course Project" 

I have followed the following steps in order to generate the tidy data set:  

1 - I have generated a function called 'run'  

2 - 1st step I have to set my working directory to the directory where the data exist.  

3 - To implement the 1st step in the project I followed the following steps:  

	a - Read both 'train' & 'test' data sets.  
	
	b - I have added one more column called 'group' to identify if the data is coming from 'train' or 'test' files (I have added this column for my analysis only).  
	
	c - I have bind the 2 data sets (train & test) into one data set 'all_data' using 'rbind' function.  
	
4 - To implement the 2nd step in the project I followed the following steps:  

	a - I have read the 'features.txt' file which contains all the fields names.  
	
	b - I have started to decide what are the required columns for (mean & std) using the 'grep' function.  
	
		Note: I considered ["mean()" & "std()"] while trying to get mean & std columns, so if there is a word like "mean" without "()", I will not consider.  
	
	c - After that I tried to get the IDs for those columns so that I can know the column index.  
	
	d - I have got a new data set which contains mean & std columns only which called 'mean_std_data'.  
	
5 - To implement the 3rd step in the project I followed the following steps:  

	a - I have loaded files which contain data for "Activity" & "Subject" for both the 2 groups ('train' & 'test').  
	
	b - I have bind the "Activity" data for both ('train' & 'test') in one column.  
	
	c - I have bind the "Subject" data for both ('train' & 'test') in one column.  
	
	d - I have given the new activity column name "activity_id".  
	
	e - I have given the new subject column name "subject".  
	
	f - I have added the 2 new columns ("activity_id" & "subject") to the data set.  
	
	g - I have loaded the "activity_labels.txt" file which contains the names of the activities.  
	
	h - I have merged the main data set with the activity label data set to get activity names instead of ids.  
	
6 - To implement the 4th step in the project I followed the following steps:  

	a - Since I have a data set of all column names but without the following ones ("activity_id", "group", "subject", "activity_name"), I have generated new 4 data frames to bind them to the list of all names.  
	
	b - I have assigned the column names in my list to the column names in the data set which contains the data.  
	
7 - To implement the 5th step in the project I followed the following steps:  

	a - I have used the 'aggregate' function to get the 'mean' and do group by (activity_name & subject), I have added the 'group' column to the group by for my understanding only.  
	
	b - I have saved my required columns in a variable called 'result'.  
	
	c - I have written the data set to a file called 'output.txt'.  
	
	
	