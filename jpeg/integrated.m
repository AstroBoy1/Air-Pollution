% Michael Omori
% Summer 2016

% This program takes in a folder of images and outputs a spreadsheet of 
% the intensities of each material scaled to references to compensate for
% changes in lighting from imaging.

tic;

% constants
num_references = 10;
SAMPLES = 6;
SHOTS = 3;

imagefiles = dir('**.JPG');
first_imageName = imagefiles(1).name;

run auto_Croper
run crop
run intensityCalc
run scaled

'data is saved in scaled_data.xlsx'

toc;
