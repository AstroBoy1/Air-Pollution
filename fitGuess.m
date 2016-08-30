% Michael Omori
% Summer 2016

% This program caculates the best fit for intensity vs. time *
% concentration given training_data.xlsx

% 4 samples, 3 measurements
data = xlsread('training_data.xlsx');
samples = 4;
shots = 3;
dims = size(data);
intervals = dims(2);
time = 1.5;
xData = (0:time:intervals*time-time);
yData = zeros(1,intervals);

for i=1:samples
    for j=1:intervals
        total = 0;
        for k=1:shots
            total = total + data(shots*i-(shots-1)+k-1, j);
        end
        yData(1,j) = total / shots;
    end
    if i==1
        [fits1, gof1] = fit(xData',yData','poly2');
    elseif i==2
        [fits2, gof2] = fit(xData',yData','poly2');
    elseif i==3
        [fits3, gof3] = fit(xData',yData','poly2');
    else
        [fits4, gof4] = fit(xData',yData','poly2');
    end
end