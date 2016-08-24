% This program determines the brightness/intensity of an image
% The image should be grayscale or rgb format like jpg,png
% TIF doesn't work!
% lowest intensity is 0 (black), highest is 255(white)

white_data = 1:nfiles;
black_data = 1:nfiles;
material_data = 1:nfiles;
material_names = cell(1,nfiles);
gray_data = 1:nfiles;

one_data = 1:nfiles;
two_data = 1:nfiles;
three_data = 1:nfiles;
four_data = 1:nfiles;
five_data = 1:nfiles;
six_data = 1:nfiles;
seven_data = 1:nfiles;
eight_data = 1:nfiles;
nine_data = 1:nfiles;
ten_data = 1:nfiles;

for n = 1:14
    if n == 1
        type = 'white';
    elseif n == 2
        type = 'black';
    elseif n == 3
        type = 'material';
    elseif n == 4
        type = 'gray';
    elseif n == 5
        type = 'one';
    elseif n == 6
        type = 'two';
    elseif n == 7
        type = 'three';
    elseif n == 8
        type = 'four';
    elseif n == 9
        type = 'five';
    elseif n == 10
        type = 'six';
    elseif n == 11
        type = 'seven';
    elseif n == 12
        type = 'eight';
    elseif n == 13
        type = 'nine';
    else
        type = 'ten';
    end
        
    type_string = sprintf('*%s*.JPG', type);
    imagefiles = dir(type_string);

    intensity_data = 1:nfiles; % saves intensities of each image
    file_names = '';

    if nfiles >= 1
        for i=1:nfiles
           currentfilename = imagefiles(i).name;
           file_names = strcat(file_names,currentfilename);
           if n == 3
            material_names(i) = {currentfilename}; 
           end
           
           image = imread(currentfilename);

           [width, height, colors] = size(image);
           intensity = 0;

           % If grayscale image
           if colors == 1
               intensity = mean(mean(image));

           % If color image
           elseif colors == 3
               intensity = mean(mean(mean(image)));
           else
               'error: image is not grayscale nor rgb'
           end
           intensity_data(i) = intensity;
        end
    else
        'error: no jpg in folder'
    end
    if n == 1
        white_data = intensity_data;
    elseif n == 2
        black_data = intensity_data;
    elseif n == 3
        material_data = intensity_data;
    elseif n == 4
        gray_data = intensity_data;
    elseif n == 5
        one_data = intensity_data;
    elseif n == 6
        two_data = intensity_data;
    elseif n == 7
        three_data = intensity_data;
    elseif n == 8
        four_data = intensity_data;
    elseif n == 9
        five_data = intensity_data;
    elseif n == 10
        six_data = intensity_data;
    elseif n == 11
        seven_data = intensity_data;
    elseif n == 12
        eight_data = intensity_data;
    elseif n == 13
        nine_data = intensity_data;
    else
        ten_data = intensity_data;
    end
end

save('intensity_data.mat');

'finished intensityCalc'





