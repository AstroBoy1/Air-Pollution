% Michael Omori
% Summer 2016

% This program sets up the automatic cropping
% User selects initial crop positions

nfiles = length(imagefiles); % Number of files found
if nef ~= 1
    image = imread(imagefiles(1).name);
else
    image = sceneImage1;
end
crop_boundaries = zeros(REFERENCES+1, 4);

% obtains the crop boundaries for each reference card and material
for i=1:REFERENCES+1
   if i == REFERENCES+1
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