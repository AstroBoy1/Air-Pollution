% Michael Omori
% Summer 2016

% This program takes in a folder of images and outputs a spreadsheet of 
% the intensities of each material scaled to references to compensate for
% changes in lighting from imaging.
warning('off', 'all');

tic
% constants
REFERENCES = 10;
SAMPLES = 6;
SHOTS = 3;
% reflectance values for gray scale cards
actual = [6,11,23,33.5,45.8,58.2,70.2,82.6,94.6,110.6]; 

nef = input('1 for raw, 0 for jpeg ');
if nef == 0
    imagefiles = dir('**.JPG');
else
    imagefiles = dir('**.dng');
    run rawIntensity
    sceneImage1 = lin_srgb;
end
currentfilename = imagefiles(1).name;

% extract features from the first image to use in image detection
if nef == 0
    sceneImage1 = imread(currentfilename);
end
sceneImage = rgb2gray(sceneImage1);
scenePoints = detectSURFFeatures(sceneImage);
[sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints);

run auto_Croper
run crop
run scaled
toc