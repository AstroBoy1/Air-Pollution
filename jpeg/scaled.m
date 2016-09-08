% Michael Omori
% Summer 2016

% This program calculates the scaled intensity values

scaled_data = 1:nfiles;
labels = 1:REFERENCES;

for i=1:nfiles
    p = polyfit(data(1:10,i)', actual, 2);
    scaled_data(i) = p(1)*data(REFERENCES+1,i)^2 + p(2)*data(REFERENCES+1,i)+p(3);
end

% saves data
xlswrite('scaled_data.xlsx', labels', 1, 'A2');
xlswrite('scaled_data.xlsx', data, 1, 'B2');
xlswrite('scaled_data.xlsx', {'material'}, 1, 'A11');
xlswrite('scaled_data.xlsx', {'scaled'}, 1, 'A12');
xlswrite('scaled_data.xlsx', scaled_data, 1, 'B12');