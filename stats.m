% Michael Omori
% Summer 2016

% This program finds the coefficient of variation of data from sizeTest
% between each camera picture of the same sample split up into different
% numbers of sections

% TO DO: r^2, stdev, slope

% constants
shots = 3;
samples = 4;

cov_all = zeros(samples,iterations);
points = zeros(1,shots);

% calculates stats
for i=1:iterations % sub images
    for j=1:samples
        c = zeros(i,i);
        for k=1:i % rows
            for L=1:i % columns
                for m=1:shots
                    points(m) = data_all(k, iterations*(j-1)+1 ...
                    +iterations*samples*(m-1)+(L-1), i);
                end
                c(k,L) = std(points) / mean(points);
            end
        end
        cov_all(j,i) = mean(mean(c));
    end
end

xlswrite('coefficient of variation.xls', cov_all);