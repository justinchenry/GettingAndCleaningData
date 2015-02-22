# Overview

The run_analysis.R script does the following:

- Downloads the file from the URL
- Unzips the file contents
- Stores the relevant data into variables (data frames)
- Merges the data using rbind()
- names the columns according to features.txt
- Pulls the activies from activity_labels.txt
- Aggregates everything together into a final data set and exports to averages_data.txt
