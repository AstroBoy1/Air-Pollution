% Michael Omori
% Summer 2016

% This program analyzes consistency between measurements
% by comparing coefficient of variations

% variables
s = zeros(1,SAMPLES);
m = zeros(1,SAMPLES);
c = zeros(3,SAMPLES);
ave_cov = zeros(1,3);

% data analysis
for i=1:SAMPLES
    a = zeros(1,SHOTS);
    for j=0:SHOTS-1
        a(j+1) = data(num_references+1,i+j*SHOTS);
    end
    s(i) = std(a);
    m(i) = mean(a);
    c(1,i) = s(i)/m(i);
end

for i=1:SAMPLES
    a = zeros(1,SHOTS);
    for j=0:SHOTS-1
        a(j+1) = scaled_data(i+j*SHOTS);
    end
    s(i) = std(a);
    m(i) = mean(a);
    c(2,i) = s(i)/m(i);
end

for i=1:SAMPLES
    a = zeros(1,SHOTS);
    for j=0:SHOTS-1
        a(j+1) = scaled_data2(i+j*SHOTS);
    end
    s(i) = std(a);
    m(i) = mean(a);
    c(3,i) = s(i)/m(i);
end

for i=1:3
    ave_cov(i) = mean(c(i,:));
end

xlswrite('cov.xlsx', ave_cov);
