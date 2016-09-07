% Michael Omori
% Summer 2016

% This program sets up the automatic cropping for crop.m

% loads the jpg images
imagefiles = dir('**.JPG');
nfiles = length(imagefiles); % Number of files found
material_names = cell(1,nfiles);
image = imread(imagefiles(1).name);
crop_boundaries = zeros(num_references+1, 4);

% obtains the crop boundaries for each reference card and material
for i=1:num_references+1
   if i == num_references+1
       ms = msgbox('select material to crop');
   else
       ms = msgbox(sprintf('select reference %d and double clip to crop', i));
   end
   pause(1);
   [~, rect] = imcrop(image);
   crop_boundaries(i,:) = rect;
   delete(ms);
end

close all;
'finished crop setup'