% Michael Omori
% Summer 2016

% This program determines the intensity of each image
data = zeros(num_references+1,nfiles);

% calculates intensity of each image
for i = 1:num_references+1 % each reference and material
    if i == num_references+1
        type_string = '*material*.jpg';
    else
        type_string = sprintf('*value%d*.jpg', i-1);
    end
    imagefiles = dir(type_string);
    intensity_data = 1:nfiles;
    for j=1:nfiles % each image
       current_filename = imagefiles(j).name;
       image = imread(current_filename);
       intensity_data(j) = mean(mean(mean(image)));
    end
    data(i,:) = intensity_data;
end

'finished intensity calculations'