% Michael Omori
% Summer 2016

% This program crops the references and materials for each image

% crops each image
for i=1:nfiles
    currentfilename = imagefiles(i).name;
    material_names(i) = {currentfilename}; 
    image = imread(currentfilename);
    for j=1:num_references
        cropped_image = imcrop(image, crop_boundaries(j,:));
        name = strcat(sprintf('value%d', j-1), currentfilename);
        imwrite(cropped_image, name);
    end
    cropped_image = imcrop(image, crop_boundaries(j+1,:));
    name = strcat('material', currentfilename);
    imwrite(cropped_image, name);
end

'finished croping images'
