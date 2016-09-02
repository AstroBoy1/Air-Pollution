% Michael Omori
% Summer 2016

% This program guesses the time a sample has been in the box and computes
% r^2. It takes in names and stores the guesses and r^2.

% constants
ORDER = 2; % order for polynomial fit
METHODS = 1; % number of methods to compare
SAMPLES = 4; % number of samples to guess
INTERVALS = 4;

files = dir('**.xlsx');

% output data
time_guesses = zeros(METHODS,SAMPLES); % stores time guesses
actual_time = zeros(METHODS,SAMPLES); % stores actual times
r2_guess_all = zeros(1,METHODS); % stores r^2 for guesses
r2_ref_all = zeros(1,METHODS); % stores r^2

for i=1:METHODS
    % read data
    name = files(i).name
    data = xlsread(name);
    x_guess = data(1,1:SAMPLES); % values to guess time for
    x_ref = data(2,1:INTERVALS); % calibration values
    y_time = data(3,1:INTERVALS); % calibration times
    initial_values = data(4,1:SAMPLES); % initial values
    x_time = data(5,1:SAMPLES); % actual time values for x_guess
    actual_time(i,:) = x_time; % storing data

    % fitting polynomials to data
    p = polyfit(x_ref,y_time,ORDER); % reference fit
    y_initial = polyval(p,initial_values);
    yfit = polyval(p,x_guess); % guessing values for time
    yfit(2:SAMPLES) = yfit(2:SAMPLES) - abs(y_initial(2:SAMPLES)); % adjust values assuming same starting value
    yfit(1) = 0;
    yfit = yfit(1:SAMPLES); 
    time_guesses(i,:) = yfit; % storing data
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
    rsq_actual = 1 - actual_SSresid/actual_SStotal;
    r2_ref_all(i) = rsq_actual; % storing data
    rsq_guess = 1 - SSresid/SStotal;
    r2_guess_all(i) = rsq_guess; % storing data
end
