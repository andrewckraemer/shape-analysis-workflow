# Written by Andrew Kraemer - last edited 8 April 2021
# Geometric Morphometric Shape Analysis Code. 

rm(list=ls()) # this code will clear your working environment so that you can start with a clean slate. It is helpful to run this line of code at the start of analyses.

##### Setting up the data: here you will load all the data files  #####
library(geomorph) # this library contains all the code for geomorphometric analysis. With it you can place landmarks, calculate shape variables, and run simple analyses

curves<-as.matrix(read.csv('curveslide.csv'))

landmark_data<-readland.tps('N001.tps',specID='ID',readcurves=T) # This will read in the raw landmark data - make sure you change the file name in the function as needed

GPA_data<-gpagen(landmark_data,curves=curves) # This takes your raw landmark data and standardizes them (by first centering, rotating, and scaling the landmarks - you don't have to know the details, but I would be happy to share them)

PCA_data<-gm.prcomp(GPA_data$coords) # This performs a principal components analysis of the Procrustes shape variables and extracts the component scores for each shell. 

PCA_data$x # This dataset we can use for statistical analysis and plotting in shape space

plot(GPA_data) # This illustrates the average landmarks and the variation of individual shells; each point represents a single landmark
plot(PCA_data) # This plots the shells in shape space; each point represents a single shell

grps<-c(rep('achat',2),rep('adel',20),rep('achat',20)) #simply a group factor that we can use to run some basic analyses


summary(procD.lm(PCA_data$x~grps)) # This is a Procrustes ANOVA to test the null hypothesis that all the groups of shells have the same mean shape. This and other analyses have changed a lot recently and have consequently become much more powerful than previous iterations. I have not yet had time to explore them fully. If you have a particular task you want to pursue, I can help you figure it out.
 

