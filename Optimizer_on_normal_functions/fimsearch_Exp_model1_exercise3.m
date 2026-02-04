
clear all; close all; clc


X_data = [1:2:8, 9 13 17]';
Y = [2.00 3.60 4.29 4.67 4.91 5.20 5.37]';

fun = @(theta, x)  theta(1) * x ./  (theta(2) + x);

theta_guess =[100, 50];

%=================== return one value
%+++++ If in same script no need to pass x and yobj pass since we can fetch
%them

%objective_fun_ss = @(theta) sum(  (Y - fun(theta, X_data)).^2);
%[theta_optmized_min, ss_min] = fminsearch(objective_fun_ss , theta_guess,[]);

objective_fun_ss = @(theta, X_obj_pass, Y_obj_pass) sum(  (Y_obj_pass - fun(theta, X_obj_pass)).^2);


[theta_optmized_min, ss_min] = fminsearch(objective_fun_ss , theta_guess,[],X_data, Y);

yfit = fun(theta_optmized_min, X_data);

figure;

plot(X_data, Y,'o',X_data,yfit)

legend('Data','Fit (fminsearch)','Location','best');

fprintf('theta1 = %.6f\ntheta2 = %.6f\nSSE = %.6g\n', theta_optmized_min(1), theta_optmized_min(2), ss_min);
