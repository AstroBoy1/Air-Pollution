% This program crops the image into black, white, and material

load('rect_data.mat');
imagefiles = dir('**.JPG');     
nfiles = length(imagefiles); % Number of files found

for i=1:nfiles
    currentfilename = imagefiles(i).name;
    image = imread(currentfilename);
    
    %rect is saved as [xmin ymin width height]
    cropped_white = imcrop(image, rect_white);
    cropped_black = imcrop(image, rect_black);
    cropped_material = imcrop(image, rect_material);
    cropped_gray = imcrop(image, rect_gray);
    
    cropped_one = imcrop(image, rect_one);
    cropped_two = imcrop(image, rect_two);
    cropped_three = imcrop(image, rect_three);
    cropped_four = imcrop(image, rect_four);
    cropped_five = imcrop(image, rect_five);
    cropped_six = imcrop(image, rect_six);
    cropped_seven = imcrop(image, rect_seven);
    cropped_eight = imcrop(image, rect_eight);
    cropped_nine = imcrop(image, rect_nine);
    cropped_ten = imcrop(image, rect_ten);
    
    black_name = strcat('black', currentfilename);
    white_name = strcat('white', currentfilename);
    material_name = strcat('material', currentfilename);
    gray_name = strcat('gray', currentfilename);
    
    one_name = strcat('one', currentfilename);
    two_name = strcat('two', currentfilename);
    three_name = strcat('three', currentfilename);
    four_name = strcat('four', currentfilename);
    five_name = strcat('five', currentfilename);
    six_name = strcat('six', currentfilename);
    seven_name = strcat('seven', currentfilename);
    eight_name = strcat('eight', currentfilename);
    nine_name = strcat('nine', currentfilename);
    ten_name = strcat('ten', currentfilename);
    
    imwrite(cropped_material, material_name);
    imwrite(cropped_black, black_name);
    imwrite(cropped_white, white_name);
    imwrite(cropped_gray, gray_name);
    
    imwrite(cropped_one, one_name);
    imwrite(cropped_two, two_name);
    imwrite(cropped_three, three_name);
    imwrite(cropped_four, four_name);
    imwrite(cropped_five, five_name);
    imwrite(cropped_six, six_name);
    imwrite(cropped_seven, seven_name);
    imwrite(cropped_eight, eight_name);
    imwrite(cropped_nine, nine_name);
    imwrite(cropped_ten, ten_name);
end

'finished crop'


