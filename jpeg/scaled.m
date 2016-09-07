% Michael Omori
% Summer 2016

% This program calculates the scaled intensity values

scaled_data = 1:nfiles;
scaled_data2 = 1:nfiles;
labels = 1:num_references;

for i = 1:nfiles
    % reflectance values for gray scale cards
    actual = [6,11,23,33.5,45.8,58.2,70.2,82.6,94.6,110.6]; 
    % reference intensity values
    p1 = polyfit(data(1:5,i)', actual(1:5), 1);
    p2 = polyfit(data(6:10,i)', actual(6:10), 1);
    slope = (p1(1)+p2(1)) / 2;
    scaled_data(i) = slope * (data(num_references+1,i)-data(1,i)) + actual(1);
    
    p3 = polyfit(data(1:10,i)', actual(1:10), 2);
    scaled_data2(i) = p3(1)*data(num_references+1,i)^2 + p3(2)*data(num_references+1,i)+p3(3);
end

% saves data
xlswrite('scaled_data.xlsx', data, 1, 'B2');
xlswrite('scaled_data.xlsx', scaled_data, 1, 'B12');
xlswrite('scaled_data.xlsx', scaled_data2, 1, 'B13');
xlswrite('scaled_data.xlsx', labels', 1, 'A2');
xlswrite('scaled_data.xlsx', {'material'}, 1, 'A11');
xlswrite('scaled_data.xlsx', {'scaled1'}, 1, 'A12');
xlswrite('scaled_data.xlsx', {'scaled2'}, 1, 'A13');

'finish calculating scaled data'
