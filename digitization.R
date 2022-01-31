# Written by Andrew Kraemer - last edited 7 April 2021
# Geometric Morphometric Lab Code. 

rm(list=ls()) # this code will clear your working environment so that you can start with a clean slate. It is helpful to run this line of code at the start of analyses.

##### Setting up the data: here you will load all the data files  #####
library(geomorph) # this library contains all the code for geomorphometric analysis. With it you can place landmarks, calculate shape variables, and run simple analyses

filelist<-list.files(pattern='.jpg') # This code will find all the image files for project 1 
#You will use the code below to walk through each file and place the appropriate landmarks. This step is the most difficult, and if you make a mistake, you will have to start over at the beginning, so work slowly and carefully. #####

digitize2d(filelist,nlandmarks=15,scale=NULL,"N001.tps",verbose=F) # USE THIS FUNCTION TO DIGITIZE LANDMARK INFORMATION FROM EACH SHELL IMAGE: open up each image in turn for landmark placement (place each set of landmarks in the SAME ORDER); hit 'y' between each shell to approve the set of landmarks and move on to the next
