% Michael Omori
% Summer 2016

% This program guesses the time a sample has been exposed to pollutants.
% Input data is time x intensity, 1st column are times as xlsx excel file.

% display best

% constants
ORDER = 2; % order for polynomial fit
ITERS = 5; % number of iterations to train and test
TRAIN_R = 0.5; % percent to train on
TEST_R = 0.5; % percent to test on

% read in data
files = dir('**.xlsx');
methods = length(files);

name = files(1).name;
data = xlsread(name);
s = size(data);
intervals = s(1);
values = s(2) - 1;

% output data
time_guesses = zeros(methods,intervals*values*TEST_R, ITERS); % stores time guesses
actual_time = zeros(methods,intervals*values*TEST_R,ITERS); % stores actual time
r2_guess_all = zeros(methods, ITERS); % stores r^2 for test
r2_ref_all = zeros(methods, ITERS); % stores r^2 for train
p_fits = zeros(methods, ITERS, 3); % stores time v. intensity fits

for k=1:ITERS
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
        
        actual_time(i, :, k) = x_time; % store actual time values

        % fitting polynomials to data
        p = polyfit(x_ref,y_time,ORDER); % reference fit
        p_fits(i,k,:) = p; % store polyfit
        yfit = polyval(p,x_guess); % guessing values for time
        time_guesses(i,1:length(test_i),k) = yfit; % store guesses
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
        r2_ref_all(i,k) = rsq_actual; % store train r^2
        rsq_guess = 1 - SSresid/SStotal; % test r^2
        r2_guess_all(i,k) = rsq_guess; % store test r^2
    end
end

time_guesses = time_guesses(:,1:length(test_i),:);
actual_time = actual_time(:,1:length(test_i),:);

% save data
% each row is a method, each column is a value, each sheet is an iteration
for i=1:ITERS
    xlswrite('time_guesses.xlsx', time_guesses(:,:,i),i);
    xlswrite('actual_time.xlsx', actual_time(:,:,i),i);
end

% sheet 1 contains the guess r^2, sheet 2 contains the calibration r^2
xlswrite('accuracy.xlsx', r2_guess_all,1);
xlswrite('accuracy.xlsx', r2_ref_all,2);

xlswrite('fits.xlsx', p_fits(:,:,1),1);
xlswrite('fits.xlsx', p_fits(:,:,2),2);
xlswrite('fits.xlsx', p_fits(:,:,3),3);
