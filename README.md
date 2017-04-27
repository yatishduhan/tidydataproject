# Getting and Cleaning Data Project

The purpose of this project is to demonstrate  ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis

# Package files

This project contains the following files:

* CodeBook.md file - this file contains the description about the data set used and what transformation tasks are done on the data to create the tidy data set

* run_analysis.R file - this file creates the tidy data following the transformation steps defined in the CodeBook.md.

* tidy.txt - tidy data set created using the run_analysis.R file

# Execution steps for this project

* Download the source dataset zip file on the local computer

* Unzip the data set file and set the working directory of your R/RStudio to the "UCI HAR Dataset" folder (you can use setwd command of R to set the working directory)
* Now you need to load the "run_analysis.R" file in your R environment and then execute the command - refinedataset()

* the above command will create the output tidy.txt file in your current working directory

* In case you want to give your own name to the output file, pass your outputfilename parameter to the refinedataset() function



