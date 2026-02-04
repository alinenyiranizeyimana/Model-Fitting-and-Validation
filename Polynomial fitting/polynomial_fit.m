
clc; clear all; close all;

x = linspace(-5,5, 100);
y_true2 = 0.5*x.^2 - 2*x + 3;   

%=========== Adding a noise 

%=========== Standard normal distributio mean 0 and var 1 with same size as
%=========== x 

y_noise = y_true2 + 2*randn(size(x));


constants_abc = polyfit(x, y_noise, 2)

%======== Passing data and constant to evaluate y 


y_fited_coeffic = polyval(constants_abc , x);






plot(x, y_true2 , x , y_noise, x , y_fited_coeffic,"k")

legend("True","Noise", "Fitted")