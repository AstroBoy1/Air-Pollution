# Air-Pollution
passive sampling

integrated.m runs an auto crop program that analyzes images.
rawIntensity.m does the same except with dng images.
sizeTest.m paritions an image into different sections.
stats.m analyzes images based on cov.
objectDetection.m detects object.
crop.m applies a crop from region detected by objectDetection.m
scaled.m gives intensity values scaled based on grayscale references.
apply_cmatrix.m and wbmask.m are used in rawIntensity.m
references.zip containes the ten gray scale cards used in objectDetection.m for the jpeg code.
guess.m guesses the time samples have been exposed using training data.
neural.m does the same as guess.m except using neural networks.
covAnalysis analyzes the coefficient of variation between different takes of the same sample.
