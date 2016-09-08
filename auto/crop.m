% Michael Omori
% Summer 2016

% This program crops the references and materials for each image and
% stores intensity information in the variable data

data = zeros(REFERENCES+1,nfiles);

% crops each image
for i=1:nfiles
    currentfilename = imagefiles(i).name;
    if nef == 0
        image = imread(currentfilename);
    else
        run rawIntensity
        image = lin_srgb;
    end
    for j=1:REFERENCES+1
        cropped_image = imcrop(image, crop_boundaries(j,:));
        data(j,i) = mean(mean(mean(cropped_image)));
    end
end