% Michael Omori
% Summer 2016

% This program guesses the time a sample has been in the box and also
% computes r^2 after the guesses

% top row is values to guess, bottom row is reference
data = xlsread('guess.xlsx');

% constant for polyfit
order = 1;
initial = 4; % where the initial value is in the excel doc

x_guess = data(1,:); % values to guess time for
x_ref = data(2,:); % calibration values
y_time = data(3,:) % calibration times

p = polyfit(x_ref,y_time,order); % reference fit
yfit = polyval(p,x_guess); % guessing values for time
yfit = yfit - yfit(initial) % adjust values assuming same starting value
yactual = polyval(p,x_ref);

% assumes the time and guessed time match up
% guessing residuals
% yresid = y_time - yfit;
% SSresid = sum(yresid.^2);
% SStotal = (length(y_time)-1) * var(y_time);
% % reference residuals
% actual_yresid = y_time - yactual;
% actual_SSresid = sum(actual_yresid.^2);
% actual_SStotal = (length(y_time)-1) * var(y_time);
% 
% % accuracy
% rsq_actual = 1 - actual_SSresid/actual_SStotal;
% rsq_guess = 1 - SSresid/SStotal
