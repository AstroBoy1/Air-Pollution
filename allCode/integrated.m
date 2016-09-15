% Michael Omori
% Summer 2016

% This program takes in a folder of images and outputs a spreadsheet of 
% the intensities of each material scaled to references.

% computer vision and neural network toolbox needed
warning('off', 'all');

tic

% constants
REFERENCES = 10;
% reflectance values for gray scale cards
ACTUAL = [6,11,23,33.5,45.8,58.2,70.2,82.6,94.6,110.6]; 

nef = input('1 for dng, 0 for JPG, 2 for TIF ');
if nef == 0
    imagefiles = dir('**.JPG');
elseif nef == 1
    imagefiles = dir('**.dng');
    currentfilename = imagefiles(1).name;
    run rawIntensity
    sceneImage1 = lin_srgb;
else
    imagefiles = dir('**.TIF');
end

if nef ~= 1
    currentfilename = imagefiles(1).name;
end

auto = input('1 for automatic, 0 for manual ');

% extract features from the first image to use in image detection
if nef ~= 1
    sceneImage1 = imread(currentfilename);
end

if auto == 1
    sceneImage = rgb2gray(sceneImage1);
    scenePoints = detectSURFFeatures(sceneImage);
    [sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints);
    run auto_Croper
else
    run CROPer.m
end

run crop
run scaled

toc