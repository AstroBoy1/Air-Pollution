% Michael Omori
% Summer 2016

% This program takes in a foler of images and outputs a spreadsheet of 
% the intensities of each material scaled to references to compensate for
% changes in lighting from imaging.

tic;

% constants
REFERENCES = 10;
ACTUAL = [6,11,23,33.5,45.8,58.2,70.2,82.6,94.6,110.6]; 

run CROPer
run crop
run scaled

toc;