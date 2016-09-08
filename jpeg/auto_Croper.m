% Michael Omori
% Summer 2016

% This program sets up the automatic cropping for crop.m

% constants
CROP_C = 12;

nfiles = length(imagefiles);
time = round(nfiles * 1.5);
crop_boundaries = zeros(REFERENCES+1, 4);

% 10 reference crops and 1 material crop using crop_rect
% xmin, ymin, width, height

for i=1:REFERENCES
    name = sprintf('value%d.png', i);
    boxImage1 = imread(name);
    run objectDetection
    xmin = crop_rect(1) + crop_rect(3) / 2;
    %find crop dimensions
    if i <= 5
    %card pointing up
    ymin = crop_rect(2) + crop_rect(4) * 7 / CROP_C;
    else
    %card pointing down
    ymin = crop_rect(2) + crop_rect(4) * 3 / CROP_C;
    end
    crop_size = crop_rect(3) / CROP_C;
    crop_boundaries(i, :) = [xmin, ymin, crop_size, crop_size];
end

crop_rect(1) = crop_rect(1) + crop_rect(3) * 2.3;
crop_rect(3) = crop_size * 2.5;
crop_rect(4) = crop_size * 2.5;
crop_boundaries(REFERENCES+1,:) = crop_rect;

close all;