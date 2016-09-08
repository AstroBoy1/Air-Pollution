% Michael Omori
% Summer 2016

% This program sets up the automatic cropping for crop.m

nfiles = length(imagefiles);
crop_boundaries = zeros(REFERENCES+1, 4);
crop_c = 12;

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
    ymin = crop_rect(2) + crop_rect(4) * 7 / crop_c;
    else
    %card pointing down
    ymin = crop_rect(2) + crop_rect(4) * 3 / crop_c;
    end
    crop_size = crop_rect(3) / crop_c;
    crop_boundaries(i, :) = [xmin, ymin, crop_size, crop_size];
end

m = msgbox('crop the material');
[~, crop_rect] = imcrop(sceneImage1);
delete(m);
crop_boundaries(REFERENCES+1,:) = crop_rect;

close all;