% Michael Omori
% Summer 2016

% This program takes in a folder of images and outputs a spreadsheet of 
% the intensities of each material scaled to references to compensate for
% changes in lighting from imaging.
warning('off','images:initSize:adjustingMag')

tic
% constants
REFERENCES = 10;
SAMPLES = 6;
SHOTS = 3;
% reflectance values for gray scale cards
actual = [6,11,23,33.5,45.8,58.2,70.2,82.6,94.6,110.6]; 

imagefiles = dir('**.JPG');
first_imageName = imagefiles(1).name;

% extract features from the first image to use in image detection
sceneImage1 = imread(first_imageName);
sceneImage = rgb2gray(sceneImage1);
scenePoints = detectSURFFeatures(sceneImage);
[sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints);

run auto_Croper
run crop
run scaled
toc