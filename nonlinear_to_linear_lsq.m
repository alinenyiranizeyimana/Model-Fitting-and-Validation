clear; close all; clc;
X = [2:5:30]'; % X(input) data
Y = [0.8 0.5 0.3 0.2 0.1 0.07]'; % Y(response) data
n = length(X); % extract the length of data
XX = [ones(n,1) -X]; % Define the coefficient matrix
YY = log(Y); % log transformation
params = XX\YY; % estimate the parameters
theta1 = exp(params(1)); % recover the original parameter values
theta2 = params(2);
theta = [theta1, theta2];
Yfit = theta1*exp(-theta2*X); % Get the fitted values
figure;
plot(X,Y,'o',X,Yfit) % plot data and fitted values
title('model fit');
grid on


%% EXAMPLE

