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
fitGuess.m approximates a relationship using training and test data.
