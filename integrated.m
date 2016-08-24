% This program runs CROPer.m, then crop, then intensity, then scaled
% It takes in a folder of images and outputs the intensities

close all

tic;
run CROPer
run crop
run intensityCalc
run scaled

delete(cm)
'all finished!'
'data is saved in scaled_data.xlsx'
toc;
close all