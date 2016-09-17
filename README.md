# Air-Pollution
passive sampling

If you want to run the manual version, download everything in the manual folder.
If you want to run the auto version, download everything in the auto folder including the zipped images in references.zip.
allCode contains all the code together and is the final version.

integrated.m runs an auto crop program that analyzes images.
rawIntensity.m does the same except with dng images.
sizeTest.m paritions an image into different sections.
stats.m analyzes images based on cov from sizeTest.
objectDetection.m detects object.
crop.m applies a crop from region detected by objectDetection.m
scaled.m gives intensity values scaled based on grayscale references.
apply_cmatrix.m and wbmask.m are used in rawIntensity.m
references.zip containes the ten gray scale cards used in objectDetection.m for the jpeg code.
guess.m guesses the time samples have been exposed using training data.
neural.m does the same as guess.m except using neural networks.
covAnalysis analyzes the coefficient of variation between different takes of the same sample and compares between different scaling versions.
auto is the automated version of the code, manual is the manual version of the code.

If using the automated method, which utilizes object detection, you need to put your reference images in the same folder.
