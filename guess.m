% Michael Omori
% Summer 2016

% This program guesses the time a sample has been exposed to pollutants.
% Input data is time x intensity, 1st column are times.

% TO DO: Multiple iterations and methods, store data, choose best

% constants
ORDER = 2; % order for polynomial fit
ITERS = 1; % number of iterations to train and test
TRAIN_R = 0.5; % percent to train on
TEST_R = 0.5; % percent to test on

% read in data
files = dir('**.xlsx');
methods = length(files);

% output data
%time_guesses = zeros(intervals,values, ITERS); % stores time guesses
r2_guess_all = zeros(1,methods, ITERS); % stores r^2 for test
r2_ref_all = zeros(1,methods, ITERS); % stores r^2 for train
p_fits = zeros(1,methods, ITERS); % stores best poly fit for each method

for i=1:methods
    
    % set up
    name = files(i).name;
    data = xlsread(name);
    s = size(data);
    intervals = s(1);
    values = s(2) - 1;
    
    % dividing data up randomly
    [train_i, val_i, test_i] = dividerand(intervals*values, TRAIN_R, 0, TEST_R);
    x_ref = 1:length(train_i);
    y_time = 1:length(train_i);
    x_guess = 1:length(test_i);
    x_time = 1:length(test_i);
    
    % training data
    for j=1:length(train_i)
        x = ceil(train_i(j) / values);
        y = mod(train_i(j),values);
        if y==0
            y = values;
        end
        y = y+1;
        x_ref(j) = data(x,y); % calibration values
        y_time(j) = data(x,1); % calibration times
    end
    
    % test data
    for j=1:length(test_i)
        x = ceil(test_i(j) / values);
        y = mod(test_i(j),values);
        if y==0
            y = values;
        end
        y = y+1;
        x_guess(j) = data(x,y); % values to guess time for
        x_time(j) = data(x,1); % actual time values for x_guess
    end

    % fitting polynomials to data
    p = polyfit(x_ref,y_time,ORDER); % reference fit
    yfit = polyval(p,x_guess); % guessing values for time
    yactual = polyval(p,x_ref); % calibration values fitted

    % guessing residuals
    yresid = x_time - yfit;
    SSresid = sum(yresid.^2);
    SStotal = (length(x_time)-1) * var(x_time);
    
    % reference residuals
    actual_yresid = y_time - yactual;
    actual_SSresid = sum(actual_yresid.^2);
    actual_SStotal = (length(y_time)-1) * var(y_time);
    
    % accuracy
    rsq_actual = 1 - actual_SSresid/actual_SStotal; % train r^2
    rsq_guess = 1 - SSresid/SStotal; % test r^2
end
