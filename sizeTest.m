% Michael Omori
% Summer 2016

% This program compares the intensity of an overall set of images and
% the intensity of them split into sub images. 
% It saves the data into excel documents.

% changeable constant
iterations = 10;

warning('off','MATLAB:xlswrite:AddSheet');

% read images and initialize variables
imagefiles = dir('**.JPG');
nfiles = length(imagefiles);
data = zeros(iterations,iterations,iterations);
rectangle = zeros(1,2);

% data collection
tic
for l=1:nfiles
    currentfilename = imagefiles(l).name;
    image = imread(currentfilename);
    if l==1
        m = msgbox('crop center');
        [new_image, rect] = imcrop(image);
        delete(m);
        size = size(new_image);
        size = size(1:2);
        smallest_d = min(size);
        
        m = msgbox('crop material');
        [material, material_rect] = imcrop(image);
        delete(m);
        
        rectangle(1) = smallest_d^2;
        area = material_rect(3) * material_rect(4);
        rectangle(2) = area;
    else
        new_image = imcrop(image,rect);
    end

    % saves data in each sheet
    for k=1:iterations
        num_blocks = k^2;
        length = num_blocks ^ (1/2);
        new_size = floor(smallest_d / length);
        square_crop = new_size * length;

        % crop and set up image arrays
        square_image = new_image(1:square_crop,1:square_crop,:);
        r = square_image(:,:,1);
        g = square_image(:,:,2);
        b = square_image(:,:,3);

        rows = ones(1,length);
        rows = rows.*new_size;

        % create sub images
        test_r = mat2cell(r,rows,rows);
        test_g = mat2cell(g,rows,rows);
        test_b = mat2cell(b,rows,rows);

        sums_r = cellfun(@(x) sum(x(:)),test_r);
        sums_g = cellfun(@(x) sum(x(:)),test_g);
        sums_b = cellfun(@(x) sum(x(:)),test_b);

        % store intensities of each sub image in mean_array
        mean_array = zeros(length,length);
        for i=1:length
           for j=1:length
               small_mean = (sums_r(i,j) + sums_g(i,j) + sums_b(i,j)) / 3 / (new_size^2);
               mean_array(i,j) = small_mean;
           end
        end
        data(1:length,1:length,k) = mean_array;
        name = sprintf('%s_data.xls', currentfilename);
        xlswrite(name, data(:,:,k), k);
    end
    xlswrite('pixel size.xls', rectangle);
    close all
end
toc
