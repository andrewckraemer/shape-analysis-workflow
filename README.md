# shape-analysis-workflow
With image files, digitize 2D landmarks of objects, create '.tps' files containing landmark information for multiple objects, use '.tps' files to project into Procrustes shape space and run statistical inference.

This workflow assumes the user is digitizing gastropod snail shells, although the workflow is the same for all objects.

Radiograph --> Images for Digitization
1)	Scan radiographs using standardized equipment. The formatting of the scanner is important if you plan to throw all the scans into the same processing batch (the pixel density is relevant for setting the scale).
2)	All radiographs that use different x-ray settings or scale bars need to be put in different batches. Everything after this is assuming these settings are consistent, allowing for things to be batched.
3)	Make copies of all scans depending on how many shells are on a radiograph, then crop and rename each image to only include a single shell. Be very careful that you do not resave at a different pixel density here or the size measurements will not be the same across images. I use jpegs, but the file format is not terribly important, as long as they are all consistent.
4)	For at least one shell in each batch (I like to make sure I have one per radiograph) you will need to widen the scope of the image to include the scale bar. This will be important to establish a scale factor for your tps files. If everything is done the same way within each batch a single scale factor is sufficient (you can simply apply it to all landmark sets during the digitization process). I end up estimating the scale factor from all of these different scale bar images and find a mean scale factor. The only difference among them should be due to measurement error.

Images for digitization --> landmarks

5)	At this point I find it easiest to set up smaller batches for digitization because it can be easy to lose track of where you are in the digitization process and either skip a shell or do one twice – you don’t want to do either of these things. It is easy to string together .tps files after digitization of the entire dataset.
6)	I use 20-40 objects per set and put each one in its own folder. Within that folder you will want two additional files: the R script for digitization (‘digitization.r’) and a tiny csv file that identifies the sliding semi-landmarks and their arrangement (‘curveslide.csv’)
7)	From this step onward I assume you have a basic understanding of how to use R. If you have issues that are not digitization-specific, you can refer to any of your mentors for help – we spend a lot of time in R, so we probably have an answer for you!
8)	First make sure you are in the correct working directory with the image files you want to digitize
9)	Load the ‘geomorph’ library in R
10)	Run the filelist code to create a list of images you plan to digitize for this session
11)	Use the ‘digitize2d’ function to begin digitization. At this point be ready to run all the digitization for this batch. It is unnecessarily tricky and problematic to pause in the middle of a session and restart later, which is why I split the images into manageable batches. Still, they can take a while. Until you know exactly how long a batch will take you, make sure you have enough time set aside. The first batches take longer than you expect they will
12)	Once you run this line of code a new image window will pop up for you to place the landmarks. I recommend you do not use RStudio to run R when digitizing, as the image window produced here will be smaller than you might like. The bigger this window, the easier digitization will be
13)	Arrange your windows so you can simultaneously view the image window and your R console. You will have to periodically bounce back and forth between the two during landmark placement.
14)	Begin placing landmarks. Below I have tips for how to place them as accurately as possible on a snail shell.
a)	There are 15 landmarks. The first 8 are ‘hard’ landmarks, meaning they stay put during analysis, while the remaining 6 are ‘sliding’ semilandmarks, which 'wiggle' a bit during the analysis stages along the outer lip of the aperture
b)	Landmark 1: This is placed near the base of the shell, where the outer wall of the last body whorl meets the aperture. This intersection is often clear, but sometimes difficult to place. If you were to draw a straight line along the lower inner lip of the aperture and another line along the lower outer body whorl, the intersection of the lines is where you would place this landmark
c)	Landmark 2: This is placed at the columellar fold that is typically approximately midway up the inner lip of the aperture
d)	Landmarks 3-7 are placed at the lower suture points between the whorls. In the case of N. achatinellinus, which has a bead on the suture line, use the upper suture point of the two options (let me know if you need clarification here)
e)	Landmark 8 is placed at the apex of the shell
f)	Landmark 9 is placed at the midpoint of the outer lip of the aperture between points 1 and 3.
g)	Landmark 10 is placed midway between 1 and 9 on the outer lip of the aperture
h)	Landmark 11 is placed midway between 9 and 3 on the outer lip of the aperture
i)	Landmark 12 is placed midway between 1 and 10 on the outer lip of the aperture
j)	Landmark 13 is placed midway between 10 and 9 on the outer lip of the aperture
k)	Landmark 14 is placed midway between 9 and 11 on the outer lip of the aperture
l)	Landmark 15 is placed midway between 11 and 3 on the outer lip of the aperture
m)	These arrangement may seem odd, but it allows for a more evenly distributed placement of landmarks on a regular basis. The exact placement of each of the sliding semilandmarks is not crucial for shape analysis, but it is important to make sure you are on the outer lip of the aperture and that the landmarks are approximately equally spaced
15)	 Once all landmarks have been placed for a shell, R will ask you if you want to continue on to the next specimen. If you are happy with your work you simply type in ‘y’ in the R console and hit ‘return’ to move on to the next shell. Continue until you have placed all landmarks for all images in your folder. At this point congratulations, you are done with this batch!
16)	If you find that you made a mistake while placing landmarks, you will have to click through the rest of the points until you finish the shell. Then when prompted, type in ‘n’ in the R console and hit ‘return’ to end your session early so you can fix your mistake. At this point the landmark-placing session will end early.
17)	You will need to open the ‘.tps’ file that contains your landmark positions and find the shell with the mistakes. It will be the last shell with numbers (all the other shells you still haven’t done are full of 0s). Copy the 0s from the next shell that you haven’t yet done – but do not copy the name of the shell – and paste the 0s in the shell that you made the mistake on in place of the numbers with mistakes
18)	Save the ‘.tps’ file and close it.
19)	Now you can go back into R and run the ‘digitize2d’ function; it will start up where you left off.

Landmarks --> shape variables

20)	Before you conduct shape analysis you will need to enter in the scaling factor for the image. Essentially this makes explicit the number of mm per pixel. Once the scale factor is entered we can compare the shape of objects from different types of photos. As long as all the images within the batch are taken identically, a single scale factor is sufficient for the entire batch. 
21)	To enter the scaling factor, you need to go into the tps file and add a scale line before each ID line as follows (in images that are not from the training set the scale factor will be different):
a)	SCALE=0.0572
22)	Open the ‘shape_analysis.R’ script
23)	Set your working directory to the folder with your .tps file and semilandmark .csv file
24)	Follow the instructions in the R script
25)	The ‘GPA_data’ object that is produced has a lot of parts, each of which are potentially useful:
a)	coords: the ‘GPA_data$coords’ object contains all the Procrustes shape variables we can use for statistical shape analyses
b)	Csize: the ‘GPA_data$Csize’object contains the centroid size information for each shell, which is the average Euclidean distance between the weighted center point of all the landmarks in shape space and all the landmarks. It is one estimate of shell size among many others.
c)	…among others
26)	The R script should have most of the instructions required to run most analyses. For more particular questions, ask me! Good luck!
