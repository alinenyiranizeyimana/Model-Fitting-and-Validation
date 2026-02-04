clear all; close all; clc


X_data = [1:2:8, 9 13 17]';
Y = [2.00 3.60 4.29 4.67 4.91 5.20 5.37]';

fun = @(theta, x)  theta(1) * x ./  (theta(2) + x);

theta_guess =[100, 50];

%%

% theta(1) can be any from - infinity while 
% theta(2) should be greater than 1 to avoid any error that can occur 

lb = [-Inf, 0];    
ub = [ Inf, Inf];

[thmin_optimized,ssmin_errors_estimated] = lsqcurvefit(fun,theta_guess,X_data ,Y);

thmin_optimized

yfit_=fun(thmin_optimized,X_data);

yfit_

figure;
plot(X_data,Y,'o',X_data,yfit_)

