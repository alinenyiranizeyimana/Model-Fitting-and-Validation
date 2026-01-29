
clear all; close all; clc
data = load("/MATLAB Drive/Data_class.mat")


x1 = data.x1;
x2 = data.x2;

x = [x1  x2];

y = data.y;

n= length(y);

x_all = [x x(:,2).^2];

b = x_all\y

predicted_fitted = x_all * b

plot(1:n, y,'o', 1:n, predicted_fitted);
title("MOdlel fit")